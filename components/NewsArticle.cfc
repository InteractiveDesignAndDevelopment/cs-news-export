/**
 * NewsArticle.cfc
 *
 * @author Todd Sayre
 * @date 2017-07-07
 **/
component accessors=true output=false persistent=false {

  // This is the pageID value of a News Article custom element record
  property name='pageID'   type='numeric';
  property name='formID'   type='numeric';
  property name='formName' type='string';
  // These are the fields in the News Article custom element
  property name='considerForUniversityHomepage'      type='numeric';
  property name='contactEmail'                       type='string';
  property name='contactName'                        type='string';
  property name='contactPhone'                       type='string';
  property name='content'                            type='string';
  property name='contentHTMLFragment'                type='any';
  property name='datePublished'                      type='string';
  property name='lblBusiness'                        type='string';
  property name='lblCHP'                             type='string';
  property name='lblEducation'                       type='string';
  property name='lblEngineering'                     type='string';
  property name='lblLaw'                             type='string';
  property name='lblLiberalArts'                     type='string';
  property name='lblMedicine'                        type='string';
  property name='lblMercerUniversity'                type='string';
  property name='lblMusic'                           type='string';
  property name='lblNews'                            type='string';
  property name='lblNursing'                         type='string';
  property name='lblPenfield'                        type='string';
  property name='lblPharmacy'                        type='string';
  property name='lblTheology'                        type='string';
  property name='lblWorkingAdultPrograms'            type='string';
  property name='showInBusinessNews'                 type='numeric';
  property name='showInCHPNews'                      type='numeric';
  property name='showInEducationNews'                type='numeric';
  property name='showInEngineeringNews'              type='numeric';
  property name='showInLawNews'                      type='numeric';
  property name='showInLiberalArtsNews'              type='numeric';
  property name='showInMedicineNews'                 type='numeric';
  property name='showInMusicNews'                    type='numeric';
  property name='showInNursingNews'                  type='numeric';
  property name='showInPenfieldNews'                 type='numeric';
  property name='showInPharmacyNews'                 type='numeric';
  property name='showInTheologyNews'                 type='numeric';
  property name='showInWorkingAdultProgramsNews'     type='numeric';
  property name='showOnBusinessHomepage'             type='numeric';
  property name='showOnCHPHomepage'                  type='numeric';
  property name='showOnEducationHomepage'            type='numeric';
  property name='showOnEngineeringHomepage'          type='numeric';
  property name='showOnLawHomepage'                  type='numeric';
  property name='showOnLiberalArtsHomepage'          type='numeric';
  property name='showOnMedicineHomepage'             type='numeric';
  property name='showOnMusicHomepage'                type='numeric';
  property name='showOnNewsHomepage'                 type='numeric';
  property name='showOnNursingHomepage'              type='numeric';
  property name='showOnPenfieldHomepage'             type='numeric';
  property name='showOnPharmacyHomepage'             type='numeric';
  property name='showOnTheologyHomepage'             type='numeric';
  property name='showOnUniversityHomepage'           type='numeric';
  property name='showOnWorkingAdultProgramsHomepage' type='numeric';
  property name='summary'                            type='string';
  property name='summaryHeaderPhoto'                 type='string';
  property name='title'                              type='string';

  _ = new Underscore();

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init () {
    if (1 == ArrayLen(ARGUMENTS)) {
      // WriteDump(ARGUMENTS[1]);
      if (IsStruct(ARGUMENTS[1])) {
        if (StructKeyExists(ARGUMENTS[1], 'Values')) {
          StructAppend(ARGUMENTS[1], ARGUMENTS[1].Values);
          StructDelete(ARGUMENTS[1], 'Values');
        }
        setFromStruct(ARGUMENTS[1]);
      }
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

  public string function getContent(boolean isForExport = false) {
    if (! isForExport) {
      return VARIABLES.content;
    }

    // writeDump(VARIABLES.contentHTMLFragment);
    return VARIABLES.getContentHTMLFragment(true).getHTML();
  }

  public any function getContentHTMLFragment(boolean isForExport = false) {
    if (! isForExport) {
      return VARIABLES.contentHTMLFragment;
    }

    var tmp = VARIABLES.contentHTMLFragment;
    var tmpDoc = tmp.importable().getDocument();
    tmpDoc = cleanDocument(tmpDoc);
    tmp.setDocument(tmpDoc);

    return tmp;
  }

  public string function getSummaryHeaderPhoto(boolean isForExport = false) {
    if (! isForExport) {
      return VARIABLES.summaryHeaderPhoto;
    }

    if (0 == Len(VARIABLES.summaryHeaderPhoto)) {
      return '';
    }

    var deciphered = Application.ADF.csData.decipherCPImage(VARIABLES.summaryHeaderPhoto);

    // WriteDump(deciphered);

    return deciphered.resolvedURL.absolute;
  }

  public void function setContent(required string content) {
    VARIABLES.content = ARGUMENTS.content;
    VARIABLES.contentHTMLFragment = new HTMLFragment(ARGUMENTS.content);
  }

  public void function setContentHTMLFragment(required component contentHTMLFragment) {
    VARIABLES.contentHTMLFragment = ARGUMENTS.contentHTMLFragment;
    VARIABLES.content = contentHTMLFragment.getHTML();
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  // public string function importableContent() {
  //   return new HTMLFragment(getContent()).importableHTML();
  // }

  public component function images () {
    return getContentHTMLFragment().images();
  }

  public component function links () {
    return getContentHTMLFragment(true).links();
  }

  public array function taxonomyArray () {
    var taxonomy = [];

    if (isTruthy(getShowInBusinessNews()) || isTruthy(getShowOnBusinessHomepage())) {
      ArrayAppend(taxonomy, 'Business & Economics');
    }
    if (isTruthy(getShowInCHPNews()) || isTruthy(getShowOnCHPHomepage())) {
      ArrayAppend(taxonomy, 'Health Professions');
    }
    if (isTruthy(getShowInEducationNews()) || isTruthy(getShowOnEducationHomepage())) {
      ArrayAppend(taxonomy, 'Education');
    }
    if (isTruthy(getShowInEngineeringNews()) || isTruthy(getShowOnEngineeringHomepage())) {
      ArrayAppend(taxonomy, 'Engineering');
    }
    if (isTruthy(getShowInLawNews()) || isTruthy(getShowOnLawHomepage())) {
      ArrayAppend(taxonomy, 'Law');
    }
    if (isTruthy(getShowInLiberalArtsNews()) || isTruthy(getShowOnLiberalArtsHomepage())) {
      ArrayAppend(taxonomy, 'Liberal Arts');
    }
    if (isTruthy(getShowInMedicineNews()) || isTruthy(getShowOnMedicineHomepage())) {
      ArrayAppend(taxonomy, 'Medicine');
    }
    if (isTruthy(getShowInMusicNews()) || isTruthy(getShowOnMusicHomepage())) {
      ArrayAppend(taxonomy, 'Music');
    }
    if (isTruthy(getShowInNursingNews()) || isTruthy(getShowOnNursingHomepage())) {
      ArrayAppend(taxonomy, 'Nursing');
    }
    if (isTruthy(getShowInPenfieldNews()) || isTruthy(getShowOnPenfieldHomepage())) {
      ArrayAppend(taxonomy, 'Penfield');
    }
    if (isTruthy(getShowInPharmacyNews()) || isTruthy(getShowOnPharmacyHomepage())) {
      ArrayAppend(taxonomy, 'Pharmacy');
    }
    if (isTruthy(getShowInTheologyNews()) || isTruthy(getShowOnTheologyHomepage())) {
      ArrayAppend(taxonomy, 'Theology');
    }
    if (isTruthy(getShowInWorkingAdultProgramsNews()) || isTruthy(getShowOnWorkingAdultProgramsHomepage())) {
      ArrayAppend(taxonomy, 'Working Adults');
    }

    return taxonomy;
  }

  public string function taxonomyList () {
    return ArrayToList(taxonomyArray());
  }

  public struct function toStruct (boolean isForExport = false) {
    if (isForExport) {
      return toStructForXMLExport();
    } else {
      return toStructNotForXMLExport();
    }
  }

  // Tarteting the WP All Import plugin
  public struct function toStructForXMLExport () {
    var s = {};
    var images = images().importable().toArray();

    s['PostDate']         = encodeForXML(getDatePublished());
    s['UniqueIdentifier'] = encodeForXML(getPageID());
    s['Content']          = encodeForXML(getContent(true));
    s['Excerpt']          = encodeForXML(getSummary());
    s['Title']            = encodeForXML(getTitle());
    s['Tags']             = encodeForXML(taxonomyList());
    s['Categories']       = encodeForXML('News');
    // s['Slug']          = '';  // Automatic name is fine
    s['Author']           = '';

    if (0 < ArrayLen(images)) {
      // WriteDump(images);
      images = ArrayMap(images, function(image) {
        // return image;
        return image.getUrl();
      });
      if (0 < Len(getSummaryHeaderPhoto(true))) {
        ArrayPrepend(images, getSummaryHeaderPhoto(true));
      }
      s['Images'] = images;
    }

    return s;
  }

  public struct function toStructNotForXMLExport () {
    var s = {};

    // Standard custom element data
    s['pageID']   = getPageID();
    s['formID']   = getFormID();
    s['formName'] = getFormName();

    // Custom elemement fields
    s['considerForUniversityHomepage']      = getConsiderForUniversityHomepage();
    s['contactEmail']                       = getContactEmail();
    s['contactName']                        = getContactName();
    s['contactPhone']                       = getContactPhone();
    s['content']                            = getContent();
    s['datePublished']                      = getDatePublished();
    s['lblBusiness']                        = getLblBusiness();
    s['lblEducation']                       = getLblEducation();
    s['lblEngineering']                     = getLblEngineering();
    s['lblLaw']                             = getLblLaw();
    s['lblLiberalArts']                     = getLblLiberalArts();
    s['lblMedicine']                        = getLblMedicine();
    s['lblMercerUniversity']                = getLblMercerUniversity();
    s['lblMusic']                           = getLblMusic();
    s['lblNews']                            = getLblNews();
    s['lblNursing']                         = getLblNursing();
    s['lblPenfield']                        = getLblPenfield();
    s['lblTheology']                        = getLblTheology();
    s['lblWorkingAdultPrograms']            = getLblWorkingAdultPrograms();
    s['showInBusinessNews']                 = getShowInBusinessNews();
    s['showInCHPNews']                      = getShowInCHPNews();
    s['showInEducationNews']                = getShowInEducationNews();
    s['showInEngineeringNews']              = getShowInEngineeringNews();
    s['showInLawNews']                      = getShowInLawNews();
    s['showInLiberalArtsNews']              = getShowInLiberalArtsNews();
    s['showInMedicineNews']                 = getShowInMedicineNews();
    s['showInMusicNews']                    = getShowInMusicNews();
    s['showInNursingNews']                  = getShowInNursingNews();
    s['showInPenfieldNews']                 = getShowInPenfieldNews();
    s['showInPharmacyNews']                 = getShowInPharmacyNews();
    s['showInTheologyNews']                 = getShowInTheologyNews();
    s['showInWorkingAdultProgramsNews']     = getShowInWorkingAdultProgramsNews();
    s['showOnBusinessHomepage']             = getShowOnBusinessHomepage();
    s['showOnCHPHomepage']                  = getShowOnCHPHomepage();
    s['showOnEducationHomepage']            = getShowOnEducationHomepage();
    s['showOnEngineeringHomepage']          = getShowOnEngineeringHomepage();
    s['showOnLawHomepage']                  = getShowOnLawHomepage();
    s['showOnLiberalArtsHomepage']          = getShowOnLiberalArtsHomepage();
    s['showOnMedicineHomepage']             = getShowOnMedicineHomepage();
    s['showOnMusicHomepage']                = getShowOnMusicHomepage();
    s['showOnNewsHomepage']                 = getShowOnNewsHomepage();
    s['showOnNursingHomepage']              = getShowOnNursingHomepage();
    s['showOnPenfieldHomepage']             = getShowOnPenfieldHomepage();
    s['showOnPharmacyHomepage']             = getShowOnPharmacyHomepage();
    s['showOnTheologyHomepage']             = getShowOnTheologyHomepage();
    s['showOnUniversityHomepage']           = getShowOnUniversityHomepage();
    s['showOnWorkingAdultProgramsHomepage'] = getShowOnWorkingAdultProgramsHomepage();
    s['summary']                            = getSummary();
    s['summaryHeaderPhoto']                 = getSummaryHeaderPhoto();
    s['title']                              = getTitle();

    return s;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private any function cleanDocument(required any document) {
    var tmpDoc = document;

    tmpDoc = removeMediaContact(tmpDoc);

    return tmpDoc;
  }

  private any function removeMediaContact (required any document) {
    var tmpDoc = document;
    var regexMediaContact = '';

    regexMediaContact &= '\s*';
    regexMediaContact &= 'Media';
    regexMediaContact &= '\s+';
    regexMediaContact &= 'Contact';
    regexMediaContact &= '\s*:';
    regexMediaContact &= '\s*';

    ArrayEach(document.select('*'), function (element) {
      if (1 == REFind(regexMediaContact, element.text())) {
        element.remove();
      }
    });

    return tmpDoc;
  }

  private boolean function isTruthy(v) {
    if (0 == ArrayLen(ARGUMENTS)) {
      return false;
    }
    if (!IsDefined('v')) {
      return false;
    }
    if (IsSimpleValue(v)) {
      if (IsNumeric(v)) {
        if (v <= 0) {
          return false;
        }
        return true;
      } else {
        if (0 == Len(v)) {
          return false;
        }
        return true;
      }
    }
    return true;
  }

  private void function setFromStruct (required struct s) {
    // Standard custom element data
    if (StructKeyExists(s, 'pageID')) {
      setPageID(s.pageID);
    }
    if (StructKeyExists(s, 'formID')) {
      setFormID(s.formID);
    }
    if (StructKeyExists(s, 'formName')) {
      setFormName(s.formName);
    }
    // Custom element fields
    if (StructKeyExists(s, 'considerForUniversityHomepage')) {
      if (IsNumeric(s.considerForUniversityHomepage)) {
        setConsiderForUniversityHomepage(s.considerForUniversityHomepage);
      }
    }
    if (StructKeyExists(s, 'contactEmail')) {
      setContactEmail(s.contactEmail);
    }
    if (StructKeyExists(s, 'contactName')) {
      setContactName(s.contactName);
    }
    if (StructKeyExists(s, 'contactPhone')) {
      setContactPhone(s.contactPhone);
    }
    if (StructKeyExists(s, 'content')) {
      setContent(s.content);
    }
    if (StructKeyExists(s, 'datePublished')) {
      setDatePublished(s.datePublished);
    }
    if (StructKeyExists(s, 'lblBusiness')) {
      setLblBusiness(s.lblBusiness);
    }
    if (StructKeyExists(s, 'lblEducation')) {
      setLblEducation(s.lblEducation);
    }
    if (StructKeyExists(s, 'lblEngineering')) {
      setLblEngineering(s.lblEngineering);
    }
    if (StructKeyExists(s, 'lblLaw')) {
      setLblLaw(s.lblLaw);
    }
    if (StructKeyExists(s, 'lblLiberalArts')) {
      setLblLiberalArts(s.lblLiberalArts);
    }
    if (StructKeyExists(s, 'lblMedicine')) {
      setLblMedicine(s.lblMedicine);
    }
    if (StructKeyExists(s, 'lblMercerUniversity')) {
      setLblMercerUniversity(s.lblMercerUniversity);
    }
    if (StructKeyExists(s, 'lblMusic')) {
      setlblMusic(s.lblMusic);
    }
    if (StructKeyExists(s, 'lblNews')) {
      setLblNews(s.lblNews);
    }
    if (StructKeyExists(s, 'lblNursing')) {
      setLblNursing(s.lblNursing);
    }
    if (StructKeyExists(s, 'lblPenfield')) {
      setLblPenfield(s.lblPenfield);
    }
    if (StructKeyExists(s, 'lblTheology')) {
      setLblTheology(s.lblTheology);
    }
    if (StructKeyExists(s, 'lblWorkingAdultPrograms')) {
      setLblWorkingAdultPrograms(s.lblWorkingAdultPrograms);
    }
    if (StructKeyExists(s, 'showInBusinessNews')) {
      if (IsNumeric(s.showInBusinessNews)) {
        setShowInBusinessNews(s.showInBusinessNews);
      }
    }
    if (StructKeyExists(s, 'showInCHPNews')) {
      if (IsNumeric(s.showInCHPNews)) {
        setShowInCHPNews(s.showInCHPNews);
      }
    }
    if (StructKeyExists(s, 'showInEducationNews')) {
      if (IsNumeric(s.showInEducationNews)) {
        setShowInEducationNews(s.showInEducationNews);
      }
    }
    if (StructKeyExists(s, 'showInEngineeringNews')) {
      if (IsNumeric(s.showInEngineeringNews)) {
        setShowInEngineeringNews(s.showInEngineeringNews);
      }
    }
    if (StructKeyExists(s, 'showInLawNews')) {
      if (IsNumeric(s.showInLawNews)) {
        setShowInLawNews(s.showInLawNews);
      }
    }
    if (StructKeyExists(s, 'showInLiberalArtsNews')) {
      if (IsNumeric(s.showInLiberalArtsNews)) {
        setShowInLiberalArtsNews(s.showInLiberalArtsNews);
      }
    }
    if (StructKeyExists(s, 'showInMedicineNews')) {
      if (IsNumeric(s.showInMedicineNews)) {
        setShowInMedicineNews(s.showInMedicineNews);
      }
    }
    if (StructKeyExists(s, 'showInMusicNews')) {
      if (IsNumeric(s.showInMusicNews)) {
        setShowInMusicNews(s.showInMusicNews);
      }
    }
    if (StructKeyExists(s, 'showInNursingNews')) {
      if (IsNumeric(s.showInNursingNews)) {
        setShowInNursingNews(s.showInNursingNews);
      }
    }
    if (StructKeyExists(s, 'showInPenfieldNews')) {
      if (IsNumeric(s.showInPenfieldNews)) {
        setShowInPenfieldNews(s.showInPenfieldNews);
      }
    }
    if (StructKeyExists(s, 'showInPharmacyNews')) {
      if (IsNumeric(s.showInPharmacyNews)) {
        setShowInPharmacyNews(s.showInPharmacyNews);
      }
    }
    if (StructKeyExists(s, 'showInTheologyNews')) {
      if (IsNumeric(s.showInTheologyNews)) {
        setShowInTheologyNews(s.showInTheologyNews);
      }
    }
    if (StructKeyExists(s, 'showInWorkingAdultProgramsNews')) {
      if (IsNumeric(s.showInWorkingAdultProgramsNews)) {
        setShowInWorkingAdultProgramsNews(s.showInWorkingAdultProgramsNews);
      }
    }
    if (StructKeyExists(s, 'showOnBusinessHomepage')) {
      if (IsNumeric(s.showOnBusinessHomepage)) {
        setShowOnBusinessHomepage(s.showOnBusinessHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnCHPHomepage')) {
      if (IsNumeric(s.showOnCHPHomepage)) {
        setShowOnCHPHomepage(s.showOnCHPHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnEducationHomepage')) {
      if (IsNumeric(s.showOnEducationHomepage)) {
        setShowOnEducationHomepage(s.showOnEducationHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnEngineeringHomepage')) {
      if (IsNumeric(s.showOnEngineeringHomepage)) {
        setShowOnEngineeringHomepage(s.showOnEngineeringHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnLawHomepage')) {
      if (IsNumeric(s.showOnLawHomepage)) {
        setShowOnLawHomepage(s.showOnLawHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnLiberalArtsHomepage')) {
      if (IsNumeric(s.showOnLiberalArtsHomepage)) {
        setShowOnLiberalArtsHomepage(s.showOnLiberalArtsHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnMedicineHomepage')) {
      if (IsNumeric(s.showOnMedicineHomepage)) {
        setShowOnMedicineHomepage(s.showOnMedicineHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnMusicHomepage')) {
      if (IsNumeric(s.showOnMusicHomepage)) {
        setShowOnMusicHomepage(s.showOnMusicHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnNewsHomepage')) {
      if (IsNumeric(s.showOnNewsHomepage)) {
        setShowOnNewsHomepage(s.showOnNewsHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnNursingHomepage')) {
      if (IsNumeric(s.showOnNursingHomepage)) {
        setShowOnNursingHomepage(s.showOnNursingHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnPenfieldHomepage')) {
      if (IsNumeric(s.showOnPenfieldHomepage)) {
        setShowOnPenfieldHomepage(s.showOnPenfieldHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnPharmacyHomepage')) {
      if (IsNumeric(s.showOnPharmacyHomepage)) {
        setShowOnPharmacyHomepage(s.showOnPharmacyHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnTheologyHomepage')) {
      if (IsNumeric(s.showOnTheologyHomepage)) {
        setShowOnTheologyHomepage(s.showOnTheologyHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnUniversityHomepage')) {
      if (IsNumeric(s.showOnUniversityHomepage)) {
        setShowOnUniversityHomepage(s.showOnUniversityHomepage);
      }
    }
    if (StructKeyExists(s, 'showOnWorkingAdultProgramsHomepage')) {
      if (IsNumeric(s.showOnWorkingAdultProgramsHomepage)) {
        setShowOnWorkingAdultProgramsHomepage(s.showOnWorkingAdultProgramsHomepage);
      }
    }
    if (StructKeyExists(s, 'summary')) {
      setSummary(s.summary);
    }
    if (StructKeyExists(s, 'summaryHeaderPhoto')) {
      setSummaryHeaderPhoto(s.summaryHeaderPhoto);
    }
    if (StructKeyExists(s, 'title')) {
      setTitle(s.title);
    }
  }

}
