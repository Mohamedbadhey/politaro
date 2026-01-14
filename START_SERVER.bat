@echo off
echo ================================================
echo Starting Police Case Management System
echo ================================================
echo.
echo Server will start on: http://localhost:8080
echo Login page: http://localhost:8080/index.html
echo.
echo Login credentials:
echo   Username: superadmin
echo   Password: password123
echo.
echo Press Ctrl+C to stop the server
echo ================================================
echo.

cd public
php -S localhost:8080

pause
