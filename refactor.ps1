$html = [IO.File]::ReadAllText("g:\ELhossry\index.html", [System.Text.Encoding]::UTF8)
$start = $html.IndexOf("<style>")
$end = $html.IndexOf("</style>") + 8

if ($start -ge 0 -and $end -gt $start) {
    # Extract CSS (without the <style> and </style> tags)
    $css = $html.Substring($start + 7, $end - 8 - $start - 7)
    [IO.File]::WriteAllText("g:\ELhossry\style.css", $css.Trim(), [System.Text.Encoding]::UTF8)

    # Replacement tags
    $head_tags = @"
<meta name="description" content="تجربة رقمية Premium لعرض السيارات الجديدة، ترشيح السيارة الأنسب، ومقارنة السيارات بكل سهولة.">
<meta property="og:title" content="منصة الحصري للسيارات الجديدة | عرض BOOD Solutions">
<meta property="og:description" content="تجربة رقمية Premium لعرض السيارات الجديدة، ترشيح السيارة الأنسب، ومقارنة السيارات بكل سهولة.">
<meta property="og:type" content="website">
<link rel="stylesheet" href="style.css">
"@

    # Splice new html
    $new_html = $html.Substring(0, $start) + $head_tags + $html.Substring($end)
    
    # Replace links
    $new_html = $new_html.Replace('<a href="https://wa.me/" class="wa">', '<a href="https://wa.me/" class="wa" aria-label="تواصل معنا عبر واتساب">')
    $new_html = $new_html.Replace('<a href="mailto:" class="mail">', '<a href="mailto:" class="mail" aria-label="تواصل معنا عبر البريد الإلكتروني">')

    [IO.File]::WriteAllText("g:\ELhossry\index.html", $new_html, [System.Text.Encoding]::UTF8)
    Write-Host "Refactoring completed successfully."
} else {
    Write-Host "Style tags not found."
}
