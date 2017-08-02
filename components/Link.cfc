/**
 * Link.cfc
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
    VARIABLES.html = ARGUMENTS.dom.body().html();
  }

  public void function setHTML (required string html) {
    VARIABLES.html = ARGUMENTS.html;
    VARIABLES.dom = jSoup.parseBodyFragment(ARGUMENTS.html);
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function importable () {
    setDOM(whiteListAttributes(dom, 'a', 'href'));
    ArrayEach(dom.select('a'), function(a) {
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
