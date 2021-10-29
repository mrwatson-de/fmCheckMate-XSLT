# Make your own customized fmCheckMate XSLT library and functions

fmCheckMate has been designed to provide powerful transformations, however, not everybody works in the same way, so you may wish to 'tinker' with the functions to fit your needs better - or, once you have the hang of the fmCheckMate XSLT, even write your own functions.

For this reason support for individual, customised XSLT libraries was built into fmCheckMate from the start.

All subfolders of the documents folder that begin with "fmCheckMate" are scanned for XSLT files, so...

# Tweaking and tinkering: What NOT to do

You *could* just edit the XSLT files in the fmCheckMate XSLT library directly, _however_, when you get the next fmCheckMate XSLT update, all your changes will be lost.

Instead, we recommend you create your own XSLT Library, where you can create XSLTs and play to your hearts content, with no fear of losing your work.

# Making your own fmCheckMate XSLT library

Simply create your own XSLT library by creating a folder in your *documents* folder

	Users/username/Documents/fmCheckMate.YourUniqueDomainIdentifier/
	Users/username/Documents/fmCheckMate.YourUniqueDomainIdentifier/xsl/
	Users/username/Documents/fmCheckMate.YourUniqueDomainIdentifier/xsl/_inc
	Users/username/Documents/fmCheckMate.YourUniqueDomainIdentifier/xsl/fmxmlsnippet

For example, my own XSLT library is called: "fmCheckMate.mrwatson.de"

# Creating your own / modifying the standard Layout Analysis transformation

1. Create the folder hierarchy:

`fmCheckMate.YourUniqueDomainName/xsl/fmxmlsnippets`

2. Copy the file `XML2_XML2_LayoutAnalysis.xsl` to that folder
3. Rename the file has necessaryTo illustrate its function– Use CamelCase for the file name.
4. Edit the file
   
   (At this pointYou may wishTo learn XSLT if you haven't done so yet! 😆)

6. Save your XML file

Then 
- Copy the layout to analyse.
- Open fmCheckMate and convert to XML
- Press the Transform button
- Reimport the XSLTs ; Your library will be imported
- Find and run your file

Voilá!

# Working with includes files in your XSLTs

You'll notice that all referenced / included files start with `../../../fmCheckMate/`

This is so that when you copy an XSLT file to your custom XSLT Libarary, it will continue to reference the iclude-files in the fmCheckMate library.

Thus if you need to reference include files from your own XSLT Libraray, replace these references with `../../../fmCheckMate/`

In your XML

- Only use <xsl:include>
- Do not use <xsl:import>

ToDo
