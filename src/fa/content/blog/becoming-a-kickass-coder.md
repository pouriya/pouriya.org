+++
title = "چطوری یه برنامه‌نویس (خفن) بشیم؟ ۱"
date  = "2019-06-21T00:00:05"
+++

## پیشگفتار
قبل از نوشتن این پست در گوگل سرچ کردم و چندین پست دیگه با مضمون مرتبط رو خوندم و واقعا حس کردم نظر شخصی من با بقیه دوستان بعضی جاها فرق داره! اینه که تضمین میکنم بعضی از مطالب تکراری نباشه (و صد البته تضمین نمیکنم نظر شخصیم درست باشه).

![jesus help me](/blog/images/pouriya.net-becoming-a-kickass-coder-part-01-01.png)



## این سری پست ها به درد کیا میخوره؟
۱. کسانی که صفر کیلومتر هستند. مثلا فقط میدونن برنامه‌نویس ها با استفاده از زبان های برنامه‌نویسی و ... برای کامپیوتر برنامه درست میکنن.  
۲. کسانی که در دانشگاه یا از روی علاقه خودشون برنامه های ساده نوشتن و سردرگم هستن چه تولزی (یا زبان برنامه‌نویسی) رو انتخاب کنن و چطور بهتر بشن.  
۳. کسانی که جزو گروه دوم بودن و تلاش هایی کردن و حس میکنن شکست خوردن و دارن از برنامه نویسی نا امید میشن!  
۴. کسانی که یکی دو ساله به عنوان برنامه‌نویس حتی سر کار هم میرن، اما حس میکنن در این زمینه خیلی کند پیشرفت کردن.  
۵. کسانی که فکر میکنن خیلی برنامه‌نویس خفنی هستن ولی هیچ خروجی درست حسابی ندارن!  

![you can do it](/blog/images/pouriya.net-becoming-a-kickass-coder-part-01-02.jpeg)


## این سری پست ها به درد کیا نمیخوره؟
اگر بدون رانت و پارتی و ... و از شیوه درست داری از برنامه‌نویسی پول خوبی در میاری، همین الان این صفحه رو ببند!

![expert](/blog/images/pouriya.net-becoming-a-kickass-coder-part-01-03.jpeg)

## کیلومتر ۰ تا ۱۰ برای صفر کیلومتر ها
بیاید فردی رو در نظر بگیریم که به کامپیوتر علاقه داره و از این دست آدماس که هرکس تو فامیل از کامپیوتر و موبایل و ... سوالی داره میاد سراغ ایشون. یکی از تفریحات من شناسایی این مدل آدما و بحث های ساده ی برنامه‌نویسی با این آدماست. و همیشه خیلی راحت تر از بقیه مطلب رو میگیرن! اگر همچین آدمی هستین طبق نظر شخصی من احتمالش زیاده که بتونین یه برنامه‌نویس خوب بشین. علاقه و کنجکاوی واقعا شروط مهمی هستن ولی کسانی هم هستن که علاقه زیادی به این فیلد ندارن اما برنامه‌نویسان خوبی هستن و درآمد خوبی هم ازش دارن (البته من خودم فقط ۲ نفر اینطوری سراغ دارم).  
در پست های مشابهی که خوندم خیلیا یک زبان برنامه‌نویسی رو معرفی کرده بودن و پیشنهاد کرده بودن با یادگیری اون شروع کنید. یاد گرفتن یک زبان برنامه‌نویسی خالی از لطف نیست اما ممکنه بعد ها با یک زبان جدید آشنا بشید و ممکنه به خودتون بگید ای کاش با این شروع کرده بودم (که البته ممکنه این احساستون هم درست نباشه)! پس به نظرم قبل از شروع بهتره یه تحقیق مفصل بکنیم.
البته اگر این تحقیق رو در محله اول انجام بدین مثل این میمونه که بدون در نظر گرفتن جاده و مسیری که قراراه طی کنیم، بریم اتومبیل انتخاب کنیم!


