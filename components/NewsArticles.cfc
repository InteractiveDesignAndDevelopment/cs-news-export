/**
 * NewsArticles.cfc
 *
 * @author Todd Sayre
 * @date 2017=07-07
 **/

component accessors=true output=false persistent=false {

  _ = new Underscore();
  articles = [];

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
    // DEBUG: Just get the first 10 articles
    ceData = ArraySlice(ceData, ArrayLen(ceData) - 50, 50);
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

  // public array function links () {
  //   var tempArticles = articles;
  //   tempArticles = ArrayMap(tempArticles, function(article) {
  //     return article.links();
  //   });
  //   tempArticles = _.flatten(tempArticles);
  //   return tempArticles;
  // }

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
      // writeDump(ceDatum);
      var values = ceDatum.values;
      return new NewsArticle(
        csPageID                             = ceDatum.pageID,
        csConsiderForUniversityHomepage      = values.considerForUniversityHomepage,
        csContactEmail                       = values.contactEmail,
        csContactName                        = values.contactName,
        csContactPhone                       = values.contactPhone,
        csContent                            = values.content,
        csDatePublished                      = values.datePublished,
        csLblBusiness                        = values.lblBusiness,
        csLblCHP                             = values.lblCHP,
        csLblEducation                       = values.lblEducation,
        csLblEngineering                     = values.lblEngineering,
        csLblLaw                             = values.lblLaw,
        csLblLiberalArts                     = values.lblLiberalArts,
        csLblMedicine                        = values.lblMedicine,
        csLblMercerUniversity                = values.lblMercerUniversity,
        csLblMusic                           = values.lblMusic,
        csLblNews                            = values.lblNews,
        csLblNursing                         = values.lblNursing,
        csLblPenfield                        = values.lblPenfield,
        csLblPharmacy                        = values.lblPharmacy,
        csLblTheology                        = values.lblTheology,
        csLblWorkingAdultPrograms            = values.lblWorkingAdultPrograms,
        csShowInBusinessNews                 = values.showInBusinessNews,
        csShowInCHPNews                      = values.showInCHPNews,
        csShowInEducationNews                = values.showInEducationNews,
        csShowInEngineeringNews              = values.showInEngineeringNews,
        csShowInLawNews                      = values.showInLawNews,
        csShowInLiberalArtsNews              = values.showInLiberalArtsNews,
        csShowInMedicineNews                 = values.showInMedicineNews,
        csShowInMusicNews                    = values.showInMusicNews,
        csShowInNursingNews                  = values.showInNursingNews,
        csShowInPenfieldNews                 = values.showInPenfieldNews,
        csShowInPharmacyNews                 = values.showInPharmacyNews,
        csShowInTheologyNews                 = values.showInTheologyNews,
        csShowInWorkingAdultProgramsNews     = values.showInWorkingAdultProgramsNews,
        csShowOnBusinessHomepage             = values.showOnBusinessHomepage,
        csShowOnCHPHomepage                  = values.showOnCHPHomepage,
        csShowOnEducationHomepage            = values.showOnEducationHomepage,
        csShowOnEngineeringHomepage          = values.showOnEngineeringHomepage,
        csShowOnLawHomepage                  = values.showOnLawHomepage,
        csShowOnLiberalArtsHomepage          = values.showOnLiberalArtsHomepage,
        csShowOnMedicineHomepage             = values.showOnMedicineHomepage,
        csShowOnMusicHomepage                = values.showOnMusicHomepage,
        csShowOnNewsHomepage                 = values.showOnNewsHomepage,
        csShowOnNursingHomepage              = values.showOnNursingHomepage,
        csShowOnPenfieldHomepage             = values.showOnPenfieldHomepage,
        csShowOnPharmacyHomepage             = values.showOnPharmacyHomepage,
        csShowOnTheologyHomepage             = values.showOnTheologyHomepage,
        csShowOnUniversityHomepage           = values.showOnUniversityHomepage,
        csShowOnWorkingAdultProgramsHomepage = values.showOnWorkingAdultProgramsHomepage,
        csSummary                            = values.summary,
        csSummaryHeaderPhoto                 = values.summaryHeaderPhoto,
        csTitle                              = values.title
      );
    });
    return ceData;
  }

}
