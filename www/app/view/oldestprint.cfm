<cfscript>

result=queryNew("directory,file,rule,message,linenumber,category,severity");
for(var i=1; i<=ArrayLen(session.results);i=(i+1)){

queryAddRow(result);
querySetCell(result,"directory",session.results[i].directory);
querySetCell(result,"file",session.results[i].file);
querySetCell(result,"rule",session.results[i].rule);
querySetCell(result,"message",session.results[i].message);
querySetCell(result,"linenumber",session.results[i].linenumber);
querySetCell(result,"category",session.results[i].category);
querySetCell(result,"severity",session.results[i].severity);
}
</cfscript>

<cfquery name="standards" dbtype="query">
select directory,file,rule,message,linenumber,category,severity from result where category='Standards' order by category
</cfquery>
<cfquery name="maintenance" dbtype="query">
select directory,file,rule,message,linenumber,category,severity from result where category='Maintenance' order by category
</cfquery>
<cfquery name="varscoper" dbtype="query">
select directory,file,rule,message,linenumber,category,severity from result where category='VarScoper' order by category
</cfquery>
<cfquery name="queryparamscanner" dbtype="query">
select directory,file,rule,message,linenumber,category,severity from result where category='QueryParamScanner' order by category
</cfquery>
<cfquery name="performance" dbtype="query">
select directory,file,rule,message,linenumber,category,severity from result where category='Performance' order by category
</cfquery>
<cfquery name="security" dbtype="query">
select directory,file,rule,message,linenumber,category,severity from result where category='Security' order by category
</cfquery>


<cfscript>
spreadsheet = createObject('component','Spreadsheet').init();
spreadsheet = New spreadsheet();
workbook = spreadsheet.new();
if(standards.recordcount gt 0){
data = standards;
spreadsheet.createSheet( workbook,"Standards" );
spreadsheet.setActiveSheet(workbook,"Standards");
spreadsheet.addRow(workbook=workbook, data="directory,file,rule,message,linenumber,category,severity", autoSizeColumns=true);
spreadsheet.addRows(workbook,data);
}
if(maintenance.recordcount gt 0){
data1 = maintenance;
spreadsheet.createSheet( workbook,"Maintenance" );
spreadsheet.setActiveSheet(workbook,"Maintenance");
spreadsheet.addRows(workbook,data1);
}
if(varscoper.recordcount gt 0){
data2 = varscoper;
spreadsheet.createSheet( workbook,"VarScoper" );
spreadsheet.setActiveSheet(workbook,"VarScoper");
spreadsheet.addRows(workbook,data2);
}
if(performance.recordcount gt 0){
data3 = performance;
spreadsheet.createSheet( workbook,"Performance" );
spreadsheet.setActiveSheet(workbook,"Performance");
spreadsheet.addRows(workbook,data3);
}
if(security.recordcount gt 0){
data4 = security;
spreadsheet.createSheet( workbook,"Security" );
spreadsheet.setActiveSheet(workbook,"Security");
spreadsheet.addRows(workbook,data4);
}
if(queryparamscanner.recordcount gt 0){
data5 = queryparamscanner;
spreadsheet.createSheet( workbook,"QueryParamScanner" );
spreadsheet.setActiveSheet(workbook,"QueryParamScanner");
spreadsheet.addRows(workbook,data5);
}

spreadsheet.removesheet(workbook,"Sheet1");
spreadsheet.setActiveSheetNumber(workbook,1);
path = "checker.xls";
overwrite="yes";
spreadsheet.write( workbook,path,overwrite );
binary=spreadsheet.readBinary(workbook);
</cfscript>

<cfheader name="Content-Disposition" value="inline;filename=checker.xls">
<cfcontent type="application/vnd.ms-excel" variable="#binary#">








