<cfscript>
  authors = new components.Authors('all').unique().sort();

  // WriteDump(var = authors.toArray(), label = 'Preview Authors Array');
  // WriteDump(var = authors, label = 'Preview Authors');
  // WriteDump(authors.first());

</cfscript><cfoutput><!doctype html>
<html>
  <head>
    <title>Export News Articles</title>
    <cfinclude template="./includes/head.cfm">
  </head>
  <body>
    <cfinclude template="./includes/top.cfm">

      <cfloop array="#authors.toArray()#" index="author">
        <p>
          <div>
            Username: #author.getUsername()#<br>
            Email: #author.getEmailAddress()#<br>
            Name: #author.getName()#
          </div>
        </p>
        <hr/>
      </cfloop>

    <cfinclude template="./includes/top.cfm">
  </body>
</html>
</cfoutput>
