/**
 * Image.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-27
 **/
component accessors=true output=false persistent=false {

  property name='html' type='string' default='';
  property name='document';
  property name='element';
  property name='url' type='string' default='';

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
    // WriteDump(ARGUMENTS);

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
    VARIABLES.url = VARIABLES.element.attr('src');
  }

  public void function setHTML (required string html) {
    VARIABLES.html = ARGUMENTS.html;
    // ---
    VARIABLES.document =  jSoup.parseBodyFragment(VARIABLES.html);
    VARIABLES.element = VARIABLES.document.body().children()[1];
    VARIABLES.url = VARIABLES.element.attr('src');
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function importable () {
    // WriteDump(VARIABLES);
    var document = VARIABLES.document;
    whiteListAttributes('img', 'src');
    ArrayEach(document.select('img'), function(image) {
      var url = image.attr('src');
      url = new URL(url).toAbsolute();
      // WriteDump(url);
      image.attr('src', url);
    });
    setDOM(document);
    VARIABLES.html = encodeForXML(VARIABLES.html);
    return this;
  }

  public component function whiteListAttributes (required string tagName,
      required string whitelist) {
    var document = VARIABLES.document;
    var elements = document.select(tagName);
    ArrayEach(elements, function(element) {
      ArrayEach(element.attributes().asList(), function(attr) {
        if (0 == ListFind(whitelist, attr.getKey())) {
          element.removeAttr(attr.getKey());
        }
      });
    });
    setDOM(document);
    return this;
  }

  public struct function toStruct () {
    return {
      html = getHTML(),
      document = getDocument()
    };
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

}
