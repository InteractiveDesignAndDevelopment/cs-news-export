<cfscript>

  LOCAL.articles = new components.NewsArticles().all();
  // WriteDump(LOCAL.articles.toArray());
  // LOCAL.articles = new components.NewsArticles(113692);
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

    <div class="PreviewArticles">
      <cfloop array="#LOCAL.articlesArray#" index="article">
        <table class="PreviewArticle">
          <tr>
            <th>CSPageID</th>
            <td>#article.getCsPageID()#</td>
            <td>#article.getCsPageID()#</td>
          </tr>
          <tr>
            <th>Title</th>
            <td><pre><code>#htmlCodeFormat(article.getCsTitle())#</pre></code></td>
            <td><pre><code>#htmlCodeFormat(article.getTitle())#</pre></code></td>
          </tr>
          <tr>
            <th>Content</th>
            <td><pre><code>#htmlCodeFormat(article.getCsContent())#</pre></code></td>
            <td><pre><code>#htmlCodeFormat(article.getContent())#</pre></code></td>
          </tr>
          <tr>
            <th>Excerpt</th>
            <td><pre><code>#htmlCodeFormat(article.getCsSummary())#</pre></code></td>
            <td><pre><code>#htmlCodeformat(article.getExcerpt())#</pre></code></td>
          </tr>
        </table>
      </cfloop>
    </div>

    <!---<cfscript>
      ArrayEach(LOCAL.articlesArray, function(article) {

        var images = article.images();
        var links = article.links();

        var importableImages = article.images().importable();
        var importableLinks = article.links().importable();

        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

        WriteOutput('<h2>#article.getTitle()# (#article.getPageID()#)</h2>');

        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

        WriteOutput('<h3>Original Content</h3>');
        WriteOutput('<pre><code class="language-html">');
        WriteOutput(encodeForXML(article.getContent()));
        WriteOutput('</code></pre>');

        WriteOutput('<h3>Importable HTML</h3>');
        WriteOutput('<pre><code class="language-html">');
        WriteOutput(encodeForXML(article.getContent(true)));
        WriteOutput('</code></pre>');

        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

        WriteOutput('<h3>Summary Header Photo</h3>');
        WriteOutput('<div style="display: flex; width: 100%;">');

        WriteOutput('<div style="flex: 1">');
        WriteOutput('<h4>Original</h4>');
        if (0 < Len(article.getSummaryHeaderPhoto())) {
          WriteOutput(article.getSummaryHeaderPhoto());
        } else {
          WriteOutput('None');
        }
        WriteOutput('</div>');

        WriteOutput('<div style="flex: 1">');
        WriteOutput('<h4>Imported</h4>');
        if (0 < Len(article.getSummaryHeaderPhoto(true))) {
          WriteOutput(article.getSummaryHeaderPhoto(true));
        } else {
          WriteOutput('None');
        }
        WriteOutput('</div>');

        WriteOutput('</div>');  // flex

        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

        WriteOutput('<h3>Image URLs</h3>');
        WriteOutput('<div style="display: flex; width: 100%;">');

        WriteOutput('<div style="flex: 1">');
        WriteOutput('<h4>Original</h4>');
        if (0 < images.length()) {
          WriteOutput('<ul>');
          ArrayEach(images.toArray(), function(image) {
            // writeDump(image);
            WriteOutput('<li>#image.getURL()#</li>');
          });
          WriteOutput('</ul>');
        } else {
          WriteOutput('<div>None</div>');
        }
        WriteOutput('</div>');

        WriteOutput('<div style="flex: 1">');
        WriteOutput('<h4>Imported</h4>');
        if (0 < importableImages.length()) {
          WriteOutput('<ul>');
          ArrayEach(importableImages.toArray(), function(image) {
            // WriteDump(image.toStruct());
            WriteOutput('<li>#image.getURL()#</li>');
          });
          WriteOutput('</ul>');
        } else {
          WriteOutput('<div>None</div>');
        }
        WriteOutput('</div>');

        WriteOutput('</div>');  // flex

        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

        WriteOutput('<h3>Original Link URLs</h3>');
        WriteOutput('<div style="display: flex; width: 100%;">');

        WriteOutput('<div style="flex: 1">');
        WriteOutput('<h4>Original</h4>');
        if (0 < links.length()) {
          WriteOutput('<ul>');
          ArrayEach(links.toArray(), function(link) {
            WriteOutput('<li>#link.getUrl()#</li>');
          });
          WriteOutput('</ul>');
        } else {
          WriteOutput('None');
        }
        WriteOutput('</div>');

        WriteOutput('<div style="flex: 1">');
        WriteOutput('<h4>Imported</h4>');
        if (0 < importableLinks.length()) {
          WriteOutput('<ul>');
          ArrayEach(importableLinks.toArray(), function(link) {
            WriteOutput('<li>#link.getURL()#</li>');
          });
          WriteOutput('</ul>');
        } else {
          WriteOutput('None');
        }
        WriteOutput('</div>');

        WriteOutput('</div>');  // flex

        // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

      });

      // WriteOutput(new components.NewsArticles().all().toXML());
    </cfscript> --->

    <cfinclude template = "./includes/top.cfm">
  </body>
</html>
</cfoutput>
