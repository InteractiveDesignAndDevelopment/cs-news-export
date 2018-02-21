<cfscript>
  // authors = new components.Authors('all');
  // authors = new components.Authors('all').unique();
  authors = new components.Authors('all').unique().sort();

  // WriteDump(var = authors.toArray(), label = 'Preview Authors Array');
  // exit;
  // WriteDump(var = authors, label = 'Preview Authors');
  // WriteDump(authors.first());

  authorsArray = authors.toArray();

</cfscript><cfoutput><!doctype html>
<html>
  <head>
    <title>#arrayLen(authorsArray)# Authors</title>
    <cfinclude template="./includes/head.cfm">
  </head>
  <body>
    <cfinclude template="./includes/top.cfm">

    <h1>#arrayLen(authorsArray)# Authors</h1>

    <table class="DataTable">
      <thead>
        <tr>
          <th>
            Login
          </th>
          <th>
            Email
          </th>
          <th>
            Display Name
          </th>
          <th>
            First Name
          </th>
          <th>
            Last Name
          </th>
          <th>
            Role
          </th>
        </tr>
      </thead>
      <tbody>
        <cfloop array="#authorsArray#" index="author">
          <tr>
            <td>
              #author.getLogin()#
            </td>
            <td>
              #author.getEmail()#
            </td>
            <td>
              #author.getDisplayName()#
            </td>
            <td>
              #author.getFirstName()#
            </td>
            <td>
              #author.getLastName()#
            </td>
            <td>
              #author.getRole()#
            </td>
          </tr>
        </cfloop>
      </tbody>
    </table>

    <cfinclude template="./includes/bottom.cfm">
  </body>
</html>
</cfoutput>
