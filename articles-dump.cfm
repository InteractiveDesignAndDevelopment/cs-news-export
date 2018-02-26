<cfscript>

  // LOCAL.articles = new components.NewsArticles().all();
  // WriteDump(LOCAL.articles.toArray());
  LOCAL.articles = new components.NewsArticles().findByPageID(338731);
  LOCAL.articlesArray = LOCAL.articles.toArray();

</cfscript><cfoutput><!doctype html>
<html>
  <head>
    <title>#arrayLen(LOCAL.articlesArray)# Articles</title>
    <cfinclude template = "./includes/head.cfm">
  </head>
  <body>
    <cfinclude template = "./includes/top.cfm">

    <h1>#arrayLen(LOCAL.articlesArray)# Articles</h2>

    <cfloop array="#LOCAL.articlesArray#" index="article">
      <cfdump var="#article.toStructForExport(isEncodedForHTML = false)#">
    </cfloop>

    <cfinclude template = "./includes/top.cfm">
  </body>
</html>
</cfoutput>
