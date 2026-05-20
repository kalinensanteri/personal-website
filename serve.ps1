$port = if ($env:PORT) { $env:PORT } else { 3456 }
$root = "C:\Users\Santeri Kalinen\Downloads\fiilisunlimited"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Serving on http://localhost:$port"

$mime = @{
  html='text/html'; css='text/css'; js='application/javascript'
  png='image/png'; jpg='image/jpeg'; jpeg='image/jpeg'
  gif='image/gif'; svg='image/svg+xml'
}

while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $path = $ctx.Request.Url.LocalPath
  if ($path -eq '/') { $path = '/index.html' }
  $file = Join-Path $root $path.TrimStart('/')
  if (Test-Path $file -PathType Leaf) {
    $bytes = [IO.File]::ReadAllBytes($file)
    $ext = [IO.Path]::GetExtension($file).TrimStart('.').ToLower()
    $ct = if ($mime[$ext]) { $mime[$ext] } else { 'application/octet-stream' }
    $ctx.Response.ContentType = $ct
    $ctx.Response.ContentLength64 = $bytes.Length
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else {
    $ctx.Response.StatusCode = 404
    $ctx.Response.ContentLength64 = 0
  }
  $ctx.Response.Close()
}
