@echo off
cd /d "e:\Punya ayang\web Thrift\Project-Pewmeb-main\Project Pemweb Penjualan Baju Bola"
echo Starting server on http://localhost:8000/
python -m http.server 8000 2>nul || (
  echo Python tidak ditemukan, mencoba dengan Ruby...
  ruby -run -ehttpd . -p8000 2>nul || (
    echo Fallback ke PowerShell server...
    powershell -Command "& {$http = [System.Net.HttpListener]::new(); $http.Prefixes.Add('http://localhost:8000/'); $http.Start(); Write-Host 'Server berjalan di http://localhost:8000/'; while ($true) { $context = $http.GetContext(); $request = $context.Request; $response = $context.Response; $filePath = if ($request.Url.LocalPath -eq '/') { 'index.html' } else { $request.Url.LocalPath.TrimStart('/') }; $fullPath = Join-Path (Get-Location) $filePath; if (Test-Path $fullPath) { $content = [System.IO.File]::ReadAllBytes($fullPath); $response.ContentType = if ($filePath -match '\.css$') { 'text/css' } elseif ($filePath -match '\.js$') { 'application/javascript' } elseif ($filePath -match '\.html$') { 'text/html' } else { 'application/octet-stream' }; $response.OutputStream.Write($content, 0, $content.Length); } else { $response.StatusCode = 404; }; $response.Close() } }"
  )
)
pause
