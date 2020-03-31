+++
title = "bash completion"
date  = "2019-23-07T00:57:05"
+++

احتمالا توی لینوکس (که اکثرا شل پیشفرضش bash هست) براتون پیش اومده که وقتی یک دستوری رو مینویسید و بعدش دکمه TAB رو میزنید یک سری از پارامتر های مورد قبول اون برنامه رو بهتون پیشنهاد میده. برای مثال وقتی مینویسم git و دکمه TAB رو میزنم مقادیر زیر رو بهم پیشنهاد میده


{{< highlight sh >}}
/p/bash-completion $ git
add                  format-patch         remote 
am                   fsck                 repack 
annotate             gc                   replace 
apply                get-tar-commit-id    request-pull 
archive              grep                 reset 
bisect               help                 revert 
blame                imap-send            rm 
branch               init                 shortlog 
bundle               instaweb             show 
checkout             interpret-trailers   show-branch 
cherry               log                  stage 
cherry-pick          merge                stash 
clean                mergetool            status 
clone                mv                   submodule 
commit               name-rev             subtree 
config               notes                tag 
describe             pull                 verify-commit 
diff                 push                 whatchanged 
difftool             rebase               worktree 
fetch                reflog               
filter-branch        relink
{{< /highlight >}}

در این پست قراره یه کوچولو یاد بگیریم چطور در bash این اتفاق میفته و یه کوچولو هم یاد میگیریم چطور برای برنامه های خودمون bash completion بنویسیم.

