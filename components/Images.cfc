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

  public numeric function length () {
    return ArrayLen(images);
  }

  public component function importable () {
    images = ArrayMap(images, function(image) {
      // writeDump(image);
      return image.importable();
    });
    return this;
  }

  public array function toArray () {
    return images;
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
