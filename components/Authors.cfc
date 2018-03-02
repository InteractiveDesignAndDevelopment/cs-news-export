/**
 * Authors.cfc
 *
 * @author Todd Sayre
 * @date 2017=08-10
 **/
component accessors=true output=false persistent=false {

  authors = [];

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  /*
   * There are three possible ways to set
   * - No arguments = all
   * - String 'all' = all
   * - A single number = just the author of that article
   * -
   */
  public component function init () {
    var articles = arrayNew(1);
    var tmpAuthors = arrayNew(1);

    // writeOutput("#arrayLen(ARGUMENTS)# - #isArray(ARGUMENTS[1])#");
    // writeDump(ARGUMENTS[1]);

    if (0 == ArrayLen(ARGUMENTS) ||
      (1 == ArrayLen(ARGUMENTS) && isSimpleValue(ARGUMENTS[1]) && 'all' == ARGUMENTS[1])) {
        articles = application.adf.ceData.getCEData('News Article');
        // articles = application.adf.ceData.getCEData(
        //   customElementName = 'News Article',
        //   customElementFieldName = 'datePublished',
        //   item = '2018-01-01,2018-01-31',
        //   queryType = 'between');
    } else if (1 == arrayLen(ARGUMENTS) && isArray(ARGUMENTS[1]) &&
      0 < arrayLen(ARGUMENTS[1]) && isObject(ARGUMENTS[1][1]) &&
      structKeyExists(ARGUMENTS[1][1], 'getLogin') &&
      structKeyExists(ARGUMENTS[1][1], 'getEmail') &&
      structKeyExists(ARGUMENTS[1][1], 'getDisplayName') &&
      structKeyExists(ARGUMENTS[1][1], 'getFirstName') &&
      structKeyExists(ARGUMENTS[1][1], 'getLastName') &&
      structKeyExists(ARGUMENTS[1][1], 'getRole')) {
        tmpAuthors = ARGUMENTS[1];
    }

    // TODO: implement searching by pageiD with getElementInfoByPageID

    arrayEach(articles, function(article) {
      // writeDump(article);

      var values      = article.values;
      var email       = lCase(values.contactEmail);
      var login       = emailToLogin(email);
      var displayName = values.contactName;
      var firstName   = displayNameToFirstName(displayName);
      var lastName    = displayNameToLastName(displayName);
      var role        = 'Subscriber';

      // if () {
        // TODO: Get user record from login
      // }

      if (0 == Len(Trim(login))) {
        login       = 'news';
        email       = 'news@mercer';
        displayName = 'News@Mercer';
        firstName   = '';
        lastName    = '';
      }

      var author = new Author(
        login       = login,
        email       = email,
        displayName = displayName,
        firstName   = firstName,
        lastName    = lastName,
        role        = role);

      arrayAppend(tmpAuthors, author);
    });

    variables.authors = tmpAuthors;

    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  /*
   * Return the authors sorted by the given property
   */
  public component function sort (sortProp = 'login') {
    var tmpAuthors = variables.authors;

    ArraySort(tmpAuthors, function(a1, a2) {
      var v1 = '';
      var v2 = '';

      if ('login' == sortProp) {
        v1 = LCase(a1.getLogin());
        v2 = LCase(a2.getLogin());
      }

      // WriteOutput('<div>v1 = #v1#</div>');
      // WriteOutput('<div>v2 = #v2#</div>');

      return compare(v1, v2);
    });

    // return this;
    return new Authors(tmpAuthors);
  }

  /*
   * Return an array of all the authors
   */
  public array function toArray () {
    return variables.authors;
  }

  /*
   * Return only one author for each distinct login property defined
   * in the author object
   */
  public component function unique () {
    var seenLogins = arrayNew(1);
    var tmpAuthors = variables.authors;

    tmpAuthors = ArrayFilter(tmpAuthors, function(author) {
      var login = author.getLogin();
      if (! ArrayFindNoCase(seenLogins, login)) {
        ArrayAppend(seenLogins, login);
        return true;
      } else {
        return false;
      }
    });

    // writeDump(tmpAuthors);

    return new Authors(tmpAuthors);
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  /*
   * Return the login derived from the given email address.
   * This is a blunt instrument; wield with caution.
   */
  private function emailToLogin(required string email) {
    return lCase(listFirst(email, '@'));
  }

  /*
   * Return the last named derived from the display name
   * There are better ways of doing this, but this should suffice
   */
  private function displayNameToFirstName(required string displayName) {
    return listFirst(displayName, ' ');
  }

  /*
   * Return the first named derived from the display name
   * There are better ways of doing this, but this should suffice
   */
  private function displayNameToLastName(required string displayName) {
    return listLast(displayName, ' ');
  }

}