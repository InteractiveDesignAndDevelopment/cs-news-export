<cfoutput>
<!doctype html>
<html>
  <head>
    <title>Export News Articles</title>
    <script src="https://cdn.jsdelivr.net/prism/1.6.0/prism.js"></script>
    <link href="https://cdn.jsdelivr.net/g/prism@1.6.0(themes/prism.css+themes/prism-coy.css)" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/normalize/7.0.0/normalize.css" rel="stylesheet">
    <style>
      body {
        padding: 1rem;
      }
    </style>
  </head>
  <body>
</cfoutput>
<cfscript>

  LOCAL.articles = new components.NewsArticles().all();
  // WriteDump(LOCAL.articles.toArray());
  // LOCAL.articles = new components.NewsArticles(113692);

  ArrayEach(LOCAL.articles.toArray(), function(article) {

    var images = article.images();
    var links = article.links();

    var importableImages = article.images().importable();
    var importableLinks = article.links().importable();

    WriteOutput('<h2>#article.getTitle()# (#article.getPageID()#)</h2>');

    WriteOutput('<h3>Original Content</h3>');
    WriteOutput('<pre><code class="language-html">');
    WriteOutput(encodeForXML(article.getContent()));
    WriteOutput('</code></pre>');

    WriteOutput('<h3>Importable HTML</h3>');
    WriteOutput('<pre><code class="language-html">');
    WriteOutput(encodeForXML(article.importableContent()));
    WriteOutput('</code></pre>');

    WriteOutput('<h3>Original Images</h3>');
    if (0 < images.length()) {
      WriteOutput('<ul>');
      ArrayEach(images.toArray(), function(image) {
        WriteOutput('<li>#encodeForXML(image.getHTML())#</li>');
      });
      WriteOutput('</ul>');
    } else {
      WriteOutput('<div>No original images.</div>');
    }

    WriteOutput('<h3>Importable Images</h3>');
    if (0 < importableImages.length()) {
      WriteOutput('<ul>');
      ArrayEach(importableImages.toArray(), function(image) {
        // WriteDump(image.toStruct());
        WriteOutput('<li>#encodeForXML(image.getHTML())#</li>');
      });
      WriteOutput('</ul>');
    } else {
      WriteOutput('<div>No importable images.</div>');
    }

    WriteOutput('<h3>Original Links</h3>');
    if (0 < links.length()) {
      WriteOutput('<ul>');
      ArrayEach(links.toArray(), function(link) {
        WriteOutput('<li>#encodeForXML(link.getHTML())#</li>');
      });
      WriteOutput('</ul>');
    } else {
      WriteOutput('No original links.');
    }

    WriteOutput('<h3>Importable Links</h3>');
    if (0 < importableLinks.length()) {
      WriteOutput('<ul>');
      ArrayEach(importableLinks.toArray(), function(link) {
        WriteOutput('<li>#encodeForXML(link.getHTML())#</li>');
      });
      WriteOutput('</ul>');
    } else {
      WriteOutput('No importable links.');
    }

  });

  // WriteOutput(new components.NewsArticles().all().toXML());
</cfscript>

<cfoutput>
  </body>
</html>
</cfoutput>
