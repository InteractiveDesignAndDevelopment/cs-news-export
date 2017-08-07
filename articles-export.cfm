<!--- <cfcontent type="text//xml"> --->
<cfscript>
  // cfcontent('text//xml');
  WriteOutput(new components.NewsArticles().all().toXML());
</cfscript>
