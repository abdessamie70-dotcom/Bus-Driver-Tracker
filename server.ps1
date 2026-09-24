$port = 8080
$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -match '^192\.168\.' -or $_.IPAddress -match '^10\.' } | Select-Object -ExpandProperty IPAddress -First 1)
if (-not $ip) { $ip = "192.168.1.19" }

Write-Host ""
Write-Host "================================================================" -ForegroundColor Green
Write-Host "     [+] خادم تشغيل برنامج متابعة سائقي الحافلات على الهاتف     " -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  تاكد من ان هاتفك متصل بنفس شبكة الواي فاي (Wi-Fi) مع هذا الحاسوب." -ForegroundColor Yellow
Write-Host ""
Write-Host "  افتح متصفح هاتفك (Google Chrome او Safari) واكتب الرابط التالي:" -ForegroundColor White
Write-Host ""
Write-Host "              http://$($ip):$port" -ForegroundColor Black -BackgroundColor Green
Write-Host ""
Write-Host "================================================================" -ForegroundColor Green
Write-Host "  نصيحة: بعد فتح الرابط في هاتفك، اضغط على خيارات المتصفح" -ForegroundColor Cyan
Write-Host "  واختر 'إضافة إلى الشاشة الرئيسية' لتثبيته كتطبيق مستقل." -ForegroundColor Cyan
Write-Host "  اترك هذه النافذة مفتوحة اثناء استخدام البرنامج من الهاتف." -ForegroundColor Gray
Write-Host "  للايقاف: اغلق هذه النافذة او اضغط Ctrl + C." -ForegroundColor Gray
Write-Host "================================================================" -ForegroundColor Green
Write-Host ""

$baseDir = $PSScriptRoot
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, $port)
$listener.Start()

# فتح المتصفح على الحاسوب تلقائياً
Start-Process "http://localhost:$port"

try {
    while ($true) {
        $client = $listener.AcceptTcpClient()
        [System.Threading.Tasks.Task]::Run([Action]{
            try {
                $stream = $client.GetStream()
                $reader = [System.IO.StreamReader]::new($stream, [System.Text.Encoding]::ASCII)
                $requestLine = $reader.ReadLine()
                if (-not $requestLine) { $client.Close(); return }

                $tokens = $requestLine.Split(" ")
                $rawPath = $tokens[1].TrimStart('/')
                if ($rawPath.Contains('?')) { $rawPath = $rawPath.Split('?')[0] }
                if ([string]::IsNullOrWhiteSpace($rawPath)) { $rawPath = "index.html" }

                $filePath = [System.IO.Path]::Combine($baseDir, $rawPath)
                if ([System.IO.File]::Exists($filePath)) {
                    $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                    $mime = switch ($ext) {
                        ".html" { "text/html; charset=utf-8" }
                        ".css"  { "text/css; charset=utf-8" }
                        ".js"   { "application/javascript; charset=utf-8" }
                        ".json" { "application/json; charset=utf-8" }
                        ".txt"  { "text/plain; charset=utf-8" }
                        ".svg"  { "image/svg+xml" }
                        default { "application/octet-stream" }
                    }
                    $content = [System.IO.File]::ReadAllBytes($filePath)
                    $header = "HTTP/1.1 200 OK`r`nContent-Type: $mime`r`nContent-Length: $($content.Length)`r`nAccess-Control-Allow-Origin: *`r`nConnection: close`r`n`r`n"
                    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
                    $stream.Write($headerBytes, 0, $headerBytes.Length)
                    $stream.Write($content, 0, $content.Length)
                } else {
                    $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
                    $header = "HTTP/1.1 404 Not Found`r`nContent-Type: text/plain`r`nContent-Length: $($msg.Length)`r`nConnection: close`r`n`r`n"
                    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
                    $stream.Write($headerBytes, 0, $headerBytes.Length)
                    $stream.Write($msg, 0, $msg.Length)
                }
                $stream.Flush()
                $client.Close()
            } catch {
                if ($client) { $client.Close() }
            }
        }) | Out-Null
    }
} finally {
    $listener.Stop()
}
