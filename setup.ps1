# Vikunja Setup Script for Raspberry Pi 5 - update to setup.sh when on PI
# Run this on your Pi before docker-compose up

Write-Host "🚀 Vikunja Setup Script" -ForegroundColor Cyan
Write-Host "======================" -ForegroundColor Cyan
Write-Host ""

# Check if docker is available
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Docker is not installed. Please install Docker first." -ForegroundColor Red
    exit 1
}

# Check if docker-compose is available
if (-not (Get-Command docker-compose -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Docker Compose is not installed. Please install Docker Compose first." -ForegroundColor Red
    exit 1
}

Write-Host "📁 Creating data directories..." -ForegroundColor Yellow

# Create db and files directories if they don't exist
if (-not (Test-Path "db")) {
    New-Item -ItemType Directory -Path "db" | Out-Null
}

if (-not (Test-Path "files")) {
    New-Item -ItemType Directory -Path "files" | Out-Null
}

Write-Host "✅ Directories created" -ForegroundColor Green
Write-Host ""

Write-Host "🔐 Security Reminder" -ForegroundColor Yellow
Write-Host "Make sure you've updated the passwords in docker-compose.yml:" -ForegroundColor Yellow
Write-Host "   - POSTGRES_PASSWORD" -ForegroundColor White
Write-Host "   - VIKUNJA_DATABASE_PASSWORD (must match POSTGRES_PASSWORD)" -ForegroundColor White
Write-Host "   - VIKUNJA_SERVICE_JWTSECRET" -ForegroundColor White
Write-Host ""

Write-Host "🎉 Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Verify passwords are set in docker-compose.yml" -ForegroundColor White
Write-Host "2. Run: docker-compose up -d" -ForegroundColor White
Write-Host "3. Access Vikunja at http://localhost:8080" -ForegroundColor White
Write-Host "4. Create your first user account" -ForegroundColor White
Write-Host ""
Write-Host "Useful commands:" -ForegroundColor Cyan
Write-Host "  Check status:  docker-compose ps" -ForegroundColor White
Write-Host "  View logs:     docker-compose logs -f" -ForegroundColor White
Write-Host "  Stop services: docker-compose down" -ForegroundColor White