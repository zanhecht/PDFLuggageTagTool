@ECHO OFF
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION
PATH=%PATH%;%~dp0\bin
SET FileName=""
SET TagPage=15
SET Name1=
SET Size1=12
SET Size2=12
SET Size3=12
SET Size4=12
SET OutName=RCL4Tags.pdf
Set TitleStr=Royal Caribbean Luggage Tag Rearranger Version 1.4 Created 01/16/2013 by ahecht


:Start
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
del /F /Q *.tmp 
Wbox "%TitleStr%" ^
 "This script will extract the luggage tags from your Royal Caribbean cruise documents and place four of them on a single page for easy printing. It can also insert names onto the luggage tags.^^This script and its constituant programs are distributed under the GPL or similar open licenses. Please see the doc folder for more information.^^This program is in no way affiliated with nor endorsed by Royal Caribbean International or Royal Caribbean Cruises Ltd." ^
 "Create PDF with 4 tags on one page;Additional PDF tools;Exit" ^
  /WW=640 /BW=210 /DB=1 /OT /AL
IF Errorlevel 3 GOTO End
IF Errorlevel 2 GOTO Utils
IF Errorlevel 1 GOTO Init
GOTO End


:Init
SET FileName=""
SET TagPage=15
SET Name1=
SET Size1=12
SET Size2=12
SET Size3=12
SET Size4=12
SET OutName=RCL4Tags.pdf


:ChooseDocs
Wbox "Select your Cruise Documents PDF file..." ^
 "Your cruise documents are a long PDF file with ''GUEST TICKET BOOKLET'' on the first page. You can get this file from RoyalCaribbean.com or your travel agent 40-45 days before your cruise.^ ^Hit the ''Open...'' button below and select your cruise documents PDF file. " "Open..." /WW=320 /DB=1 /OT /AL
ECHO Opening File . . .
FileToOpen "SET FilePath=" ".\*.pdf" "Select your Cruise Documents PDF file..." > temp.bat
IF Errorlevel 1 (GOTO End)
CALL temp.bat
ECHO %FilePath%
FOR %%F in (%FilePath%) do set FileName=%%~nF%%~xF
GOTO Choices


:AskAgain
FOR %%F in (%FilePath%) do set FilePathNQ=%%~F
Wbox "Select your Cruise Documents PDF file..." ^
 "Is ''%FilePathNQ%'' the correct location of your cruise documents?" "Yes;No" /WW=320 /DB=1 /OT /AL
IF Errorlevel 2 (GOTO ChooseDocs)

:Choices

winput "Page Number" "SET TagPage=$input" ^
 "What page of %FileName% are your luggage tags on?^ ^You can determine this by opening the cruise documents in Adobe Reader or other PDF software." ^
 "%TagPage%" /num > temp.bat
CALL temp.bat

