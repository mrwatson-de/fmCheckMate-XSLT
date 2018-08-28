![fmCM.logo][]

#fmCheckMate-XSLT Library

The fmCheckMate-XSLT library extends the [fmCheckMate][] tool in the [fmWorkMate][] toolbox, and gives FileMaker
Database Developers the ability to analyse, change and transform their
FileMaker work like never before!

## 1. Getting started

You are not far away from having the best tools that money can't buy! -
It's as easy as ABC:

### A: Prerequisites

To use the fmCheckMate XSLT Library, if you don't have it already, you will need
to download and install MrWatson's fmWorkMate toolbox:

1. Download fmWorkMate from the [fmWorkMate downloads page][] ![fmWM.logo][]
2. Copy fmWorkMate to your Applications folder (or the Documents folder, or wherever you want)

### B: Installing this fmCheckMate XSLT Library

Simply:

1. Get hold of the latest fmCheckMate XSLT library:
   - either use the copy in the latest fmWorkMate Bundle (from the [fmWorkMate downloads page][])
   - or download the latest version from the [fmCheckMate-XSLT GitHub repository][]
     - (in which case you need to unpack it and rename the folder simply to fmCheckMate)
2. Copy the fmCheckMate folder to your Documents folder.

That's it!

### C: Doing your first transformation

Once you have copied some FileMaker objects, just:

1. Start fmWorkMate, open the fmCheckMate tool.
2. Press the **[Convert Clipboard FM <-> XML]** button
3. Press the **[T]** button in the XML-Editor view.
   - Note: if updating your XSLT libarary, press the **[Reimport]** button
     to refresh the XSLT list.
4. Choose an analyse, change or transformation function
   -  Note: You can press the **[View]** button to switch between list + tree view
5. Press the **[-> FM]** Button to convert the XML back to FileMaker objects

Then just paste the changed objects back into FileMaker.


###Tip => Always check for pasting errors!

Use one of the following methods to check for errors when pasting objects
back into FileMaker!

- When pasting *Custom Functions*
  --> use an **fmCheckMate XSLT function** to check if custom functions have been commented out,
  
- When pasting *Layout Objects*
  --> use an **fmCheckMate XSLT function** to analyse the layout objects for errors
  
- When pasting *Tables*, *Fields*, *Scripts*, *Steps*, etc.
  --> use [fmLogAnalyser] to check the Import.log


## 2. Next Steps

###Try out some of the cool transformations:

* Copy scripts and **analyse** their script calls
* Copy script steps and **change** old Replace Field Contents steps into a Set Field Loop
* Copy fields and **analyse** them, listing their definitions
* Copy layout objects and **analyse** them for errors

###Learn more

Google fmCheckMate -> you may find some videos + further help

###What's new in this Version?

See [fmCheckMate Changes.md](docs/fmCheckMate Changes.md)

## 3. Blah, blah

### License

See the [LICENSE.txt](LICENSE.txt) file for details.


### Authors

* **MrWatson** - *Initial work*

This document: 20180711 MrW Version 2.0.1

[fmWorkMate]: http://www.fmworkmate.com
[fmWorkMate downloads page]: http://fmworkmate.com/downloads
[fmCheckMate]: http://www.fmworkmate.com/fmcheckmate
[fmCM.logo]: http://www.fmworkmate.com/fmCM_XSLT_Folder_sm.png
[fmWM.logo]: http://www.fmworkmate.com/fmWorkMate_ICON_128x128.png
[fmCheckMate-XSLT GitHub repository]: https://github.com/mrwatson-de/fmCheckMate-XSLT