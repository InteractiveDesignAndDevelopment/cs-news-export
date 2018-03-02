<cfcontent type="text/xml">
<cfscript>
  LOCAL.authors = new components.Authors().unique().sort().toArray();
  LOCAL.authors = ArrayMap(LOCAL.authors, function(author) {
    // return article.toStructForExport();
    return author.toXML();
  });
  // WriteDump(LOCAL.authors);
  writeOutput('<?xml version="1.0"?>');
  writeOutput('<authors>');
  arrayEach(LOCAL.authors, function(author) {
    writeOutput(author);
  });
  writeOutput('</authors>');
</cfscript>