![let's go](/blog/images/pouriya.org-bash-completion-01.jpeg)

خوب اول یه برنامه نیاز داریم. یه اسکریپت ساده شل مینویسیم که هر چی به عنوان پارامتر بهش میدیم رو بهمون نشون میده.

{{< highlight sh >}}
/p/bash-completion $ echo '#! /bin/sh' > coolcmd
/p/bash-completion $ echo 'echo $@' >> coolcmd
/p/bash-completion $ cat coolcmd 
#! /bin/sh
echo $@
/p/bash-completion $ chmod a+x coolcmd 
/p/bash-completion $ ./coolcmd
{{< /highlight >}}

در مرحله اول شبنگ یا shebang رو ریختم تو فایل coolcmd. این خط به شل میگه برنامه ما با چه دستوری باید اجرا بشه که اینجا باید با /bin/sh یا شل معمولی اجرا بشه. در مرحله دوم هر پارامتری که به اسکریپت دادن ($@) رو با کمک echo نمایش دادم. بعدش هم با استفاده از cat کل محتویات رو یه نگاه مجدد انداختم و در آخر فایل رو به حالت قابل اجرا در آوردم. الانم میخوام تستش کنم.


{{< highlight sh >}}
/p/bash-completion $ ./coolcmd 

/p/bash-completion $ ./coolcmd a b c -f -foo "hello world"
a b c -f -foo hello world
{{< /highlight >}}

مصدوم آمادست.

![woohoo](/blog/images/pouriya.org-bash-completion-02.jpeg)

خوب bash چطوری میفهمه من برای این برنامم به چه پارامتر هایی نیاز دارم؟ کافیه به دایرکتوری زیر یه نگاهی بندازید. مثلا روی سیستم من (لینوکس مینت) اینا بود:

{{< highlight sh >}}
$ ls /etc/bash_completion.d/
apt-linux-mint  cryptdisks      desktop-file-validate
dkms            git-prompt      grub
insserv         libreoffice.sh  openvpn
pac
{{< /highlight >}}

البته این فقط یکی از جاهاییه که bash برای completion از فایل هاش استفاده میکنه و چون سر راسته ما هم از همینجا استفاده میکنیم. معمولا در این فایل ها از دستور complete برای completion استفاده شده (دستورات دیگه ای مثل compgen هم هستند). زمانی که bash لود میشه این فایل ها رو زیر رو رو میکنه و لیست کاملی از نحوه completion برای هر دستور رو در خودش جمع میکنه. برای مثال اگر دستور complete رو بزنید میتونید این لیست رو ببینید. من این دستور رو میزنم و کلمه apt رو فیلتر میکنم

{{< highlight sh >}}
/p/bash-completion $ complete | grep apt
complete -F _apt apt
{{< /highlight >}}

این دستور complete هزار تا پارامتر مختلف قبول میکنه و منم در این پست قرار نیست کل دستور complete رو توضیح بدم. همین قدر که بدونیم میتونیم با پارامتر F- یک تابع شل بهش بدیم کافیه. بعد از اون هم هر بار که دستورمون اجرا بشه و دکمه TAB رو بزنیم شل این تابع ما رو اجرا میکنه و متغیر های مختلفی رو بهش میده و ازش میخواد که در ادامه بررسیشون میکنیم. در مثال بالا هم هر بار دستور apt اجرا میشه تابع _apt رو اجرا میکنه. اینو از کجا فهمیده؟ از فایل apt-linux-mint در دایرکتوری /etc/bash_completion.d/. در این فایل این تابع رو نوشته و در خط اخرش هم گفته ازش استفاده کن. کافیه خط آخر رو با هم ببینیم:

{{< highlight sh >}}
/p/bash-completion $ tail -n 1 /etc/bash_completion.d/apt-linux-mint 
complete -F _apt apt
{{< /highlight >}}

یه فایل میسازم به نام coolcmd-completion و تابعمو توش مینویسم و در آخرش هم به کمک دستور complete به شل برای completion معرفیش میکنم. فعلا تابعمون فقط یه echo داره که ببینیم چطوری کار میکنه.


{{< highlight sh >}}
/p/bash-completion $ cat coolcmd-completion 
#! /bin/bash

_coolcmd() {
  echo oops
}

complete -F _coolcmd coolcmd

/p/bash-completion $ sudo mv coolcmd-completion /etc/bash_completion.d/
{{< /highlight >}}

خوب فایل رو هم انتقال دادم به دایرکتوری مورد نظر. برای این که کار بکنه باید یه شل جدید باز بکنیم (یا فایل .bashrc رو مجددا لود کنیم). من یه شل دیگه باز کردم و دستورمون رو نوشتم و هر بار دکمه TAB زدم یه oops رو صفحه بهم نشون داد

{{< highlight sh >}}
/p/bash-completion $ ./coolcmd oops
oops
oops
oops
oops
{{< /highlight >}}


![oops](/blog/images/pouriya.org-bash-completion-03.png)
البته این oops پیشنهاد نیست و فقط نشون میده با هر بار زدن TAB تابع ما اجرا میشه. در واقع bash در آخر یه نگاه به آرایه ای به نام COMPREPLY میندازه و پیشنهادات رو از تو اون برمیداره بهمون نشون میده. برای مثال من تابع رو تغییر میدم و سه کلمه foo، bar و baz رو برای پیشنهاد در آرایه COMPREPLY میذارم.

{{< highlight sh >}}
/p/bash-completion $ cat /etc/bash_completion.d/coolcmd-completion 
#! /bin/bash

_coolcmd() {
  COMPREPLY=( foo bar baz )
}

complete -F _coolcmd coolcmd
{{< /highlight >}}
 
خوب کد جدیدمون شد این. برای این که دوباره مجبور نشم یه شل جدید باز کنم تو همین دایرکتوری از شل عزیزمون میخوام خودش رو ریلود کنه

{{< highlight sh >}}
/p/bash-completion $ source ~/.bashrc
{{< /highlight >}}

حالا اگر دستور و سپس TAB رو بزنم:

{{< highlight sh >}}
/p/bash-completion $ ./coolcmd 
bar  baz  foo
{{< /highlight >}}

اما هنوز یه کوچولو ناقصه. مثلا اگر مورد دلخواه ما پارامتر foo باشه، انتظارمون اینه بعد از تایپ کردن حرف f، شل foo رو انتخاب کنه. برای این کار باید از آرایه COMP_WORDS استفاده کنیم. در این آرایه تمام کلماتی که بعد از دستور نوشتیم هست. کافیه لیست پارامتر هارو به یک آرایه دیگه انتقال بدیم و یه حلقه for روی پارمتر ها بزنیم و هر پارامتری اولش با اول پارامتری که ما نوشتیم یکی بود، به لیست اصلی اضافش کنیم.


{{< highlight sh >}}
/p/bash-completion $ cat /etc/bash_completion.d/coolcmd-completion 
#! /bin/bash

_coolcmd() {
  candidates=( foo bar baz )
  for candidate in ${candidates[@]}; do
    if [[ "${candidate}" == "${COMP_WORDS[1]}"* ]]; then
      COMPREPLY+=( ${candidate} )
    fi
  done
}

complete -F _coolcmd coolcmd
{{< /highlight >}}

بعد از بازنویسی اسکریپتم، مجددا شل رو ریلود میکنم. حالا درست کار میکنه! همچنین اگر کاراکتر b رو به عنوان پارامتر بهش بدیم، چون اولش فقط با bar و baz مشابهه، دیگه foo رو بهمون نشون نمیده و کاراکتر a رو هم خودش بعدش اضافه میکنه:

{{< highlight sh >}}
/p/bash-completion $ ./coolcmd ba
bar  baz
{{< /highlight >}}

البته این یه مثال سادست و میتونه خیلی از این پیشرفته تر باشه، اما به همون اندازه توضیحش هم سخت تر میشه.


