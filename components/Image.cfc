/**
 * Image.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-27
 **/
component accessors=true output=false persistent=false {

  property name='html' type='string' default='';
  property name='dom' type='object';

  jSoup = createObject('java', 'org.jsoup.Jsoup');
  dom = jSoup.parseBodyFragment('');

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

  public void function setDOM (required any dom) {
    VARIABLES.dom = ARGUMENTS.dom;
    VARIABLES.html = VARIABLES.dom.body().html();
  }

  public void function setHTML (required string html) {
    // writeDump(ARGUMENTS.html);
    VARIABLES.html = ARGUMENTS.html;
    VARIABLES.dom =  jSoup.parseBodyFragment(ARGUMENTS.html);
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
    var dom = VARIABLES.dom;
    whiteListAttributes('img', 'src');
    ArrayEach(dom.select('img'), function(image) {
      var url = image.attr('src');
      url = new URL(url).toAbsolute();
      // WriteDump(url);
      image.attr('src', url);
    });
    setDOM(dom);
    VARIABLES.html = encodeForXML(VARIABLES.html);
    return this;
  }

  public component function whiteListAttributes (required string tagName,
      required string whitelist) {
    var dom = VARIABLES.dom;
    var elements = dom.select(tagName);
    ArrayEach(elements, function(element) {
      ArrayEach(element.attributes().asList(), function(attr) {
        if (0 == ListFind(whitelist, attr.getKey())) {
          element.removeAttr(attr.getKey());
        }
      });
    });
    setDOM(dom);
    return this;
  }

  public struct function toStruct () {
    return {
      html = getHTML(),
      dom = getDOM()
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
