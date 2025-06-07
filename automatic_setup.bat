@echo off
echo "Todo: Check branding"
echo "Todo: Copy Wallpapers and User tiles"
goto check_Permissions
goto themes
goto windhawk
goto winaerotweaker
goto branding
echo "Complete!"
pause

:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo Failure: Current permissions inadequate.
    )
    
    pause > nul
    exit

:themes
    cd Themes
    copy.bat
    cd..

:windhawk
   cd Windhawk
   install.bat
   cd..
   
:winaerotweaker
   cd "Winaero Tweaker"
   SilentSetup.cmd
   cd..

:branding
   cd Branding
   copy.bat
   cd.. 