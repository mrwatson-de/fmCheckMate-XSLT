#About the fmCheckMate folder

The fmCheckMate folder is your working folder for fmCheckMate. 
It is where all the XSLT libraries and commands and fmxmlsnippet (clipboard) files are stored.

    ~/Documents/fmCheckMate/                   The fmCheckMate folder should be placed in your Documents folder

## About the files:

data files:

    fmxmlsnippet.xml  - Standard file containing the fmxmlsnippet XML from the clipboard
                        (automatically saved from fmCheckMate)
    Clipboard.graphml - Standard file to store generated graphs in graphml format
    Clipboard.svg     - Standard file to store generated svg images
    Clipboard.tgf     - Standard file to store generated graphs in trivial graph format (tgf)
    Clipboard.txt     - Standard file to store the contents of the (non-xml) clipboard
    Clipboard2.txt    - A second clipboard file - useful for comparing clipboard contents

documentation files:

    About the fmCheckMate folder README.md - this file
    LICENSE.txt                            - licencing info
    README.md                              - the main README file

ignore these files:

    fmCheckMate.xpr   - oXygen project file - you can igonre this

## About the folders:

    bin/   - (a few) unix commands (e.g. for TextMate users)
    docs/  - further documentation
    xml/   - xml files for use with fmCheckMate and other tools
    temp/  - temporary data used by fmCheckMate
    test/  - the place to find and put test data and files
    xsl/   - fmCheckMate's XSLT library // THIS IS THE INTERESTING STUFF!


**Note:** There is more interesting documentation in the docs folder.