IF NOT DEFINED Name1 (
	winput "Luggage Tag #1" "SET Name1=$input" ^
 "You can have this program insert the Guest Name onto the four luggage tags^automatically. You can skip this step by pressing CANCEL or leaving this name^blank.^ ^Enter a name for Luggage Tag #1:" > temp.bat
	IF Errorlevel 1 (SET Name1=)
	CALL temp.bat
) ELSE (
	winput "Luggage Tag #1" "SET Name1=$input" ^
 "Enter a name for Luggage Tag #1:" "!Name1!" > temp.bat
	IF Errorlevel 1 (SET Name1=)
	CALL temp.bat
	winput "Luggage Tag #1" "SET Size1=$input" ^
 "Enter Font Size for Tag #1:" "!Size1!" /num > temp.bat
	CALL temp.bat

	winput "Luggage Tag #2" "SET Name2=$input" ^
 "Enter a name for Luggage Tag #2:" "!Name2!" > temp.bat
	IF Errorlevel 1 (SET Name2=)
	CALL temp.bat
	winput "Luggage Tag #2" "SET Size2=$input" ^
 "Enter Font Size for Tag #2:" "!Size2!" /num > temp.bat
	CALL temp.bat
	
	winput "Luggage Tag #3" "SET Name3=$input" ^
 "Enter a name for Luggage Tag #3:" "!Name3!" > temp.bat
	IF Errorlevel 1 (SET Name3=)
	CALL temp.bat
	winput "Luggage Tag #3" "SET Size3=$input" ^
 "Enter Font Size for Tag #3:" "!Size3!" /num > temp.bat
	CALL temp.bat
	
	winput "Luggage Tag #4" "SET Name4=$input" ^
 "Enter a name for Luggage Tag #4:" "!Name4!" > temp.bat
	IF Errorlevel 1 (SET Name4=)
	CALL temp.bat
	winput "Luggage Tag #4" "SET Size4=$input" ^
 "Enter Font Size for Tag #4:" "!Size4!" /num > temp.bat
	CALL temp.bat
	GOTO OutAgain
)
IF NOT DEFINED Name1 (
	SET Name2=
	SET Name3=
	SET Name4=
) ELSE (
	winput "Luggage Tag #1" "SET Size1=$input" ^
 "Most names will fit onto the luggage tags at font size 12. However, if your^name is 15 letters or less, size 18 would be a better choice. If your name^appears too large or too small on the finished tags, you can use the ''Modify^current tags'' option at the end of this program to try a different size.^ ^Enter Font Size for Tag #1:" "%Size1%" /num > temp.bat
	CALL temp.bat

	SET Name2=!Name1!
	SET Size2=!Size1!

	winput "Luggage Tag #2" "SET Name2=$input" ^
 "Enter a name for Luggage Tag #2:" "!Name2!" > temp.bat
	IF Errorlevel 1 (SET Name2=)
	CALL temp.bat
	winput "Luggage Tag #2" "SET Size2=$input" ^
 "Enter Font Size for Tag #2:" "!Size2!" /num > temp.bat
	CALL temp.bat

	SET Name3=!Name2!
	Set Size3=!Size2!
	
	winput "Luggage Tag #3" "SET Name3=$input" ^
 "Enter a name for Luggage Tag #3:" "!Name3!" > temp.bat
	IF Errorlevel 1 (SET Name3=)
	CALL temp.bat
	winput "Luggage Tag #3" "SET Size3=$input" ^
 "Enter Font Size for Tag #3:" "!Size3!" /num > temp.bat
	CALL temp.bat
	
	SET Name4=!Name3!
	Set Size4=!Size3!
	
	winput "Luggage Tag #4" "SET Name4=$input" ^
 "Enter a name for Luggage Tag #4:" "!Name4!" > temp.bat
	IF Errorlevel 1 (SET Name4=)
	CALL temp.bat
	winput "Luggage Tag #4" "SET Size4=$input" ^
 "Enter Font Size for Tag #4:" "!Size4!" /num > temp.bat
	CALL temp.bat
)


:OutAgain
Wbox "Save As..." ^
 "A new PDF file will be created with four luggage tags on a single page.^ ^Click on ''Save As...'' below to choose a name and location for this new PDF file. It should be different from the name of your cruise documents." "Save As..." /WW=320 /DB=1 /OT /AL

FileToSave "SET OutPath=" "%~dp0*.pdf" "Save As..." "%OutName%" /overwritePrompt > temp.bat
IF Errorlevel 1 (GOTO ReDO)
CALL temp.bat

FOR %%F in (%OutPath%) do set OutExt=%%~xF
FOR %%F in (%OutPath%) do set OutName=%%~nF%%~xF
FOR %%F in (%OutPath%) do set OutPathOnly=%%~dF%%~pF
IF /I NOT "%OutExt%"==".pdf" (SET OutName=%OutName%.pdf)
SET OutPath="%OutPathOnly%%OutName%"

