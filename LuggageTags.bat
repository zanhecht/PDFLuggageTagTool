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
SET OutName=RCLTags.pdf

ECHO ==============================================================================
ECHO                     Royal Caribbean Luggage Tag Rearranger
ECHO ==============================================================================
ECHO.
ECHO This script will extract the luggage tags from your Royal Caribbean cruise
ECHO documents and place four of them on a single page for easy printing. It can
ECHO also insert names onto the luggage tags.
ECHO.
ECHO Please put the PDF cruise documents file in the same directory as this program
ECHO.
ECHO This script and its constituant programs are distributed under the GPL or
ECHO similar open licenses. Please see the doc folder for more information.
ECHO.
ECHO ===========Version 0.9 Created 01/03/2013 by ahecht on CruiseCritic===========
ECHO.
ECHO Hit the ENTER key after each entry
ECHO.
ECHO What would you like to do?
ECHO [1] Create a PDF page with 4 luggage tags
ECHO [2] Perform additional processing on an existing PDF file
ECHO [3] Exit
Choose32 -l -n -c 123 -p "[Press 1, 2, or 3] "
CLS
IF Errorlevel 3 GOTO End
IF Errorlevel 2 GOTO Utils
IF Errorlevel 1 GOTO Init
ECHO ERROR
PAUSE
GOTO End


:Init
SET FileName=""
SET TagPage=15
SET Name1=
SET Size1=12
SET Size2=12
SET Size3=12
SET Size4=12
SET OutName=RCLTags.pdf
ECHO Enter the file name of your Cruise Documents PDF File (including .pdf).
ECHO.
ECHO This file should be placed in the same directory as LuggageTags.bat.
ECHO.
ECHO You can type the first letter or letters of the file name and hit the TAB key
SET /p FileName=to automatically fill in the rest of the file name: 
IF NOT EXIST %FileName% (
	ECHO File not found.
	ECHO.
	GOTO Init
	)
GOTO Choices

:AskAgain
ECHO Enter the file name of your Cruise Documents PDF File (including .pdf).
ECHO.
ECHO This file should be placed in the same directory as LuggageTags.bat.
ECHO.
SET /p FileName=[Leave blank for %FileName%]: %=%
IF NOT EXIST %FileName% (
	ECHO File not found.
	ECHO.
	GOTO AskAgain
	)

