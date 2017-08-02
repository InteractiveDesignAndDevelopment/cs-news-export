/**
 * NewsArticles.cfc
 *
 * @author Todd Sayre
 * @date 2017=07-07
 **/
component accessors=true output=false persistent=false {

  _ = new Underscore();
  articles = [];
  capiCustomElement = Server.CommonSpot.api.getObject('CustomElement');
  // id = customElementID();

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init () {
    if (1 == ArrayLen(ARGUMENTS)) {
      if (IsNumeric(ARGUMENTS[1])) {
        findByPageID(ARGUMENTS[1]);
      }
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

  public component function all () {
    var ceData = application.adf.ceData.getCEData('News Article');
    ceData = ArraySlice(ceData, 1, 10);
    articles = ceDataToArticlesArray(ceData);
    return this;
  }

  public component function findByPageID (required numeric pageID) {
    var ceData = application.adf.ceData.getCEData('News Article');
    ceData = ArrayFilter(ceData, function (ceDatum) {
      return pageID == ceDatum.pageID;
    });
    articles = ceDataToArticlesArray(ceData);
    return this;
  }

  public component function importable () {
    articles = ArrayMap(articles, function(article) {
      return article.toStructForXMLExport();
    });
    return this;
  }

  public array function links () {
    var tempArticles = articles;
    tempArticles = ArrayMap(tempArticles, function(article) {
      return article.links();
    });
    tempArticles = _.flatten(tempArticles);
    return tempArticles;
  }

  public array function toArray () {
    return articles;
  }

  public string function toXML () {
    return _.toXml(importable().toArray());
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private any function ceDataToArticlesArray (ceData) {
    ceData = ArrayMap(ceData, function(ceDatum) {
      return new NewsArticle(ceDatum);
    });
    return ceData;
  }

}
