<cfscript>
spreadsheet =   New spreadsheet();
data = QueryNew( "First,Last","VarChar,VarChar",[ [ "Susi","Sorglos" ],[ "Julian","Halliwell" ] ] );
workbook = spreadsheet.new();
spreadsheet.addRows( workbook,data );
data2 = QueryNew( "First,Last","VarChar,VarChar",[ [ "Susi","Sorglos" ],[ "Julian","Halliwell" ] ] );
spreadsheet.createSheet( workbook,"VarScoper" );
spreadsheet.setActiveSheet(workbook, "VarScoper");
spreadsheet.addRows( workbook,data2 );
binary = spreadsheet.readBinary(workbook);
</cfscript>
<cfheader name="Content-Disposition" value="inline; filename=foo.xls">
<cfcontent type="application/vnd.ms-excel" variable="#binary#">