:Choices
CLS
ECHO What page of the cruise documents PDF are your luggage tags on?
ECHO.
ECHO You can determine this by opening the cruise documents in Adobe Reader or
SET /p TagPage=other PDF software. [Leave blank for %TagPage%]:  %=%
CLS
IF NOT DEFINED Name1 (
	ECHO You can have this program insert the Guest Name onto the four luggage tags
	ECHO automatically. You can skip this step by leaving the name for tag #1 blank.
	ECHO.
	SET /p Name1=Enter Guest Name for Tag #1 [Leave blank to skip]: %=%
) ELSE (
	SET /p Name1=Enter Guest Name for Tag #1 [Leave blank for !Name1!]: %=%
	CLS
	ECHO Enter Guest Name for Tag #1 [Leave blank for !Name1!]: !Name1!
	ECHO.
	ECHO Most names will fit onto the luggage tags at font size 12. However, if your
	ECHO name is 15 letters or less, size 18 would be a better choice. If your name
	ECHO appears too large or too small on the finished tags, you can use the "Modify
	ECHO current tags" option at the end of this program to try a different size.
	ECHO.
	SET /p Size1=Enter Font Size for Tag #1 [Leave blank for !Size1!]: %=%
	CLS
	SET /p Name2=Enter Guest Name for Tag #2 [Leave blank for !Name2!]: %=%
	CLS
	ECHO Enter Guest Name for Tag #2 [Leave blank for !Name2!]: !Name2!
	ECHO.
	SET /p Size2=Enter Font Size for Tag #2 [Leave blank for !Size2!]: %=%
	CLS
	SET /p Name3=Enter Guest Name for Tag #3 [Leave blank for !Name3!]: %=%
	CLS
	ECHO Enter Guest Name for Tag #3 [Leave blank for !Name3!]: !Name3!
	ECHO.
	SET /p Size3=Enter Font Size for Tag #3 [Leave blank for !Size3!]: %=%
	CLS
	SET /p Name4=Enter Guest Name for Tag #4 [Leave blank for !Name4!]: %=%
	CLS
	ECHO Enter Guest Name for Tag #4 [Leave blank for !Name4!]: !Name4!
	ECHO.
	SET /p Size4=Enter Font Size for Tag #4 [Leave blank for !Size4!]: %=%
	CLS
	GOTO OutAgain
)
IF NOT DEFINED Name1 (
	SET Name2=
	SET Name3=
	SET Name4=
) ELSE (
	CLS
	ECHO You can have this program insert the Guest Name onto the four luggage tags
	ECHO automatically. You can skip this step by leaving the name for tag #1 blank.
	ECHO.
	ECHO Enter Guest Name for Tag #1 [Leave blank for !Name1!]: !Name1!
	ECHO.
	ECHO Most names will fit onto the luggage tags at font size 12. However, if your
	ECHO name is 15 letters or less, size 18 would be a better choice. If your name
	ECHO appears too large or too small on the finished tags, you can use the "Modify
	ECHO current tags" option at the end of this program to try a different size.
	ECHO.
	SET /p Size1=Enter Font Size for Tag #1 [Leave blank for !Size1!]: %=%
	CLS
	SET Name2=!Name1!
	Set Size2=!Size1!
	SET /p Name2=Enter Guest Name for Tag #2 [Leave blank for !Name2!]: %=%
	CLS
	ECHO Enter Guest Name for Tag #2 [Leave blank for !Name2!]: !Name2!
	ECHO.
	SET /p Size2=Enter Font Size for Tag #2 [Leave blank for !Size2!]: %=%
	CLS
	SET Name3=!Name2!
	Set Size3=!Size2!
	SET /p Name3=Enter Guest Name for Tag #3 [Leave blank for !Name3!]: %=%
	CLS
	ECHO Enter Guest Name for Tag #3 [Leave blank for !Name3!]: !Name3!
	ECHO.
	SET /p Size3=Enter Font Size for Tag #3 [Leave blank for !Size3!]: %=%
	CLS
	SET Name4=!Name3!
	Set Size4=!Size3!
	SET /p Name4=Enter Guest Name for Tag #4 [Leave blank for !Name4!]: %=%
	CLS
	ECHO Enter Guest Name for Tag #4 [Leave blank for !Name4!]: !Name4!
	ECHO.
	SET /p Size4=Enter Font Size for Tag #4 [Leave blank for !Size4!]: %=%
	CLS
)
:OutAgain
CLS
ECHO A new PDF file will be created with four luggage tags on a single page.
ECHO.
ECHO Enter a file name for this new PDF (including .pdf) 
SET /p OutName=[Leave blank for %OutName%]: %=%
IF EXIST "%OutName%" GOTO RepOut
:BackRepOut
CLS
ECHO You entered the following:
ECHO.
ECHO Input File Name: %FileName%
ECHO Tag Page: %TagPage%
IF DEFINED Name1 (
	ECHO Names: %Name1%, %Name2%, %Name3%, and %Name4%
	ECHO Font Sizes: %Size1%, %Size2%, %Size3%, and %Size4%.
) ELSE (ECHO Tags will be printed without names)
ECHO Your luggage tags will be combined into a file called %OutName%
ECHO which will be placed in the same directory as %FileName%
ECHO.
Choose32 -l -n -p "Is this correct [Press Y or N]? "
IF Errorlevel 2 (
	CLS	
	GOTO AskAgain
	)

:Run
CLS
ECHO Extracting Tag from Docs . . .
gswin32c -q -dBATCH -dNOPAUSE -o tag1.tmp -sDEVICE=pdfwrite -dUseCropbox -dFirstPage=%TagPage% -dLastPage=%TagPage% "%FileName%"


ECHO Cropping Tag . . .
xvi32.exe tag1.tmp /S=bin\crop.xsc
gswin32c -q -dBATCH -dNOPAUSE -o tag2.tmp -sDEVICE=pdfwrite -dUseCropbox tag1.tmp
CLS
ECHO Extracting Tag from Docs . . .
ECHO Cropping Tag . . .
xvi32.exe tag2.tmp /S=bin\uncrop.xsc
gswin32c -q -dBATCH -dNOPAUSE -o tagstamp.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [5.35 0]>>setpagedevice" -f tag2.tmp
CLS
ECHO Extracting Tag from Docs . . .
ECHO Cropping Tag . . .
ECHO Creating 4 tags . . .
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


ECHO Arranging tags . . .
gswin32c -q -dBATCH -dNOPAUSE -o tag1s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [-194.4 0]>>setpagedevice" -f tag1.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag2s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [-64.8 0]>>setpagedevice" -f tag2.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag3s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [64.8 0]>>setpagedevice" -f tag3.tmp
gswin32c -q -dBATCH -dNOPAUSE -o tag4s.tmp -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dFIXEDMEDIA -c "<</PageOffset [194.4 0]>>setpagedevice" -f tag4.tmp


