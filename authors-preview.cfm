<cfscript>
  // authors = new components.Authors('all');
  // authors = new components.Authors('all').unique();
  authors = new components.Authors('all').unique().sort();

  // WriteDump(var = authors.toArray(), label = 'Preview Authors Array');
  // exit;
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
            Username: #author.getLogin()#<br>
            Email: #author.getEmail()#<br>
            Display Name: #author.getDisplayName()#
          </div>
        </p>
        <hr/>
      </cfloop>

    <cfinclude template="./includes/bottom.cfm">
  </body>
</html>
</cfoutput>
