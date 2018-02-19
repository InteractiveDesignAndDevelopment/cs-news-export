/**
 * Images.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-27
 **/
component accessors=true output=false persistent=false {

  images = [];
  jSoup = createObject('java', 'org.jsoup.Jsoup');

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public function init () {
    if (isSimpleValue(ARGUMENTS[1])) {
      // writeDump(ARGUMENTS[1]);
      images = imagesFromHTML(ARGUMENTS[1]);
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

  public array function altAttributesArray () {
    var a = images;

    a = ArrayMap(a, function(image) {
      return image.getElement().attr('alt');
    });

    return a;
  }

  public string function altAttributesList () {

  }

  public string function altAttributesOnePerLine () {

  }

  public numeric function length () {
    return ArrayLen(images);
  }

  public component function importable () {
    var a = images;

    a = ArrayMap(images, function(image) {
      // writeDump(image);
      return image.importable();
    });

    images = a;

    return this;
  }

  public array function titleAttributesArray () {
    var a = images;

    a = ArrayMap(a, function(image) {

    });

    return a;
  }

  public string function titleAttributesList () {

  }

  public string function titleAttributesOnePerLine () {

  }

  public array function toArray () {
    return images;
  }

  public array function urlsArray () {
    var a = images;

    a = ArrayMap(a, function(image) {
      return image.getElement().attr('src');
    });

    return a;
  }

  public string function urlsList () {
    return ArrayToList(urlsArray());
  }

  public string function urlsOnePerLine () {
    return Replace(urlsList(), ',', chr(10));
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private array function imagesFromHTML (required string html) {
    // WriteDump(ARGUMENTS.html);
    var dom = jSoup.parseBodyFragment(ARGUMENTS.html);
    var domImages = dom.select('img');
    // writeDump(domImages);
    domImages = ArrayMap(domImages, function(image) {
      return new Image(image.toString());
    });
    return domImages;
  }

}
