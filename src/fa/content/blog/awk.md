+++
title = "AWK"
date  = "2019-24-07T00:57:05"
+++


حتما براتون پیش اومده که در اسکریپت های شل در سیستم عامل های شبه یونیکس دستور awk رو دیده باشید. Awk یه دستور ساده مثل ls یا mv یا cp نیست. awk در واقع یک زبان اسکریپتی دیتاگراست و این دستور اسکریپت هایی که به زبان awk نوشته شدن رو اجرا میکنه. بصورت خیلی ساده awk یک استریمی از دیتا رو میخونه و طبق یک سری پترن که براش تعریف کردیم (و اختیاری هستن) قسمت های مورد نیاز ما از اون دیتا رو استخراج میکنه. در این پست قراره یه دید هلیکوپتری به awk داشته باشیم.



### awk scripting
در حالت پیشفرض awk منتظره در ورودی (standard input) بهش دیتا بدید تا پردازش کنه. معمولا با عملگر پایپ یا | در شل این کار رو انجام میدن. خوب گفتیم که awk طبق یک یا چند پترن که بهش داده میشه دیتا ورودی رو پردازش میکنه. ساختار این پترن و عبارات پردازش بشکل زیره:

{{< highlight text >}}
pattern(s) { expression(s) }
{{< /highlight >}}

البته هر دو اختاری هستن. برای مثال من ورودی foo bar baz رو به awk بدون پترن و عبارت میدم:

{{< highlight sh >}}
/p/awk $ echo foo bar baz | awk ''
/p/awk $ 
{{< /highlight >}}
{{< highlight sh >}}
/p/awk $ echo foo bar baz | awk '{}'
/p/awk $ 
{{< /highlight >}}

و اونم برام هیچ‌کاری نکرد!

![fuck you](/blog/images/pouriya.org-awk-01.jpeg)

وقتی awk دیتا رو از ورودی میخونه همین که یک خط از دیتا کامل شد (به کاراکتر خط جدید رسید)، بصورت پیشفرض با استفاده از کاراکتر های فضای‌خالی (اسپیس و یا تب) بقیه ی کاراکتر های اون خط رو از هم جدا میکنه و بعد به ترتیب مقدارشون رو در 1$ تا n$ میریزه. سپس پترن های ما رو به ترتیب چک میکنه و اگر پترنی وجود داشت، شرط یا شروط اون پترن رو چک میکنه و در صورت گذر از شرط و شروطش، بدنه ی اون پترن رو اجرا میکنه و اگر هم شرطی وجود نداشت فقط بدنه رو اجرا میکنه.  
برای مثال وقتی مقدار foo bar baz رو بهش میدم، خود دستور echo آخر اینا یه کاراکتر خط جدید میذاره. وقتی awk این خط رو جدا میکنه با استفاده از کاراکتر های فضای خالی بقیه ی کاراکتر هارو هم جدا میکنه که در نهایت میشن ۳ کلمه ی foo bar baz و foo میشه 1$، bar میشه 2$ و baz میشه 3$:

{{< highlight sh >}}
/p/awk $ echo foo bar baz | awk '{print $3 $2 $1}'
bazbarfoo
{{< /highlight >}}

همونطور که دیدین با استفاده از دستور print تونستم به ترتیب سومین و دومین و اولین پارامتر های ورودی رو چاپ کنم. برای مثال به خروجی دستور ps -u در سیستم من توجه کنید:

{{< highlight sh >}}
/p/awk $ ps -u
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
pouriya  28773  0.0  0.0  24352  5656 pts/1    Ss   Jul23   0:00 bash
pouriya  28795  0.9  0.0  28152  4580 pts/1    S+   Jul23   0:38 htop
pouriya  28951  0.0  0.0  24400  5876 pts/2    Ss   Jul23   0:00 bash
pouriya  28970  0.0  0.3 126436 43244 pts/2    Sl+  Jul23   0:01 hugo server
pouriya  29017  0.0  0.0  24428  5684 pts/3    Ss+  Jul23   0:00 bash
pouriya  29123  0.9  0.4 666804 50400 pts/3    Sl   Jul23   0:36 xed content/blog/awk.md
pouriya  29765  0.0  0.0  24400  5652 pts/4    Ss   Jul23   0:00 bash
pouriya  30187  0.0  0.0  38904  3608 pts/4    R+   00:14   0:00 ps -u
{{< /highlight >}}

اگر بخوام با استفاده از awk فقط اسم دستورات (که آخرین قسمت از هر خط هست) رو نشون بدم باید چیکار کنم؟ با توجه به توضیحات بالام درباره تقسیم هر خط به قسمت های کوچکتر، من قسمت یازدهم رو میخوام. پس:

{{< highlight sh >}}
/p/awk $ ps -u | awk '{print $11}'
COMMAND
bash
htop
bash
hugo
bash
xed
bash
ps
awk
{{< /highlight >}}

یه چیزی اینجا اضافس! چون زمان پایپ کردن دیتا هر دو برنامه با هم اجرا میشن، خود awk هم در این لیست هست. برای حذف از یک پترن استفاده میکنم:

{{< highlight sh >}}
/p/awk $ ps -u | awk '$11 != "awk" {print $11}'
COMMAND
bash
htop
bash
hugo
bash
xed
bash
ps
{{< /highlight >}}

اگر یه کم سخت گیر تر باشیم خود ps هم اضافس:

{{< highlight sh >}}
/p/awk $ ps -u | awk '$11 != "awk" && $11 != "ps" {print $11}'
COMMAND
bash
htop
bash
hugo
bash
xed
bash
{{< /highlight >}}

