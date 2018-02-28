<cfcontent type="text/xml">
<cfscript>
  LOCAL.articles = new components.NewsArticles().all().toArray();
  LOCAL.articles = ArrayMap(LOCAL.articles, function(article) {
    // return article.toStructForExport();
    return article.toXML();
  });
  // WriteDump(LOCAL.articles);
  writeOutput('<?xml version="1.0"?>');
  writeOutput('<articles>');
  arrayEach(LOCAL.articles, function(article) {
    writeOutput(article);
  });
  writeOutput('</articles>');
</cfscript>
