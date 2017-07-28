/**
 * URLConverter.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-07
 **/
component accessors=true output=false persistent=false {

  property name='url'       type='string';

  property name='authority' type='string';
  property name='directory' type='string';
  property name='domain'    type='string';
  property name='file'      type='string';
  property name='fragment'  type='string';
  property name='params'    type='struct';
  property name='password'  type='string';
  property name='path'      type='string';
  property name='port'      type='string';
  property name='query'     type='string';
  property name='scheme'    type='string';
  property name='username'  type='string';

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public any function init () {
    if (1 == ArrayLen(ARGUMENTS)) {
      setURL(ARGUMENTS[1]);
    }

    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

   █████   ██████  ██████ ███████ ███████ ███████  ██████  ██████  ███████
  ██   ██ ██      ██      ██      ██      ██      ██    ██ ██   ██ ██
  ███████ ██      ██      █████   ███████ ███████ ██    ██ ██████  ███████
  ██   ██ ██      ██      ██           ██      ██ ██    ██ ██   ██      ██
  ██   ██  ██████  ██████ ███████ ███████ ███████  ██████  ██   ██ ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public void function setURL (required string url) {
    url = ARGUMENTS.url;
    setURLParts(ARGUMENTS.url);
  }

  public string function getURL () {
    // WriteDump(toStruct());
    return toS();
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public string function toAbsoluteURL () {
    if (isRelativeUrl()) {

    }
    return getURL();
  }

  public string function toSecureURL () {
    setScheme('https');
    return getURL();
  }

  public string function toS () {
    var s = '';

    if (0 < Len(getScheme())) {
      s &= '#getScheme()#://';
    }

    if (0 < Len(getAuthority())) {
      s &= getAuthority();
    }

    s &= getPath();

    return s;
  }

  public struct function toStruct() {
    return {
      authority = getAuthority(),
      directory = getDirectory(),
      domain    = getDomain(),
      file      = getFile(),
      fragment  = getFragment(),
      params    = getParams(),
      password  = getPassword(),
      path      = getPath(),
      port      = getPort(),
      query     = getQuery(),
      scheme    = getScheme(),
      username  = getUserName()
    };
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private void function setURLParts (required string url) {
    var urlParts = parseUrl(ARGUMENTS.url);
    // WriteDump(urlParts);
    setScheme(urlParts.scheme);
    setAuthority(urlParts.authority);
    setPath(urlParts.path);
    setDirectory(urlParts.directory);
    setFile(urlParts.file);
    setQuery(urlParts.query);
    setFragment(urlParts.fragment);
    setDomain(urlParts.domain);
    setPort(urlParts.port);
    setUsername(urlParts.username);
    setPassword(urlParts.password);
    setParams(urlParts.params);
  }

  private boolean function subsiteToSubdomain () {
    var matches = [];
    var regex = '^/(?:com|mu|tv)-';
    var prefix = '';
    var domains = [];

    if ('com' == prefix) {
      domains = ['com'];
    } else if ('mu' == prefix) {
      domains = ['mercer', 'edu'];
    } else if ('tv' == prefix) {
      domains = ['tv'];
    }

    return '';
  }

  private boolean function isSubsiteSubdomainURL (string url) {
    var matches = [];
    var regex = '^/(?:com|mu|tv)-';

    if (IsDefined('request') &&
        IsStruct(Request) &&
        StructKeyExists(Request, 'site') &&
        IsStruct(Request.Site) &&
        StructKeyExists(Request.Site, 'name')) {
      Insert('/#Request.Site.name#', regex, 1);
    }
    var matches = REFindNoCase(regex, url);

    if (1 == ArrayLen(matches)) {
      return false;
    }

  }

  private boolean function isRelativeUrl (string url) {
    // if ('./' == Left(url, 2) || '/' != Left(url, 1)) {
    //   return true;
    // }
    return false;
  }

  private boolean function isRootRelativeUrl (string url) {
    if ('/' == Left(url, 1) && '/' != Mid(url, 2, 1)) {
      return true;
    }
    return false;
  }

  /**
   * Parses a Url and returns a struct with keys defining the information in the Uri.
   *
   * @param sURL 	 String to parse. (Required)
   * @return Returns a struct.
   * @author Dan G. Switzer, II (dswitzer@pengoworks.com)
   * @version 1, January 10, 2007
   */
  private struct function parseUrl(sUrl){
    // var to hold the final structure
    var stUrlInfo = structNew();
    // vars for use in the loop, so we don't have to evaluate lists and arrays more than once
    var i = 1;
    var sKeyPair = "";
    var sKey = "";
    var sValue = "";
    var aQSPairs = "";
    var sPath = "";
    /*
      from: http://www.ietf.org/rfc/rfc2396.txt

      ^((([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*)))?
       123            4  5          6       7  8        9 A

        scheme    = $3
        authority = $5
        path      = $6
        query     = $8
        fragment  = $10 (A)
    */
    var sUriRegEx = "^(([^:/?##]+):)?(//([^/?##]*))?([^?##]*)(\?([^##]*))?(##(.*))?";
    /*
      separates the authority into user info, domain and port

      ^((([^@:]+)(:([^@]+))?@)?([^:]*)?(:(.*)))?
       123       4 5           6       7 8

        username  = $3
        password  = $5
        domain    = $6
        port      = $8
    */
    var sAuthRegEx = "^(([^@:]+)(:([^@]+))?@)?([^:]*)?(:(.*))?";
    /*
      separates the path into segments & parameters

      ((/?[^;/]+)(;([^/]+))?)
      12         3 4

        segment     = $1
        path        = $2
        parameters  = $4
    */
    var sSegRegEx = "(/?[^;/]+)(;([^/]+))?";

    // parse the url looking for info
    var stUriInfo = reFindNoCase(sUriRegEx, sUrl, 1, true);
    // this is for the authority section
    var stAuthInfo = "";
    // this is for the segments in the path
    var stSegInfo = "";

    // create empty keys
    stUrlInfo["scheme"] = "";
    stUrlInfo["authority"] = "";
    stUrlInfo["path"] = "";
    stUrlInfo["directory"] = "";
    stUrlInfo["file"] = "";
    stUrlInfo["query"] = "";
    stUrlInfo["fragment"] = "";
    stUrlInfo["domain"] = "";
    stUrlInfo["port"] = "";
    stUrlInfo["username"] = "";
    stUrlInfo["password"] = "";
    stUrlInfo["params"] = structNew();

    // get the scheme
    if( stUriInfo.len[3] gt 0 ) stUrlInfo["scheme"] = mid(sUrl, stUriInfo.pos[3], stUriInfo.len[3]);
    // get the authority
    if( stUriInfo.len[5] gt 0 ) stUrlInfo["authority"] = mid(sUrl, stUriInfo.pos[5], stUriInfo.len[5]);
    // get the path
    if( stUriInfo.len[6] gt 0 ) stUrlInfo["path"] = mid(sUrl, stUriInfo.pos[6], stUriInfo.len[6]);
    // get the path
    if( stUriInfo.len[8] gt 0 ) stUrlInfo["query"] = mid(sUrl, stUriInfo.pos[8], stUriInfo.len[8]);
    // get the fragment
    if( stUriInfo.len[10] gt 0 ) stUrlInfo["fragment"] = mid(sUrl, stUriInfo.pos[10], stUriInfo.len[10]);

    // break authority into user info, domain and ports
    if( len(stUrlInfo["authority"]) gt 0 ){
      // parse the authority looking for info
      stAuthInfo = reFindNoCase(sAuthRegEx, stUrlInfo["authority"], 1, true);

      // get the domain
      if( stAuthInfo.len[6] gt 0 ) stUrlInfo["domain"] = mid(stUrlInfo["authority"], stAuthInfo.pos[6], stAuthInfo.len[6]);
      // get the port
      if( stAuthInfo.len[8] gt 0 ) stUrlInfo["port"] = mid(stUrlInfo["authority"], stAuthInfo.pos[8], stAuthInfo.len[8]);
      // get the username
      if( stAuthInfo.len[3] gt 0 ) stUrlInfo["username"] = mid(stUrlInfo["authority"], stAuthInfo.pos[3], stAuthInfo.len[3]);
      // get the password
      if( stAuthInfo.len[5] gt 0 ) stUrlInfo["password"] = mid(stUrlInfo["authority"], stAuthInfo.pos[5], stAuthInfo.len[5]);
    }

    // the query string in struct form
    stUrlInfo["params"]["segment"] = structNew();

    // if the path contains any parameters, we need to parse them out
    if( find(";", stUrlInfo["path"]) gt 0 ){
      // this is for the segments in the path
      stSegInfo = reFindNoCase(sSegRegEx, stUrlInfo["path"], 1, true);

      // loop through all the segments and build the strings
      while( stSegInfo.pos[1] gt 0 ){
        // build the path, excluding parameters
        sPath = sPath & mid(stUrlInfo["path"], stSegInfo.pos[2], stSegInfo.len[2]);

        // if there are some parameters in this segment, add them to the struct
        if( stSegInfo.len[4] gt 0 ){

          // put the parameters into an array for easier looping
          aQSPairs = listToArray(mid(stUrlInfo["path"], stSegInfo.pos[4], stSegInfo.len[4]), ";");

          // now, loop over the array and build the struct
          for( i=1; i lte arrayLen(aQSPairs); i=i+1 ){
            sKeyPair = aQSPairs[i]; // current pair
            sKey = listFirst(sKeyPair, "="); // current key
            // make sure there are 2 keys
            if( listLen(sKeyPair, "=") gt 1){
              sValue = urlDecode(listLast(sKeyPair, "=")); // current value
            } else {
              sValue = ""; // set blank value
            }
            // check if key already added to struct
            if( structKeyExists(stUrlInfo["params"]["segment"], sKey) ) stUrlInfo["params"]["segment"][sKey] = listAppend(stUrlInfo["params"]["segment"][sKey], sValue); // add value to list
            else structInsert(stUrlInfo["params"]["segment"], sKey, sValue); // add new key/value pair
          }
        }

        // get the ending position
        i = stSegInfo.pos[1] + stSegInfo.len[1];

        // get the next segment
        stSegInfo = reFindNoCase(sSegRegEx, stUrlInfo["path"], i, true);
      }

    } else {
      // set the current path
      sPath = stUrlInfo["path"];
    }

    // get the file name
    stUrlInfo["file"] = getFileFromPath(sPath);
    // get the directory path by removing the file name
    if( len(stUrlInfo["file"]) gt 0 ){
      stUrlInfo["directory"] = replace(sPath, stUrlInfo["file"], "", "one");
    } else {
      stUrlInfo["directory"] = sPath;
    }

    // the query string in struct form
    stUrlInfo["params"]["url"] = structNew();

    // if query info was supplied, break it into a struct
    if( len(stUrlInfo["query"]) gt 0 ){
      // put the query string into an array for easier looping
      aQSPairs = listToArray(stUrlInfo["query"], "&");

      // now, loop over the array and build the struct
      for( i=1; i lte arrayLen(aQSPairs); i=i+1 ){
        sKeyPair = aQSPairs[i]; // current pair
        sKey = listFirst(sKeyPair, "="); // current key
        // make sure there are 2 keys
        if( listLen(sKeyPair, "=") gt 1){
          sValue = urlDecode(listLast(sKeyPair, "=")); // current value
        } else {
          sValue = ""; // set blank value
        }
        // check if key already added to struct
        if( structKeyExists(stUrlInfo["params"]["url"], sKey) ) stUrlInfo["params"]["url"][sKey] = listAppend(stUrlInfo["params"]["url"][sKey], sValue); // add value to list
        else structInsert(stUrlInfo["params"]["url"], sKey, sValue); // add new key/value pair
      }
    }

    // return the struct
    return stUrlInfo;
  }

}
