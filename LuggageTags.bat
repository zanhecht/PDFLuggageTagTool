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
Set TitleStr=Royal Caribbean Luggage Tag Tool Version 2.1 Created 02/23/2013 by ahecht


:Start
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
del /F /Q *.tmp 2>NUL
Wbox "%TitleStr%" ^
 "This script will extract the luggage tags from your Royal Caribbean cruise documents. It can place four of them on a single page for easy printing, insert names onto the tags, and perform a variety of other functions.^^This script and its constituant programs are distributed under the GPL or similar open licenses. Please see the doc folder for more information.^^This program is in no way affiliated with nor endorsed by Royal Caribbean International or Royal Caribbean Cruises Ltd." ^
 "Create page with 4 tags;Add names to single tags;Additional PDF tools;Exit" ^
  /WW=640 /BW=150 /DB=1 /OT /AL
IF Errorlevel 4 GOTO End
IF Errorlevel 3 GOTO Menu
IF Errorlevel 2 GOTO NameTags
IF Errorlevel 1 GOTO ChooseDocs
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
 "Your cruise documents are a long PDF file with ''GUEST TICKET BOOKLET'' on the first page. You can get this file from www.royalcaribbean.com/edocs or your travel agent 40-45 days before your cruise.^ ^Hit the ''Open...'' button below and select your cruise documents PDF file. " "Open..." /WW=320 /DB=1 /OT /AL
ECHO Opening File . . .
FileToOpen "SET FilePath=" ".\*.pdf" "Select your Cruise Documents PDF file..." > temp.bat
IF Errorlevel 1 (GOTO End)
CALL temp.bat
REM ECHO %FilePath%
FOR %%F in (%FilePath%) do set FileName=%%~nF%%~xF

winput "Page Number" "SET TagPage=$input" ^
 "What page of %FileName% are your luggage tags on?^ ^You can determine this by opening the cruise documents in Adobe Reader or other PDF software." ^
 "%TagPage%" /num > temp.bat
CALL temp.bat

GOTO Choices


:AskAgain
FOR %%F in (%FilePath%) do set FilePathNQ=%%~F
Wbox "Select your Cruise Documents PDF file..." ^
 "Are your luggage tags on page %TagPage% of ''%FilePathNQ%''?" "Yes;No" /WW=320 /DB=1 /OT /AL
IF Errorlevel 2 (GOTO ChooseDocs)

:Choices
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
IF Errorlevel 1 (GOTO ReDo)
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
gswin32c -q -dBATCH -dNOPAUSE -o tag2.tmp -sDEVICE=pdfwrite -dUseCropbox tag1.tmp 2>NUL
xvi32 tag2.tmp /S=bin\uncrop.xsc
gswin32c -q -dBATCH -dNOPAUSE -o tagstamp.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [5.35 0]>>setpagedevice" -f tag2.tmp 2>NUL

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
move /Y output.tmp %OutPath% 2>NUL
del /F /Q *.tmp 2>NUL
del /F /Q temp.bat 2>NUL
wait 1.0
Wbusy "Rearranging Luggage Tags" /stop

Wbox "Rearranging Luggage Tags" "Luggage Tag Rearrangement Complete.^ ^Would you like to display the combined document?" "Yes;No" /WW=320 /DB=1 /OT /AL
IF Errorlevel 2 (GOTO ReDo)
IF Errorlevel 1 (GOTO OpenPDF)
IF Errorlevel 0 (GOTO ReDo)

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
 "Start Over;Modify Current Tags;Main Menu;Exit" ^
  /WW=640 /BW=125 /DB=1 /OT /AL
IF Errorlevel 4 GOTO End
IF Errorlevel 3 GOTO Start
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
GOTO End


REM ==============================================================================

:Menu
CLS
ECHO %TitleStr%
ECHO.
ECHO                      Additional PDF Processing Utilities                     
ECHO.
ECHO Close this window to exit.
ECHO.
ECHO Add a 1/4 inch margin to the top and bottom of PDF > temp.bat
ECHO. >> temp.bat
ECHO Produce a 2-page PDF from a single-page PDF >> temp.bat
ECHO. >> temp.bat
ECHO Convert first page of PDF to a PNG image >> temp.bat
ECHO. >> temp.bat
ECHO Extract a single page from PDF >> temp.bat
ECHO. >> temp.bat
ECHO Return to main menu >> temp.bat
Wselect temp.bat "Choose a PDF Processing option:" /menu /cmdCenter /ontop /grid
SET UtilMenu=%ERRORLEVEL%
ECHO.

