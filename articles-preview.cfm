<cfscript>

  /*
   * Examples to test with
   * - Empty paragraphs: 338731
   */

  LOCAL.articles = new components.NewsArticles().all();
  // LOCAL.articles = new components.NewsArticles().findByPageID(338731);

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
            <td>#encodeForXML(article.getCsTitle())#</td>
            <td>#encodeForXML(article.getTitle())#</td>
          </tr>
          <tr>
            <th>Content</th>
            <td>#encodeForXML(article.getCsContent())#</td>
            <td>#encodeForXML(article.getContent())#</td>
          </tr>
          <tr>
            <th>Excerpt</th>
            <td>#encodeForXML(article.getCsSummary())#</td>
            <td>#encodeForXML(article.getExcerpt())#</td>
          </tr>
          <tr>
            <th>Categories</th>
            <td colspan="2">#article.getCategories()#</td>
          </tr>
          <tr>
            <th>Tags</th>
            <td colspan="2">#article.getTags()#</td>
          </tr>
          <tr>
            <th>Images</th>
            <td colspan="2">#article.getImages()#</td>
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
