/**
 * HTMLFragment.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-27
 **/
component accessors=true output=false persistent=false {

  property name='html'     type='string' default='';
  property name='document' type='any';

  jSoup    = createObject('java', 'org.jsoup.Jsoup');
  // document = jSoup.parseBodyFragment('');

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public function init () {
    if (1 == ArrayLen(ARGUMENTS)) {
      // WriteDump(ARGUMENTS[1]);
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

  public any function getDocument (boolean isForExport = false) {
    if (! isForExport) {
      return VARIABLES.document;
    }

    return makeImportable(VARIABLES.document);
  }

  public string function getHTML (boolean isForExport = false) {
    if (!isForExport) {
      return VARIABLES.html;
    }

    return getDocument(true).body().innerHTML();
  }

  public void function setHTML (required string html) {
    VARIABLES.html = deMoronize(ARGUMENTS.html);
    VARIABLES.document = jSoup.parseBodyFragment(VARIABLES.html);
  }

  public void function setDocument (required any document) {
    VARIABLES.document = ARGUMENTS.document;
    VARIABLES.html = VARIABLES.document.body().html();
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  // public string function exportableHTML () {
  //   var tmpDOM = dom;
  //   tmpDOM = cleanDOM(tmpDOM);
  //   // tmpDOM = removeImagesFromDOM(tmpDOM);
  //   return tmpDOM.body().html();
  // }

  public component function images () {
    // var images = dom.select('img');
    // return images;
    // writedump(getHTML());
    // writeDump(html);
    return new Images(getHTML());
  }

  // org.jsoup.nodes.Document
  // public any function importable () {
  //   setDocument(getDocument(true));
  //   return this;
  // }

  public any function importable () {
    var tmpDoc = VARIABLES.document;

    tmpDoc = unwrapSpans(tmpDoc);
    tmpDoc = removeImages(tmpDoc);
    tmpDoc = removeNoTextLinks(tmpDoc);
    tmpDoc = removeNoHREFLinks(tmpDoc);
    tmpDoc = whiteListAttributes(tmpDoc, 'a', 'href,alt');

    setDocument(tmpDoc);

    return this;
  }

  // public string function importableHTML () {
  //   return importableDOM().body().html();
  // }

  // public array function importableImages () {
  //   return images().importable();
  // }

  // public array function importableLinks () {
  //   return links().importable();
  // }

  public component function links () {
    // var links = dom.select('a');
    // WriteDump(links);
    // return links;
    return new Links(html);
  }

  // public void function setHTML (required string newHTML) {
  //   // WriteDump(jSoup);
  //   // writeDump(newHTML);
  //   html = newHTML;
  //   dom = jSoup.parseBodyFragment(newHTML);
  //   // WriteDump(jSoup);
  //   // WriteDump(dom);
  // }

  public struct function toStruct (boolean isForExport) {
    var s = {};

    if (!isForExport) {
      // s['document'] = getDocument(true);
      s['html']     = gethHTML(true);
      s['images']   = images(true);

      return s;
    }

    // s['document'] = getDocument();
    s['html']     = encodeForXML(exportableHTML());
    s['images']   = imagesForXMLExport();

    return s;
  }

  // public struct function toStructForXMLExport () {
  //   return {
  //     html: encodeForXML(exportableHTML()),
  //     images: imagesForXMLExport()
  //   };
  // }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  /*
    This library is part of the Common Function Library Project. An open source
    collection of UDF libraries designed for ColdFusion 5.0 and higher. For more information,
    please see the web site at:

      http://www.cflib.org

    Warning:
    You may not need all the functions in this library. If speed
    is _extremely_ important, you may want to consider deleting
    functions you do not plan on using. Normally you should not
    have to worry about the size of the library.

    License:
    This code may be used freely.
    You may modify this code as you see fit, however, this header, and the header
    for the functions must remain intact.

    This code is provided as is.  We make no warranty or guarantee.  Use of this code is at your own risk.
  */
  /**
   * Fixes text using Microsoft Latin-1 &quot;Extentions&quot;, namely ASCII characters 128-160.
   * ASCII8217 mod by Tony Brandner
   *
   * @param text 	 Text to be modified. (Required)
   * @return Returns a string.
   * @author Shawn Porter (sporter@rit.net)
   * @version 2, September 2, 2010
   */
  function deMoronize (text) {
      var i = 0;

  // map incompatible non-ISO characters into plausible
      // substitutes
      text = Replace(text, Chr(128), "&euro;", "All");

      text = Replace(text, Chr(130), ",", "All");
      text = Replace(text, Chr(131), "<em>f</em>", "All");
      text = Replace(text, Chr(132), ",,", "All");
      text = Replace(text, Chr(133), "...", "All");

      text = Replace(text, Chr(136), "^", "All");

      text = Replace(text, Chr(139), ")", "All");
      text = Replace(text, Chr(140), "Oe", "All");

      text = Replace(text, Chr(145), "`", "All");
      text = Replace(text, Chr(146), "'", "All");
      text = Replace(text, Chr(147), """", "All");
      text = Replace(text, Chr(148), """", "All");
      text = Replace(text, Chr(149), "*", "All");
      text = Replace(text, Chr(150), "-", "All");
      text = Replace(text, Chr(151), "--", "All");
      text = Replace(text, Chr(152), "~", "All");
      text = Replace(text, Chr(153), "&trade;", "All");

      text = Replace(text, Chr(155), ")", "All");
      text = Replace(text, Chr(156), "oe", "All");

      // remove any remaining ASCII 128-159 characters
      for (i = 128; i LTE 159; i = i + 1)
          text = Replace(text, Chr(i), "", "All");

      // map Latin-1 supplemental characters into
      // their &name; encoded substitutes
      text = Replace(text, Chr(160), "&nbsp;", "All");

      text = Replace(text, Chr(163), "&pound;", "All");

      text = Replace(text, Chr(169), "&copy;", "All");

      text = Replace(text, Chr(176), "&deg;", "All");

      // encode ASCII 160-255 using ? format
      for (i = 160; i LTE 255; i = i + 1)
          text = REReplace(text, "(#Chr(i)#)", "&###i#;", "All");

    for (i = 8216; i LTE 8218; i = i + 1) text = Replace(text, Chr(i), "'", "All");

  // supply missing semicolon at end of numeric entities
      text = ReReplace(text, "&##([0-2][[:digit:]]{2})([^;])", "&##\1;\2", "All");

  // fix obscure numeric rendering of &lt; &gt; &amp;
      text = ReReplace(text, "&##038;", "&amp;", "All");
      text = ReReplace(text, "&##060;", "&lt;", "All");
      text = ReReplace(text, "&##062;", "&gt;", "All");

      // supply missing semicolon at the end of &amp; &quot;
      text = ReReplace(text, "&amp(^;)", "&amp;\1", "All");
      text = ReReplace(text, "&quot(^;)", "&quot;\1", "All");

      return text;
  }

  private any function makeURLsAbsolute (required any document) {
    var tmpDoc = ARGUMENTS.document;
    var links = tmpDoc.select('a');
    var images = tmpDoc.select('img');

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

    return tmpDoc;
  }

  private any function removeImages (required any document) {
    var tmpDoc = ARGUMENTS.document;

    tmpDoc.select('img').remove();

    return tmpDoc;
  }

  private any function removeNoHREFLinks (required any document) {
    var tmpDoc = ARGUMENTS.document;
    var links = tmpDoc.select('a');

    ArrayEach(links, function(link) {
      // WriteOutput('<div>[#link.attr('href')#](#Len(link.text())#)</div>');
      // WriteDump(0 == Len(Trim(link.text())));
      // WriteOutput('<div>[[#Len(Trim(link.attr('href')))#]]</div>');
      if (0 == Len(Trim(link.attr('href')))) {
        link.remove();
        WriteOutput('Removing link');
      }
    });
    // WriteOutput(encodeForXML(tmpDOM.body().html()));

    return tmpDoc;
  }

  private any function removeNoTextLinks (required any document) {
    var tmpDoc = ARGUMENTS.document;
    var links = tmpDoc.select('a');

    ArrayEach(links, function(link) {
      // WriteOutput('<div>[#link.attr('href')#](#Len(link.text())#)</div>');
      // WriteDump(0 == Len(Trim(link.text())));
      if (0 == Len(Trim(link.text()))) {
        link.remove();
        // WriteOutput('Removing link');
      }
    });
    // WriteOutput(encodeForXML(tmpDOM.body().html()));

    return tmpDoc;
  }

  private any function unwrapSpans (required any document) {
    var tmpDoc = ARGUMENTS.document;

    tmpDoc.select('span').unwrap();

    return tmpDoc;
  }

  private any function whiteListAttributes (required any document,
      required string tagName,
      required string whitelist) {

    var tmpDoc = ARGUMENTS.document;

    ArrayEach(tmpDoc.select(tagName), function(element) {
      ArrayEach(element.attributes().asList(), function(attr) {
        if (0 == ListFind(whitelist, attr.getKey())) {
          element.removeAttr(attr.getKey());
        }
      });
    });

    return tmpDoc;
  }

}
