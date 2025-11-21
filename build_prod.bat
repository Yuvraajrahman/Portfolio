@echo off
echo Building Portfolio for Production...
echo.
flutter build web --release
echo.
echo Build complete! Files are in build\web directory
echo.
pause