IF DEFINED Name1 (
	Set ConfNames=Names: %Name1%, %Name2%, %Name3%, and %Name4%; ;Font Sizes: %Size1%, %Size2%, %Size3%, and %Size4%.
) ELSE (Set ConfNames=Tags will be printed without names)

Wbox "Confirm Settings" ^
 "You entered the following:; ;Input File Name: %FileName%; ;Tag Page #: %TagPage%; ;%ConfNames%; ;Your luggage tags will be combined into a file called ''%OutName%'' which will be placed in the following directory:;%OutPathOnly%; ;Is this information correct?" "Yes;No" /WW=320 /DB=1 /CR=; /OT /AL
IF Errorlevel 2 (GOTO AskAgain)


:Run
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
ECHO Rearranging Luggage Tags . . .
START Wbusy "Rearranging Luggage Tags" " Extracting Tag from Docs..." /marquee
gswin32c -q -dBATCH -dNOPAUSE -o tag1.tmp -sDEVICE=pdfwrite -dUseCropbox -dFirstPage=%TagPage% -dLastPage=%TagPage% %FilePath%

START Wbusy "Rearranging Luggage Tags" "Cropping Tag..." /marquee
xvi32 tag1.tmp /S=bin\crop.xsc
gswin32c -q -dBATCH -dNOPAUSE -o tag2.tmp -sDEVICE=pdfwrite -dUseCropbox tag1.tmp
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
ECHO Rearranging Luggage Tags . . .
xvi32 tag2.tmp /S=bin\uncrop.xsc
gswin32c -q -dBATCH -dNOPAUSE -o tagstamp.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [5.35 0]>>setpagedevice" -f tag2.tmp
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
ECHO Rearranging Luggage Tags . . .

START Wbusy "Rearranging Luggage Tags" "Creating 4 tags..." /marquee
gswin32c -q -dBATCH -dNOPAUSE -o tag1name.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=126 -dDEVICEHEIGHTPOINTS=792 ^
     -c "/Helvetica-Narrow-Bold findfont %Size1% scalefont setfont newpath 63 370.2 moveto (%Name1%) dup stringwidth pop 2 div neg 0 rmoveto show quit" -f
pdftk tagstamp.tmp stamp tag1name.tmp output tag1.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag2name.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=126 -dDEVICEHEIGHTPOINTS=792 ^
     -c "/Helvetica-Narrow-Bold findfont %Size2% scalefont setfont newpath 63 370.2 moveto (%Name2%) dup stringwidth pop 2 div neg 0 rmoveto show quit" -f
pdftk tagstamp.tmp stamp tag2name.tmp output tag2.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag3name.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=126 -dDEVICEHEIGHTPOINTS=792 ^
     -c "/Helvetica-Narrow-Bold findfont %Size3% scalefont setfont newpath 63 370.2 moveto (%Name3%) dup stringwidth pop 2 div neg 0 rmoveto show quit" -f
pdftk tagstamp.tmp stamp tag3name.tmp output tag3.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag4name.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=126 -dDEVICEHEIGHTPOINTS=792 ^
     -c "/Helvetica-Narrow-Bold findfont %Size4% scalefont setfont newpath 63 370.2 moveto (%Name4%) dup stringwidth pop 2 div neg 0 rmoveto show quit" -f
pdftk tagstamp.tmp stamp tag4name.tmp output tag4.tmp

START Wbusy "Rearranging Luggage Tags" "Arranging tags..." /marquee
gswin32c -q -dBATCH -dNOPAUSE -o tag1s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [-194.4 0]>>setpagedevice" -f tag1.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag2s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [-64.8 0]>>setpagedevice" -f tag2.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag3s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [64.8 0]>>setpagedevice" -f tag3.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag4s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [194.4 0]>>setpagedevice" -f tag4.tmp