IF !UtilMenu!==9 GOTO Start
IF !UtilMenu!==0 GOTO Start

Wbox "Choose an Input PDF" ^
 "Press ''Open...'' to choose the PDF file that you want to edit." "Open..." /WW=350 /DB=1 /OT /AL
ECHO Opening File . . .
FileToOpen "SET OutPath=" ".\*.pdf" "Select PDF file to edit..." > temp.bat
IF Errorlevel 1 (GOTO CancelUtilPick)
CALL temp.bat
ECHO %OutPath%
FOR %%F in (%OutPath%) do set OutName=%%~nF%%~xF
FOR %%F in (%OutPath%) do set OutPathNQ=%%~F
FOR %%F in (%OutPath%) do set OutPathOnly=%%~dF%%~pF


IF !UtilMenu!==7 GOTO Extract
IF !UtilMenu!==5 GOTO MakePNG
IF !UtilMenu!==3 GOTO TwoPage
IF !UtilMenu!==1 GOTO Margin
GOTO Menu


:Margin
gswin32c -q -dBATCH -dNOPAUSE -o "%OutPathOnly%margin%OutName%" -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dDEVICEHEIGHTPOINTS=792 -dFIXEDMEDIA -c "<</Install {13.77 17.82 translate .955 .955 scale } bind >> setpagedevice" -f %OutPath%
Wbox "Additional PDF Processing Utilities" "%OutPathOnly%margin%OutName% created from %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu


:TwoPage
gswin32c -q -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -o "%OutPathOnly%2x%OutName%" %OutPath% %OutPath%
Wbox "Additional PDF Processing Utilities" "2-page PDF %OutPathOnly%2x%OutName% created from from %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu


:MakePNG
SET Dpi=300

winput "Additional PDF Processing Utilities" "SET Dpi=$input" ^
 "Enter PNG resolution in DPI:" "%Dpi%" > temp.bat
IF ERRORLEVEL 1 GOTO Menu
CALL temp.bat

START Wbusy "Additional PDF Processing Utilities" "Creating PNG Image..." /marquee
gswin32c -dBATCH -dNOPAUSE -sDEVICE=png16m -sOutputFile="%OutPathOnly%%OutName%.png" -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -r%Dpi% -q %OutPath% -c quit
Wbusy "Additional PDF Processing Utilities" /stop
Wbox "Additional PDF Processing Utilities" "%Dpi% DPI PNG image %OutPathOnly%2x%OutName% created from from %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu


:Extract
SET TagPage=
winput "Additional PDF Processing Utilities" "SET TagPage=$input" ^
 "What page would you like to extract from %OutName%?" "%TagPage%" /num > temp.bat
IF ERRORLEVEL 1 GOTO Menu
CALL temp.bat

IF NOT DEFINED TagPage (GOTO Menu)
gswin32c -q -dBATCH -dNOPAUSE -o "%OutPathOnly%pg%TagPage%_%OutName%" -sDEVICE=pdfwrite -dFirstPage=%TagPage% -dLastPage=%TagPage% %OutPath%
Wbox "Additional PDF Processing Utilities" "File pg%TagPage%_%OutName% created from page %TagPage% of %OutName%." OK /WW=640 /DB=1 /OT /AL
GOTO Menu


REM ==============================================================================

:NameTags
IF Exist FilePath GOTO NTAskAgain


:NTChooseDocs
Wbox "Select your Cruise Documents PDF file..." ^
 "Your cruise documents are a long PDF file with ''GUEST TICKET BOOKLET'' on the first page. You can get this file from RoyalCaribbean.com or your travel agent 40-45 days before your cruise.^ ^Hit the ''Open...'' button below and select your cruise documents PDF file. " "Open..." /WW=320 /DB=1 /OT /AL
ECHO Opening File . . .
FileToOpen "SET FilePath=" ".\*.pdf" "Select your Cruise Documents PDF file..." > temp.bat
IF Errorlevel 1 (GOTO End)
CALL temp.bat
REM ECHO %FilePath%
FOR %%F in (%FilePath%) do set FileName=%%~nF%%~xF

winput "Page Number" "SET TagPage=$input" ^
 "What page of %FileName% are your luggage tags on?^ ^You can determine this by opening the cruise documents in Adobe Reader or other PDF software." ^
 "%TagPage%" /num > temp.bat
CALL temp.bat

GOTO NTChoices


