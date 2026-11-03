# Sube el index.html recien generado (Render de rel_precios_tabla_public.qmd) a GitHub Pages.
# Uso: despues de hacer Render en RStudio, correr este script parado en esta carpeta
# (o simplemente hacer doble click / "Run with PowerShell").

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Test-Path "index.html")) {
    Write-Error "No encuentro index.html en esta carpeta. Primero corre Render en rel_precios_tabla_public.qmd."
    exit 1
}

git add -A
$cambios = git status --porcelain
if (-not $cambios) {
    Write-Host "Nada nuevo para publicar (el HTML no cambio)." -ForegroundColor Yellow
} else {
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm"
    git commit -m "Actualizacion $fecha" -q
    git push
    Write-Host "Publicado. En un minuto deberia verse en https://smartfarming-ar.github.io/relacionesprecios/" -ForegroundColor Green
}
