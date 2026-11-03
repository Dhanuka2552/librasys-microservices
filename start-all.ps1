# LibraSys All-in-One Launcher Script
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "          LIBRASYS FULL STACK SYSTEM LAUNCH           " -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan

# 1. Check Docker status
Write-Host "`n[1/3] Checking Docker Engine..." -ForegroundColor Yellow
$dockerCheck = docker info 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Docker Desktop is not running!" -ForegroundColor Red
    Write-Host "Please start 'Docker Desktop' from your Start Menu or Desktop, wait until it is ready, and run this script again." -ForegroundColor Yellow
    exit 1
}
Write-Host "[OK] Docker Engine is running." -ForegroundColor Green

# 2. Launch Docker Compose
Write-Host "`n[2/3] Starting all 14 containers via Docker Compose..." -ForegroundColor Yellow
docker compose up -d --build

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Failed to start Docker containers." -ForegroundColor Red
    exit 1
}
Write-Host "[OK] Containers started successfully." -ForegroundColor Green

# 3. Wait for services to initialize
Write-Host "`n[3/3] Waiting 15 seconds for Eureka and microservices to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

Write-Host "`nRunning system health check..." -ForegroundColor Cyan
powershell -ExecutionPolicy Bypass -File .\test_system.ps1

Write-Host "`n======================================================" -ForegroundColor Green
Write-Host " LibraSys is Live!" -ForegroundColor Green
Write-Host " - Frontend Client App:    http://localhost:3000" -ForegroundColor Cyan
Write-Host " - Central API Gateway:    http://localhost:8080" -ForegroundColor Cyan
Write-Host " - Eureka Service Registry: http://localhost:8761" -ForegroundColor Cyan
Write-Host " - Swagger UI:             http://localhost:8080/swagger-ui.html" -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Green

