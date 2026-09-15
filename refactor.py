import codecs

with codecs.open('index.html', 'r', 'utf-8') as f:
    content = f.read()

start_idx = content.find('<style>')
end_idx = content.find('</style>')

if start_idx != -1 and end_idx != -1:
    css_content = content[start_idx+7:end_idx].strip()
    with codecs.open('style.css', 'w', 'utf-8') as f:
        f.write(css_content)
    
    seo_tags = """<meta name="description" content="تجربة رقمية Premium لعرض السيارات الجديدة، ترشيح السيارة الأنسب، ومقارنة السيارات بكل سهولة.">
<meta property="og:title" content="منصة الحصري للسيارات الجديدة | عرض BOOD Solutions">
<meta property="og:description" content="تجربة رقمية Premium لعرض السيارات الجديدة، ترشيح السيارة الأنسب، ومقارنة السيارات بكل سهولة.">
<meta property="og:type" content="website">
<link rel="stylesheet" href="style.css">"""
    
    new_content = content[:start_idx] + seo_tags + content[end_idx+8:]
    
    # Add aria-labels
    new_content = new_content.replace('<a href="https://wa.me/" class="wa">', '<a href="https://wa.me/" class="wa" aria-label="تواصل معنا عبر واتساب">')
    new_content = new_content.replace('<a href="mailto:" class="mail">', '<a href="mailto:" class="mail" aria-label="تواصل معنا عبر البريد الإلكتروني">')
    
    with codecs.open('index.html', 'w', 'utf-8') as f:
        f.write(new_content)
    print("Refactoring completed successfully.")
else:
    print("Style tags not found.")