:NTAskAgain
FOR %%F in (%FilePath%) do set FilePathNQ=%%~F
Wbox "Select your Cruise Documents PDF file..." ^
 "Are your luggage tags on page %TagPage% of ''%FilePathNQ%''?" "Yes;No" /WW=320 /DB=1 /OT /AL
IF Errorlevel 2 (GOTO NTChooseDocs)


:NTChoices

IF NOT DEFINED Name1 (
	winput "Guest" "SET Name1=$input" ^
 "Enter a guest name to insert into your luggage tags:" > temp.bat
	IF Errorlevel 1 (SET Name1=)
	CALL temp.bat
) ELSE (
	winput "Guest Name" "SET Name1=$input" ^
 "Enter a guest name to insert into your luggage tags:" "!Name1!" > temp.bat
	IF Errorlevel 1 (SET Name1=)
	CALL temp.bat
)

IF NOT DEFINED Name1 GOTO NTReDo

winput "Font Size" "SET Size1=$input" ^
 "Most names will fit onto the luggage tags at font size 12. However, if your^name is 15 letters or less, size 18 would be a better choice. If your name^appears too large or too small on the finished tags, you can use the ''Modify^current tags'' option at the end of this program to try a different size.^ ^Enter a font size for the name on your luggage tags:" "%Size1%" /num > temp.bat
CALL temp.bat


:NTOut
Wbox "Save As..." ^
 "A new PDF file will be created of luggage tags with ''%Name1%'' inserted onto them.^ ^Click on ''Save As...'' below to choose a name and location for this new PDF file. It should be different from the name of your cruise documents." "Save As..." /WW=320 /DB=1 /AL /OT
SET NTOutName=%Name1% Tags.pdf
FileToSave "SET NTOutPath=" "%~dp0*.pdf" "Save As..." "%NTOutName%" /overwritePrompt > temp.bat
IF Errorlevel 1 (GOTO NTReDo)
CALL temp.bat

FOR %%F in (%NTOutPath%) do set NTOutExt=%%~xF
FOR %%F in (%NTOutPath%) do set NTOutName=%%~nF%%~xF
FOR %%F in (%NTOutPath%) do set NTOutPathOnly=%%~dF%%~pF
IF /I NOT "%NTOutExt%"==".pdf" (SET NTOutName=%NTOutName%.pdf)
SET NTOutPath="%NTOutPathOnly%%NTOutName%"


:NTRun
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
ECHO Inserting Name onto Luggage Tags . . .

START Wbusy "Inserting Name onto Luggage Tags..." /marquee
gswin32c -q -dBATCH -dNOPAUSE -o tag1.tmp -sDEVICE=pdfwrite -dFirstPage=%TagPage% -dLastPage=%TagPage% %FilePath%
gswin32c -q -dBATCH -dNOPAUSE -o tag1name.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dDEVICEHEIGHTPOINTS=792 ^
 -c "/Helvetica-Narrow-Bold findfont %Size1% scalefont setfont newpath 300.75 370.2 moveto (%Name1%) dup stringwidth pop 2 div neg 0 rmoveto show quit" -f
pdftk tag1.tmp stamp tag1name.tmp output %NTOutPath%

del /F /Q *.tmp 2>NUL
del /F /Q temp.bat 2>NUL
REM wait 1.0
Wbusy "Inserting Name onto Luggage Tags..." /stop

Wbox "Inserting Name onto Luggage Tags" "Name Insertion Complete.^ ^Would you like to display the combined document?" "Yes;No" /WW=320 /DB=1 /OT /AL
IF Errorlevel 2 (GOTO NTReDo)
IF Errorlevel 1 (GOTO NTOpenPDF)
IF Errorlevel 0 (GOTO NTReDo)

:NTOpenPDF
Wbox "Opening combined document..." ^
 "Press ''Open'' to open the combined PDF. When you are done, close your PDF reader to continue." "Open" /WW=320 /DB=1 /OT /AL

ECHO Close your PDF reader to continue . . .
%NTOutPath%

:NTReDo
CLS
ECHO %TitleStr%
ECHO.
ECHO Close this window to exit.
ECHO.
Wbox "%TitleStr%" ^
 "" ^
 "Insert Another Name;Main Menu;Exit" ^
  /WW=480 /BW=125 /DB=1 /OT /AL
IF Errorlevel 3 GOTO End
IF Errorlevel 2 GOTO Start
IF Errorlevel 1 GOTO NTAskAgain
GOTO Start

:End
del /F /Q *.tmp 2>NUL
del /F /Q temp.bat 2>NUL