START Wbusy "Rearranging Luggage Tags" "Combining tags onto 1 page..." /marquee
pdftk tag1s.tmp stamp tag2s.tmp output tag1.tmp
pdftk tag1.tmp stamp tag3s.tmp output tag2.tmp
pdftk tag2.tmp stamp tag4s.tmp output tag3.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tagstamp.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dDEVICEHEIGHTPOINTS=792 ^
     -c newpath 0 399.5 moveto 612 399.5 lineto 1 setlinewidth .784 setgray stroke ^
	 newpath 46.8 0 moveto 46.8 792 lineto stroke ^
	 newpath 176.4 0 moveto 176.4 792 lineto stroke ^
	 newpath 306.0 0 moveto 306.0 792 lineto stroke ^
	 newpath 435.6 0 moveto 435.6 792 lineto stroke ^
	 newpath 565.2 0 moveto 565.2 792 lineto stroke ^
	 quit -f
pdftk tag3.tmp stamp tagstamp.tmp output output.tmp

START Wbusy "Rearranging Luggage Tags" "Cleaning up..." /marquee
move /Y output.tmp %OutPath%
del /F /Q *.tmp
del /F /Q temp.bat
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
wait 1.0
Wbusy "Rearranging Luggage Tags" /stop

Wbox "Rearranging Luggage Tags" "Luggage Tag Rearrangement Complete.^ ^Would you like to display the combined document?" "Yes;No" /WW=320 /DB=1 /OT /AL
IF Errorlevel 2 (GOTO ReDO)
IF Errorlevel 1 (GOTO OpenPDF)
IF Errorlevel 0 (GOTO ReDO)

:OpenPDF
Wbox "Opening combined document..." ^
 "Press ''Open'' to open the combined PDF. When you are done, close your PDF reader to continue." "Open" /WW=320 /DB=1 /OT /AL

ECHO Close your PDF reader to continue . . .
%OutPath%


:ReDo
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
Wbox "%TitleStr%" ^
 "" ^
 "Start Over;Modify Current Tags;Additional PDF Tools;Exit" ^
  /WW=640 /BW=125 /DB=1 /OT /AL
IF Errorlevel 4 GOTO End
IF Errorlevel 3 GOTO Utils
IF Errorlevel 2 (
	Wbox "Returning to beginning..." ^
 "To replace the PDF document you just created, use the same output file name in the following steps.^ ^To create an additional PDF document, use a different output file name." OK /WW=320 /DB=1 /OT /AL
	GOTO AskAgain
)
IF Errorlevel 1 (
	Wbox "Returning to beginning..." ^
 "To replace the PDF document you just created, use the same output file name in the following steps.^ ^To create an additional PDF document, use a different output file name." OK /WW=320 /DB=1 /OT /AL
	GOTO Init
)
GOTO Init


REM ==============================================================================

:Utils
CLS
ECHO %TitleStr%
ECHO.
ECHO                      Additional PDF Processing Utilities                     
ECHO.
ECHO Close this window to exit.
ECHO.

IF NOT DEFINED OutPath (GOTO InFile)
FOR %%F in (%OutPath%) do set OutPathNQ=%%~F
Wbox "Additional PDF Processing Utilities" "Is %OutPathNQ% the PDF file you want to edit" "Yes;No" /WW=320 /DB=1 /OT /AL
IF Errorlevel 2 (GOTO InFile)
IF Errorlevel 1 (GOTO Menu)


:InFile
Wbox "Choose an Input PDF" ^
 "Press ''Open...'' to choose the PDF file that you want to edit." "Open..." /WW=350 /DB=1 /OT /AL
ECHO Opening File . . .
FileToOpen "SET OutPath=" ".\*.pdf" "Select your Cruise Documents PDF file..." > temp.bat
IF Errorlevel 1 (GOTO CancelUtilPick)
CALL temp.bat
ECHO %FilePath%
GOTO Menu


:CancelUtilPick
IF NOT DEFINED OutPath (GOTO Start)
GOTO ReDo


