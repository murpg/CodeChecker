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

<!---This returns a distinct list of comma seperated categories--->
<cfset vCategories = createObject("component", "model.getCategories").ListDeleteDuplicates(ValueList(result.category))>

<!--- Queries are created named from the categories --->
<cfloop index="k" list="#vCategories#">
	<cfquery name="#k#" dbtype="query">
		select directory,file,rule,message,linenumber,category,severity from result where category='#k#' order by category
	</cfquery>
</cfloop>

<!--- Spreadsheet gets dynamically created --->
<cfscript>
		counter = 0;
		spreadsheet = createObject('component','Spreadsheet').init();
		spreadsheet = New spreadsheet();
		workbook = spreadsheet.new();
for(i=1;i<=ListLen(vCategories);i++){
		counter = counter + 1;
		value = ListGetAt(vCategories, i);
		rc = value & '.recordcount';
		if(rc gt 0); {
		data = 'data' & counter;
		data = Evaluate(value);
		spreadsheet.createSheet( workbook,#LCase(value)#);
		spreadsheet.setActiveSheet(workbook,#LCase(value)#);
		spreadsheet.addRow(workbook=workbook, data="directory,file,rule,message,linenumber,category,severity,Developer-Assigned,Status", autoSizeColumns=true);
		spreadsheet.addRows(workbook,data);
		}
}

		spreadsheet.removesheet(workbook,"Sheet1");
		spreadsheet.setActiveSheetNumber(workbook,1);
		//path = "checker.xls";
		//overwrite="yes";
		//spreadsheet.write( workbook,path,overwrite );
		binary=spreadsheet.readBinary(workbook);
</cfscript>
<cfheader name="Content-Disposition" value="inline;filename=checker.xls">
<cfcontent type="application/vnd.ms-excel" variable="#binary#">








