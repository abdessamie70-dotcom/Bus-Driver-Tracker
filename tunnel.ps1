$port = 8080
$baseDir = $PSScriptRoot

Write-Host "=================================================================" -ForegroundColor Green
Write-Host "     [+] جاري تشغيل خادم البرنامج وإنشاء رابط الإنترنت العام...  " -ForegroundColor Cyan
Write-Host "=================================================================" -ForegroundColor Green

# تشغيل الخادم المحلي في الخلفية
$serverJob = Start-Job -ScriptBlock {
    param($baseDir, $port)
    $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, $port)
    $listener.Start()
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
} -ArgumentList $baseDir, $port

Write-Host ""
Write-Host "جاري استخراج الرابط العام من خوادم الإنترنت... يرجى الانتظار..." -ForegroundColor Yellow
Write-Host "سوف يظهر لك رابط يبدأ بـ https:// يمكنك إرساله لأي شخص!" -ForegroundColor Green
Write-Host "اترك هذه النافذة مفتوحة أثناء مشاركة الرابط." -ForegroundColor Gray
Write-Host ""

try {
    ssh -o StrictHostKeyChecking=no -R 80:localhost:$port nokey@localhost.run
} finally {
    Stop-Job $serverJob -ErrorAction SilentlyContinue
    Remove-Job $serverJob -ErrorAction SilentlyContinue
}
