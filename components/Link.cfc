/**
 * Link.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-27
 **/
component accessors=true output=false persistent=false {

  property name='html' type='string' default='';
  property name='document';
  property name='element';
  property name='url';

  jSoup = createObject('java', 'org.jsoup.Jsoup');
  document = jSoup.parseBodyFragment('');

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public function init () {
    if (1 == ArrayLen(ARGUMENTS) && IsSimpleValue(ARGUMENTS[1])) {
      setHTML(ARGUMENTS[1]);
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

  public void function setDOM (required any document) {
    VARIABLES.document = ARGUMENTS.document;
    // ---
    VARIABLES.html = VARIABLES.document.body().html();
    VARIABLES.element = VARIABLES.document.body().children()[1];
    VARIABLES.url = VARIABLES.element.attr('href');
  }

  public void function setHTML (required string html) {
    VARIABLES.html = ARGUMENTS.html;
    // ---
    VARIABLES.document = jSoup.parseBodyFragment(VARIABLES.html);
    VARIABLES.element = VARIABLES.document.body().children()[1];
    VARIABLES.url = VARIABLES.element.attr('href');
  }

  public void function setElement (required any element) {
    VARIABLES.element = ARGUMENTS.element;
    // ---
    // VARIABLES.document = TODO
    // VARIABLES.url = TODO
    // VARIABLES.html = TODO
  }

  public void function setURL (required string url) {
    VARIABLES.url = ARGUMENTS.url;
    // ---
    // VARIABLES.element = TODO
    // VARIABLES.document = TODO
    // VARIABLES.html = TODO
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function importable () {
    setDocument(whiteListAttributes(document, 'a', 'href'));
    ArrayEach(document.select('a'), function(a) {
      var url = '';
      if (a.hasAttr('href')) {
        url = a.attr('href');
        if (0 < Len(url)) {
          url = new URL(url).toAbsolute();
        }
        // WriteDump(var = url, label = 'Link URL');
        // if (0 < Len(url)) {
        //   a.attr('href');
        // }
      }
    });
    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private any function whiteListAttributes(required any tmpDOM,
      required string tagName,
      required string whitelist) {
    var elements = tmpDOM.select(tagName);
    ArrayEach(elements, function(element) {
      ArrayEach(element.attributes().asList(), function(attr) {
        if (0 == ListFind(whitelist, attr.getKey())) {
          element.removeAttr(attr.getKey());
        }
      });
    });
    return tmpDOM;
  }

}
