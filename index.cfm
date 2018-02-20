<cfoutput>
  <!doctype html>
  <html>
    <head>
      <title>Export News</title>
      <cfinclude template = "./includes/head.cfm">
    </head>
    <body>
      <cfinclude template = "./includes/top.cfm">

      <h1>News Export</h1>

      <h2>Authors</h2>

      <ul>
        <li><a href="./authors-preview.cfm">Preview</a></li>
        <li><a href="./author-export.cfm">Export </a></li>
      </ul>

      <h2>Articles</h2>

      <ul>
        <li><a href="./articles-preview.cfm">Preview</a></li>
        <li><a href="./articles-export.cfm">Export</a></li>
      </ul>

      <h2>README</h2>

      <pre><code><cfscript>
        readMe = fileRead(expandPath('./README.md'));
        readMe = htmlCodeFormat(readMe);
        writeOutput(readMe);
      </cfscript></code></pre>

    </body>
  </html>
</cfoutput>
