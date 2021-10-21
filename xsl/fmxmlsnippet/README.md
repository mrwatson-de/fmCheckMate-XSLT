# About the xsl/fmxmlsnippet Folder

These XSLTs can be applied to the FileMaker clipboard.

The XSLT files follow the following naming convention:

`<source-type>_<target-type.subtype>_<NameInCamelCase>.xsl`

The source-types are:

- `XMAA` - FileMaker All/Any XML
- `XMFD` - FileMaker Field XML
- `XMFN` - FileMaker (Custom) Function XML
- `XML2` - FileMaker Layout XML Version 2 (FM12+)
- `XMLO` - FileMaker Layout XML Version 1 (FM11-)
- `XMSC` - FileMaker Script XML
- `XMSS` - FileMaker Script Step XML
- `XMTB` - FileMaker Table XML
- `XMTH` - FileMaker Theme XML
- `XMVL` - FileMaker ValueList XML

*Note* The abbreviations for Custom Menus XMM* are still a bit experimental, because they actually use the FMObjectTransfer XML internally, and at the original time of implmentation were not yet fully ripe:

- `XMME` - FileMaker Custom Menu XML 
- `XMMI` - FileMaker Custom Menu Item XML
- `XMMR` - FileMaker Custom Menu References XML
- `XMMS` - FileMaker Custom Menu Sets XML

The target-types are:

- all the source types except `XMAA`
- `fmCM`- output for fmCheckmate (for LayoutAnalysis results)
- `FMPXMLRESULT` - xml output for import into FileMaker
- `Text` - text output (muliple lines per item)
- `Text.Chart`- text output, that will be displayed in fmCheckmate as a chart
- `Text.Chart.Tops`- text output displayed in fmCheckmate as a 'top 10' chart
- `Text.Chart.Trafficlight`- text output
displayed in fmCheckmate as a trafficlight chart
- `Text.Lines` - line-oriented text output (generally 1 line per item)
- `Text.HTML` - HTML output
- `Text.Stats` - 
- `Text.SVG` - output as [scalable vector graphics](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics)
- `Text.Tab` - tab delimited table output.
  - If line 2 is a single '-', fmCheckMate renders this as an HTML table.
- `Text.tgf` - [trivial graph format](https://en.wikipedia.org/wiki/Trivial_Graph_Format) output
- `Text.xml` - xml output
- `Text.xml.graphml` - graphml output. fmCheckMate exports and opens this format.
- `XMDF` - FileMaker XML Default Fields format (FM19+)
- `XMDI` - FileMaker XML Default Items format (FM18-)
- `XSLT` - xslt file