### شاخه های مختلف برنامه‌نویسی
برنامه‌نویسی شاخه های مختلفی داره و وقتی میگیم فلانی برنامه‌نویسه، اصلا معنیش این نیست که هم بلده وبسایت بسازه و هم برنامه برای موبایل اندروید و هم برنامه برای موبایل آیفون و هم فایروال و ... . با توجه به گسترده بودن هر شاخه، خیلی هنر کنیم تو یکی یا دوتاش یا خیلی اژدها باشیم نهایتا در سه شاخه اوستا میشیم. قرار نیست در این پست من این شاخه هارو براتون لیست کنم و هر کدوم رو توضیح بدم به دلیل این که ممکنه این پست قدیمی بشه و برای مثال چند شاخه جدید وارد دنیای برنامه‌نویسی شده باشه و یا ازش حذف شده باشه و یا توضیح من درباره شاخه X دیگه صادق نباشه و همچنین دانش توضیح فنی دقیق خیلی از شاخه هارو هم ندارم! بنابراین من یک سری سوال در مورد این شاخه ها براتون نوشتم که هر زمان این پست رو ببینین به دردتون بخوره.  
در ابتدای کار این سوالات رو از خودتون بپرسید و برای جوابشون تحقیق مفصلی انجام بدید:  
۱. برنامه‌نویسی چند تا شاخه مختلف داره؟  
۲. فرق اساسی این شاخه ها با هم چیه؟  
۳. حالا که یک دید هلیکوپتری از این شاخه ها پیدا کردم، از کدومش بیشتر خوشم اومده و دلیل این علاقه چیه؟ آیا دلیل موجهیه؟  
حالا که فکر میکنید شاخه مناسبی رو انتخاب کردید، این سوالات رو برای اون شاخه از خودتون بپرسید و برای جوابشون تحقیق مفصلی انجام بدید:  
۱. سبک زندگی برنامه‌نویسان این شاخه چطوریه؟ (این خیلی مهمه و به احتمال زیاد سبک زندگی آینده شماست!)  
۲. بازار کارش در کشوری که من میخوام توش کار کنم چطوره؟  
۳. با توجه به شرایط (دانش فعلی، زمان و ...) من، چقدر طول میکشه تا در این شاخه حرفه ای بشم؟  
با استفاده از گوگل به جواب های خوبی میرسید. اما من بشدت پیشنهاد میکنم در شبکه های اجتماعی بگردید و برنامه‌نویسان حرفه ای شاخه مورد نظرتون رو پیدا کنین و باهاشون حرف بزنید. اونم نه یک نفر بلکه ده نفر. سعی کنید حدودا بین یک هفته تا یک ماه روی این قسمت وقت بذارید. اگر دیدید شاخه ای که انتخاب کردید مناسب نیست، شاخه های دیگه رو امتحان کنید.

![oops](/blog/images/pouriya.net-becoming-a-kickass-coder-part-01-04.jpeg)


## کیلومتر ۱۰ تا ۲۰
احتمالا تا الان یه فیلد (برنامه‌نویسی وب، اندروید، هوش مصنوعی، ...) رو برای شروع کار انتخاب کردین و با چندتا از برنامه‌نویسان حرفه ای اون شاخه صحبت مفصلی کردین. حالا وقتش رسیده تولز یا زبان برنامه‌نویسی رو انتخاب کنیم.  
آقا من میگم جاوا از همه بهتره! نه پایتون بهتره! یعنی واقعا سی‌شارپ به این خوبی رو نمیبینی؟ این دری‌وریا چیه زبون فقط سی! اینا مال سوسولاس دولپر واقعی فقط با اسمبل کد میزنه!و ...  
این دیگه پیشنهاد و توصیه نیست، بلکه ازتون خواهش میکنم گول این بازی (و افرادی که این بازی رو راه میندازن) رو نخورید. همه ی این زبان ها روز اول با یه هدفی ساخته شدن و به مرور زمان به بعضی فیلد ها ورود کردن و الان حتی اگر خیلی فراگیر هم باشن، باز بیشتر به درد چند فیلد خاص میخورن. برای مثال شما با جاوا میتونی برنامه بک‌اند بزنی و یا برنامه اندروید، این دلیل نمیشه بری با جاوا برای سیستم عامل درایور بنویسی! یا با سی همه کدی میتونی بزنی، ولی به عنوان سیس‌ادمین، پایتون یا پرل یا خود شل کارت رو برای اسکریپت هات مثل آب خوردن راه میندازن و دلیلی نداره بری تو سی با پوینتر ها ور بری! پس وارد این بحثا نشید.

![programming languages](/blog/images/pouriya.net-becoming-a-kickass-coder-part-01-05.jpeg)

این سوال که <bold>کدوم زبان برنامه‌نویسی بهتره؟</bold> سوال خنده/گریه داریه ولی این سوال که <bold>کدوم زبان برنامه‌نویسی برای فلان کار بهتره؟</bold> خیلی سوال بجا و مهمیه. پس در مرحله دوم باید با جستجو و پرسش از حرفه ای های شاخه مورد نظرمون و البته به نسبت شرایط خودمون (دانش فعلی و زمان خالی برای یادگیری و ...) زبان برنامه‌نویسی رو انتخاب کنیم.


در قسمت بعدی قراره یاد بگیریم چطور زبان برنامه‌نویسی که انتخاب کردیم رو درست و حسابی یاد بگیریم و چند کیلومتر دیگه رو تکمیل میکنیم.



