@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo        Qt Project Cleanup Tool
echo ========================================
echo Base Directory: %cd%
pause
echo Start Time: %date% %time%
echo.

set count=0
set errors=0
set total_dirs=0
set current=0

REM Count total directories first
for /d %%p in (*) do (
    set /a total_dirs+=1
)
echo Found %total_dirs% project directories
echo.
echo ----------------------------------------
echo Starting cleanup...
echo.

REM Clean current directory first
set "root_has_items=0"
echo [ROOT] Processing current directory

if exist "build" (
    rd /s /q "build" 2>nul
    if errorlevel 1 (
        echo   [FAILED] build
        set /a errors+=1
    ) else (
        echo   [DELETED] build
        set /a count+=1
        set "root_has_items=1"
    )
)

if exist "CMakeLists.txt.user" (
    del /f /q "CMakeLists.txt.user" 2>nul
    if errorlevel 1 (
        echo   [FAILED] CMakeLists.txt.user
        set /a errors+=1
    ) else (
        echo   [DELETED] CMakeLists.txt.user
        set /a count+=1
        set "root_has_items=1"
    )
)

if exist ".qtcreator" (
    rd /s /q ".qtcreator" 2>nul
    if errorlevel 1 (
        echo   [FAILED] .qtcreator
        set /a errors+=1
    ) else (
        echo   [DELETED] .qtcreator
        set /a count+=1
        set "root_has_items=1"
    )
)

if "!root_has_items!"=="0" (
    echo   [NO ITEMS]
)
echo.

REM Clean subdirectories
for /d %%p in (*) do (
    set /a current+=1
    echo [!current!/%total_dirs%] Processing: %%p
    
    set "has_deleted=0"
    
    if exist "%%p\build" (
        rd /s /q "%%p\build" 2>nul
        if errorlevel 1 (
            echo   [FAILED] %%p\build
            set /a errors+=1
        ) else (
            echo   [DELETED] %%p\build
            set /a count+=1
            set "has_deleted=1"
        )
    )

    if exist "%%p\CMakeLists.txt.user" (
        del /f /q "%%p\CMakeLists.txt.user" 2>nul
        if errorlevel 1 (
            echo   [FAILED] %%p\CMakeLists.txt.user
            set /a errors+=1
        ) else (
            echo   [DELETED] %%p\CMakeLists.txt.user
            set /a count+=1
            set "has_deleted=1"
        )
    )
    
    if exist "%%p\.qtcreator" (
        rd /s /q "%%p\.qtcreator" 2>nul
        if errorlevel 1 (
            echo   [FAILED] %%p\.qtcreator
            set /a errors+=1
        ) else (
            echo   [DELETED] %%p\.qtcreator
            set /a count+=1
            set "has_deleted=1"
        )
    )

    if "!has_deleted!"=="0" (
        echo   [NO ITEMS]
    )
    
    echo.
)

echo ----------------------------------------
echo Cleanup Complete!
echo.
echo ============ Statistics ============
echo Total Projects: %total_dirs%
echo Deleted:        %count% items
echo Failed:         %errors% items
echo End Time:       %date% %time%
echo ====================================
echo.

if %errors% gtr 0 (
    echo [WARNING] %errors% items failed to delete. Check permissions.
echo.
)

echo Press Enter to exit...
pause
endlocal
