# About the xsl Folder

Great folder - this is where all the xsl goodies are stored!

- XSLTs are grouped together in subfolders based on the *flavour* of XML that they transform.
- The main folders are the **fmxmlsnippet** and **FMObjectTransfer** folders,
  which contain the XSLTs for transforming FM-clipboard objects.
- The xml, xsl and _inc subfolders are mostly only interesting if you are considering developing your own XSLTs

**Important:** *DON'T* edit or add to the contents of this folder because the contents get
overwritten when you get a new version of fmCheckMate-XSLT library.

**Caution:** *Some stuff in this folder has not been used for a while and may not do what you expect.*


Subfolders

- [_inc/](_inc/README.md) - xslt  building block files which are included in other xslts are placed here
- [FMObjectTransfer/](FMObjectTransfer/README.md) - XSLTs that transform the new (CustomMenus) - FMObjectTransfer XML syntax
- [fmxmlsnippet/](fmxmlsnippet/README.md) - XSLTs that transform FileMaker clipboard XML (so called xml snippet) syntax
- [xml/](xml/README.md) - generic XSLTs that transform ANY xml file
- [xsl/](xsl/README.md) - XSLTs for transforming XSLTs

History

    20130628 MrW Original README file
    20180711 MrW Standardised the README files