ECHO Combining tags onto 1 page . . .
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


ECHO Cleaning up . . .
ren output.tmp "%OutName%"
del *.tmp

Choose32 -l -n -p "Would you like to display the combined document [Y or N]? "
IF Errorlevel 2 (
	CLS	
	GOTO ReDO
	)
ECHO Close your PDF reader to continue . . .
"%OutName%"

:ReDo
CLS
ECHO What would you like to do?
ECHO [1] Create new tags (start over)
ECHO [2] Modify current tags
ECHO [3] Additional PDF tools
ECHO [4] Exit
Choose32 -l -n -c 1234 -p "[Press 1, 2, 3 or 4] "
CLS
IF Errorlevel 4 GOTO End
IF Errorlevel 3 GOTO Utils
ECHO To replace the PDF document you just created, enter the same output file name.
ECHO To create an additional PDF document, enter a different output file name.
ECHO.
IF Errorlevel 2 GOTO AskAgain
IF Errorlevel 1 GOTO Init
ECHO ERROR!
PAUSE
GOTO End

:RepOut
Choose32 -l -n -p "File exists. Delete existing document [Y or N]? "
IF Errorlevel 2 (GOTO OutAgain) ELSE (del "%OutName%")
GOTO BackRepOut


:Utils
ECHO ==============================================================================
ECHO                      Additional PDF Processing Utilities                     
ECHO ==============================================================================
ECHO.

:InFile
SET /p OutName=Enter the file to manipulate [Leave blank for %OutName%]: %=%
IF NOT EXIST "%OutName%" (
	ECHO File not found.
	ECHO.
	GOTO InFile
	)

:Menu
CLS
ECHO Choose a PDF Processing option:
ECHO [1] Add a 1/4 inch margin to the top and bottom of %OutName%
ECHO [2] Produce a 2-page PDF from %OutName%
ECHO [3] Convert %OutName% to a PNG image
ECHO [4] Extract a single page from %OutName%
ECHO [5] Choose a new input file
ECHO [6] Return to main menu
Choose32 -l -n -c 123456 -p "[Press 1, 2, 3, 4 5, or 6] "
ECHO.
IF Errorlevel 6 GOTO ReDo
IF Errorlevel 5 GOTO InFile
IF Errorlevel 4 GOTO Extract
IF Errorlevel 3 GOTO MakePNG
IF Errorlevel 2 GOTO TwoPage
IF Errorlevel 1 GOTO Margin
ECHO ERROR
PAUSE
GOTO End

:Margin
gswin32c -q -dBATCH -dNOPAUSE -o "pad%OutName%" -sDEVICE=pdfwrite -dDEVICEWIDTHPOINTS=612 -dDEVICEHEIGHTPOINTS=792 -dFIXEDMEDIA -c "<</Install {13.77 17.82 translate .955 .955 scale } bind >> setpagedevice" -f "%OutName%"
ECHO.
ECHO File pad%OutName% created!
ECHO.
PAUSE
GOTO Menu

:TwoPage
gswin32c -q -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -o "2x%OutName%" "%OutName%" "%OutName%"
ECHO.
ECHO File 2x%OutName% created!
ECHO.
PAUSE
GOTO Menu

:MakePNG
SET Dpi=720
SET /p Dpi=Enter PNG resolution in DPI [Leave blank for %Dpi%]: %=%
gswin32c -dBATCH -dNOPAUSE -sDEVICE=png16m -sOutputFile="%OutName%.png" -dGraphicsAlphaBits=4 -dTextAlphaBits=4 -r720 -q "%OutName%" -c quit
ECHO.
ECHO File %OutName%.png created at %Dpi% DPI!
ECHO.
PAUSE
GOTO Menu

:Extract
ECHO What page of the cruise documents PDF are your luggage tags on?
ECHO You can determine this by opening the cruise documents in Adobe Reader or
SET /p TagPage=other PDF software. [Leave blank for %TagPage%]  %=%
gswin32c -q -dBATCH -dNOPAUSE -o "pg%TagPage%_%OutName%" -sDEVICE=pdfwrite -dFirstPage=%TagPage% -dLastPage=%TagPage% "%OutName%"
ECHO.
ECHO File pg%TagPage%_%OutName% created from page %TagPage% of %OutName%!
ECHO.
PAUSE
GOTO Menu

:End