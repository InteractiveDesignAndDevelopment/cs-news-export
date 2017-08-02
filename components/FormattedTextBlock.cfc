/**
 * RTEHTML.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-06
 **/
component accessors=true output=false persistent=false {

  property name='html' type='string' default='';

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
    if (1 == ArrayLen(ARGUMENTS)) {
      setHTML(ARGUMENTS[1]);
    }

    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function cleanDOM () {
    return cleanupDOM(getDom());
  }

  public array function cleanImages () {
    var images = cleanDOM().select('img');
    return images;
  }

  public array function cleanLinks () {
    var tmpLinks = cleanDOM().select('a');
    // WriteDump(links);
    return tmpLinks;
  }

  public object function getDom () {
    return dom;
  }

  public string function exportableHTML () {
    var tmpDOM = dom;
    tmpDOM = cleanDOM(tmpDOM);
    // tmpDOM = removeImagesFromDOM(tmpDOM);
    return tmpDOM.body().html();
  }

  public array function images () {
    var images = dom.select('img');
    return images;
  }

  public array function links () {
    var links = dom.select('a');
    // WriteDump(links);
    return links;
  }

  public void function setHTML (required string html) {
    // WriteDump(jSoup);
    html = ARGUMENTS.html;
    dom = jSoup.parseBodyFragment(ARGUMENTS.html);
    // WriteDump(dom);
  }

  public struct function toStruct () {
    return {
      html = gethHTML()
    };
  }

  public struct function toStructForXMLExport () {
    return {
      html: encodeForXML(exportableHTML()),
      images: imagesForXMLExport()
    };
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private any function cleanupDOM(required any tmpDOM) {
    // tmpDOM.select('a').removeAttr('id');
    // tmpDOM.select('span').unwrap();
    tmpDOM = removeNoTextLinks(tmpDOM);
    tmpDOM = whiteListAttributes(tmpDOM, 'a', 'href');
    tmpDOM = whiteListAttributes(tmpDOM, 'img', 'src');
    tmpDOM = makeURLsAbsoluteInDOM(tmpDOM);
    return tmpDom;
  }

  private any function whiteListAttributes(required any tmpDOM,
      required string tagName,
      required string witelist) {
    var elements = tmpDOM.select(tagName);
    ArrayEach(elements, function(element) {
      ArrayEach(element.attributes().asList(), function(attr) {
        if (0 == ListFind(witelist, attr.getKey())) {
          element.removeAttr(attr.getKey());
        }
      });
    });
    return tmpDOM;
  }

  private any function removeNoTextLinks(required any tmpDOM) {
    var links = tmpDOM.select('a');
    ArrayEach(links, function(link) {
      // WriteOutput('<div>[#link.attr('href')#](#Len(link.text())#)</div>');
      // WriteDump(0 == Len(Trim(link.text())));
      if (0 == Len(Trim(link.text()))) {
        link.remove();
        // WriteOutput('Removing link');
      }
    });
    // WriteOutput(encodeForXML(tmpDOM.body().html()));
    return tmpDOM;
  }

  private any function removeImagesFromDOM(required any tempDOM) {
    tempDOM.select('img').remove();
    return tempDOM;
  }

  private any function makeURLsAbsoluteInDOM (required any tempDOM) {
    var links = tempDOM.select('a');
    var images = tempDOM.select('img');

    ArrayEach(links, function (link) {
      var href = link.attr('href');
      if (IsDefined('href') && 0 < Len(href)) {
        href = new URLConverter(href).toAbsoluteURL();
      }
      if (IsDefined('href') && 0 < Len(href)) {
        link.attr('href', href);
      }
    });

    ArrayEach(images, function (image) {
      var src = image.attr('src');
      if (IsDefined('src') && 0 < Len(src)) {
        src = new URLConverter(src).toAbsoluteURL();
      }
      if (IsDefined('src') && 0 < Len(src)) {
        image.attr('src', src);
      }
    });

    return tempDOM;
  }

}