و اگر بخوایم شور سختگیری رو در بیاریم کلمه COMMAND که به عنوان اسم فیلد توسط خود ps در خط اول نوشته شده هم اضافس. اما نمیتونم بیام کلمه COMMAND رو هم به شرط اضافه کنم، چرا؟ چون شور سختگیری رو در اوردم و ممکنه واقعا دستوری به نام COMMAND در خط های بعدی باشه و بهتره بگیم فقط خط اول اضافس!

![cry](/blog/images/pouriya.org-awk-02.jpeg)

برای این کار میتونم از متغیر NR استفاده کنم. awk عدد خط رو در این متغیر میریزه و هر بار به خط بعدی میره آپدیتش میکنه:

{{< highlight sh >}}
/p/awk $ ps -u | awk '$11 != "awk" && $11 != "ps" &&  NR > 1 {print $11}'
bash
htop
bash
hugo
bash
xed
bash
{{< /highlight >}}

به جای داشتن یک پترن با شروط طول و دراز میتونیم چند تا پترن داشته باشیم. awk عزیز هم از بالا به پایین چکشون میکنه:

{{< highlight sh >}}
/p/awk $ ps -u | awk 'NR == 1 {next} $11 == "awk" {next} $11 == "ps" {next} {print $11}'
bash
htop
bash
hugo
bash
xed
bash
{{< /highlight >}}

خوب اینجا با استفاده از دستور next در سه پترن اول بهش گفتم این خط رو بیخیال شو برو خط بعدی! همچین اسکریپی یه کم میتونه نا خوانا باشه. میتونیم اسکریپت awk رو در یک فایل ذخیره کنیم و با استفاده از f- به awk بگیم اجراش کن. پس من در فایل my-ps-parser.awk ذخیرش کردم و نسخه جدید خوانا تر شده:

{{< highlight sh >}}
/p/awk $ cat my-ps-parser.awk
{{< /highlight >}} 
{{< highlight awk >}}
NR == 1 {
  next
}

$11 == "awk" {
  next
}

$11 == "ps" {
  next
}

{print $11}
{{< /highlight >}}
{{< highlight sh >}}
/p/awk $ ps -u | awk -f my-ps-parser.awk 
bash
htop
bash
hugo
bash
xed
bash
{{< /highlight >}}

همچنین در awk میتونیم if یا for داشته باشیم و یا از regex در پترن ها استفاده کنیم. یه سری توابع آماده برای کار با رشته ها هم داره و میتونیم خودمون هم تابع تریف کنیم. اگر به اسکریپت نویسی و جینگولک بازی علاقه مند هستین حتما بیشتر درباره awk یاد بگیرید.

### یه کار خفن تر
من دیتای صفحه html سایت time.ir رو گرفتم و در فایل time.ir.html ذخیره کردم

{{< highlight sh >}}
/p/awk $ ls -lh time.ir.html 
-rw-r--r-- 1 pouriya pouriya 71K Jul 24 01:02 time.ir.html
{{< /highlight >}}

و همونطور که میبینید حجمش ۷۱ کیلوبایت شده. قراره مناسبت های این ماه رو ازش بکشم بیرون!  

![holy shit](/blog/images/pouriya.org-awk-03.jpeg)


این بخش دیگه جزوی از اموزش نیست و از ابتدا هم قرار نبود همه فیچر های awk رو در این پست آموزش بدم. بنابراین فقط داخل اسکریپت یه کوچولو براتون کامنت گذاشتم.  


{{< highlight awk >}}
BEGIN {
  # This is a comment
  # This block will be evaluated before processing data

  FS = "[<>\"]" # Do'nt want to split line using white spaces. Want to split it with <, > and "

  should_print = 0
  should_print_next_line = 0
}

$2 == "span" && $4 == "span" {
  should_print = 1
  next
}

should_print == 1 && $2 == "/ul" {
  exit
}

should_print == 1 && $2 == "span id=" {
  should_print_next_line = 1
  next
}

should_print_next_line == 1 {
  print $0
  should_print_next_line = 0
  next
}
{{< /highlight >}}

این اسکریپت رو در فایل time.ir.awk ذخیره کردم وبعد از یه کم ور رفتن با اون فایل تستی نتیجه درست رو داد و میخوام خروجیش رو با ریختن دیتای مستقیم از curl بهتون نشون بدم:

{{< highlight sh >}}
/p/awk $ curl \
> -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0" \
>  https://www.time.ir \
> 2>/dev/null \
> | awk -f time.ir.awk

                            روز ترویج آموزش های فنی و حرفه ای
                            مرداد روز،جشن مردادگان
                            روز بزرگداشت شیخ شهاب الدین سهروردی
                            جشن چله تابستان
                            آغاز هفته جهانی شیردهی
                            شهادت امام محمد تقی علیه السلام
                            صدور فرمان مشروطیت
                            روز خبرنگار
                            شهادت امام محمد باقر علیه السلام
                            روز عرفه
                            عید سعید قربان
                            روز جهانی چپ دست ها
                            ولادت امام علی النقی الهادی علیه السلام
                            سالروز ورود آزادگانِ سرافراز به وطن
                            سالروز کودتای 28 مرداد علیه دولت دکتر محمد مصدق
                            سالروز فاجعه آتش زدن سینما رکس آبادان
                            روز جهانی عکاسی
                            عید سعید غدیر خم
                            ولادت امام موسی کاظم علیه السلام
{{< /highlight >}}







{{< highlight sh >}}

{{< /highlight >}}

