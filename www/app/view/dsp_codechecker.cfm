<!DOCTYPE html>
<html lang="en" itemscope itemtype="http://schema.org/Product">
	<head>
		<title>CodeChecker</title>
		<link rel="stylesheet" type="text/css" href="../assets/css/_tables.css" />
	</head>
	<body>
		<cfoutput>
        
			<div style="float:right;">
                               <!--- <input type="button" value="Export to Sheet" onclick="getSheet();">--->
                                <a href="print.cfm">Export To Sheet</a>
				<a href="frm_codechecker.cfm">
					Back to Code Checker Form
				</a>
			</div>
			<cfif ArrayLen(session.failedfiles)>
				<h3>Files Not Found</h3>
				<cfdump var="#session.failedfiles#">
				<hr />
			</cfif>
			<h3>Code Review Results</h3>
			<table class="results">
				<thead>
					<tr>
						<th>Directory</th>
						<th>File</th>
						<th>Rule</th>
						<th>Message</th>
						<th>Line Number</th>
						<th>Category</th>
						<th>Severity</th>
					</tr>
				</thead>
				<tbody>
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
<cfquery name="groups" dbtype="query">
select directory,file,rule,message,linenumber,category,severity from result order by category
</cfquery>
					<cfloop query="groups">
						<tr>
							<td>#groups.directory#</td>
							<td>#groups.file#</td>
							<td>#groups.rule#</td>
							<td>#groups.message#</td>
							<td>#groups.linenumber#</td>
							<td>#groups.category#</td>
							<td>#groups.severity#</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
		</cfoutput>

	</body>
</html>