:Menu
CLS
ECHO %TitleStr%
ECHO.
ECHO                      Additional PDF Processing Utilities                     
ECHO.
ECHO Close this window to exit.
ECHO.
FOR %%F in (%OutPath%) do set OutName=%%~nF%%~xF
FOR %%F in (%OutPath%) do set OutPathNQ=%%~F
FOR %%F in (%OutPath%) do set OutPathOnly=%%~dF%%~pF

Wbox "Choose a PDF Processing option:" ^
 "Editing %OutPathNQ%^ ^All outputs from the following utilities will be saved in:^%OutPathOnly%^ ^Click on the tool you want to use on the next screen." OK /WW=640 /DB=1 /OT /AL

:Menu2
ECHO Add a 1/4 inch margin to the top and bottom of %OutName% > temp.bat
ECHO. >> temp.bat
ECHO Produce a 2-page PDF from %OutName% >> temp.bat
ECHO. >> temp.bat
ECHO Convert %OutName% to a PNG image >> temp.bat
ECHO. >> temp.bat
ECHO Extract a single page from %OutName% >> temp.bat
ECHO. >> temp.bat
ECHO Choose a new input file >> temp.bat
ECHO. >> temp.bat
ECHO Return to main menu >> temp.bat
Wselect temp.bat "Choose a PDF Processing option:" /menu /cmdCenter /ontop /grid
ECHO.
IF Errorlevel 11 GOTO ReDo
IF Errorlevel 9 GOTO InFile
IF Errorlevel 7 GOTO Extract
IF Errorlevel 5 GOTO MakePNG
IF Errorlevel 3 GOTO TwoPage
IF Errorlevel 1 GOTO Margin
GOTO ReDo


:Margin
gswin32c -q -dBATCH -dNOPAUSE -o "%OutPathOnly%margin%OutName%" -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dDEVICEHEIGHTPOINTS=792 -dFIXEDMEDIA -c "<</Install {13.77 17.82 translate .955 .955 scale } bind >> setpagedevice" -f %OutPath%
Wbox "Additional PDF Processing Utilities" "%OutPathOnly%margin%OutName% created from %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu2


:TwoPage
gswin32c -q -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -o "%OutPathOnly%2x%OutName%" %OutPath% %OutPath%
Wbox "Additional PDF Processing Utilities" "2-page PDF %OutPathOnly%2x%OutName% created from from %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu2


:MakePNG
SET Dpi=300

winput "Additional PDF Processing Utilities" "SET Dpi=$input" ^
 "Enter PNG resolution in DPI:" "%Dpi%" /num > temp.bat
IF ERRORLEVEL 1 GOTO Menu2
CALL temp.bat

START Wbusy "Additional PDF Processing Utilities" "Creating PNG Image..." /marquee
gswin32c -dBATCH -dNOPAUSE -sDEVICE=png16m -sOutputFile="%OutPathOnly%%OutName%.png" -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -r720 -q %OutPath% -c quit
Wbusy "Additional PDF Processing Utilities" /stop
Wbox "Additional PDF Processing Utilities" "%Dpi% DPI PNG image %OutPathOnly%2x%OutName% created from from %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu2


:Extract
SET TagPage=
winput "Additional PDF Processing Utilities" "SET Dpi=$input" ^
 "What page would you like to extract from %OutName%?" "" /num > temp.bat
IF ERRORLEVEL 1 GOTO Menu2
CALL temp.bat

IF NOT DEFINED TagPage (GOTO Menu)
gswin32c -q -dBATCH -dNOPAUSE -o "%OutPathOnly%pg%TagPage%_%OutName%" -sDEVICE=pdfwrite -dFirstPage=%TagPage% -dLastPage=%TagPage% %OutPath%
Wbox "Additional PDF Processing Utilities" "File pg%TagPage%_%OutName% created from page %TagPage% of %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu2


:End
del /F /Q *.tmp
del /F /Q temp.bat