/**
 * NewsArticle.cfc
 *
 * This file was created on the birthday of @elcopeland
 *
 * @author Todd Sayre
 * @date 2017-07-07
 **/
component accessors=true output=false persistent=false {

  // CommonSpot custom element record
  property name='csPageID'   type='numeric';

  // Fields in the CommonSpot News Article custom element
  property name='csConsiderForUniversityHomepage'      type='string';
  property name='csContactEmail'                       type='string';
  property name='csContactName'                        type='string';
  property name='csContactPhone'                       type='string';
  property name='csContent'                            type='string';
  property name='csDatePublished'                      type='string';
  property name='csLblBusiness'                        type='string';
  property name='csLblCHP'                             type='string';
  property name='csLblEducation'                       type='string';
  property name='csLblEngineering'                     type='string';
  property name='csLblLaw'                             type='string';
  property name='csLblLiberalArts'                     type='string';
  property name='csLblMedicine'                        type='string';
  property name='csLblMercerUniversity'                type='string';
  property name='csLblMusic'                           type='string';
  property name='csLblNews'                            type='string';
  property name='csLblNursing'                         type='string';
  property name='csLblPenfield'                        type='string';
  property name='csLblPharmacy'                        type='string';
  property name='csLblTheology'                        type='string';
  property name='csLblWorkingAdultPrograms'            type='string';
  property name='csShowInBusinessNews'                 type='string';
  property name='csShowInCHPNews'                      type='string';
  property name='csShowInEducationNews'                type='string';
  property name='csShowInEngineeringNews'              type='string';
  property name='csShowInLawNews'                      type='string';
  property name='csShowInLiberalArtsNews'              type='string';
  property name='csShowInMedicineNews'                 type='string';
  property name='csShowInMusicNews'                    type='string';
  property name='csShowInNursingNews'                  type='string';
  property name='csShowInPenfieldNews'                 type='string';
  property name='csShowInPharmacyNews'                 type='string';
  property name='csShowInTheologyNews'                 type='string';
  property name='csShowInWorkingAdultProgramsNews'     type='string';
  property name='csShowOnBusinessHomepage'             type='string';
  property name='csShowOnCHPHomepage'                  type='string';
  property name='csShowOnEducationHomepage'            type='string';
  property name='csShowOnEngineeringHomepage'          type='string';
  property name='csShowOnLawHomepage'                  type='string';
  property name='csShowOnLiberalArtsHomepage'          type='string';
  property name='csShowOnMedicineHomepage'             type='string';
  property name='csShowOnMusicHomepage'                type='string';
  property name='csShowOnNewsHomepage'                 type='string';
  property name='csShowOnNursingHomepage'              type='string';
  property name='csShowOnPenfieldHomepage'             type='string';
  property name='csShowOnPharmacyHomepage'             type='string';
  property name='csShowOnTheologyHomepage'             type='string';
  property name='csShowOnUniversityHomepage'           type='string';
  property name='csShowOnWorkingAdultProgramsHomepage' type='string';
  property name='csSummary'                            type='string';
  property name='csSummaryHeaderPhoto'                 type='string';
  property name='csTitle'                              type='string';

  jSoup = createObject('java', 'org.jsoup.Jsoup');

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init (
    csPageID,
    csConsiderForUniversityHomepage,
    csContactEmail,
    csContactName,
    csContactPhone,
    csContent,
    csDatePublished,
    csLblBusiness,
    csLblCHP,
    csLblEducation,
    csLblEngineering,
    csLblLaw,
    csLblLiberalArts,
    csLblMedicine,
    csLblMercerUniversity,
    csLblMusic,
    csLblNews,
    csLblNursing,
    csLblPenfield,
    csLblPharmacy,
    csLblTheology,
    csLblWorkingAdultPrograms,
    csShowInBusinessNews,
    csShowInCHPNews,
    csShowInEducationNews,
    csShowInEngineeringNews,
    csShowInLawNews,
    csShowInLiberalArtsNews,
    csShowInMedicineNews,
    csShowInMusicNews,
    csShowInNursingNews,
    csShowInPenfieldNews,
    csShowInPharmacyNews,
    csShowInTheologyNews,
    csShowInWorkingAdultProgramsNews,
    csShowOnBusinessHomepage,
    csShowOnCHPHomepage,
    csShowOnEducationHomepage,
    csShowOnEngineeringHomepage,
    csShowOnLawHomepage,
    csShowOnLiberalArtsHomepage,
    csShowOnMedicineHomepage,
    csShowOnMusicHomepage,
    csShowOnNewsHomepage,
    csShowOnNursingHomepage,
    csShowOnPenfieldHomepage,
    csShowOnPharmacyHomepage,
    csShowOnTheologyHomepage,
    csShowOnUniversityHomepage,
    csShowOnWorkingAdultProgramsHomepage,
    csSummary,
    csSummaryHeaderPhoto,
    csTitle
  ) {
    setCsPageID(arguments.csPageID);
    setCsConsiderForUniversityHomepage(arguments.csConsiderForUniversityHomepage);
    setCsContactEmail(arguments.csContactEmail);
    setCsContactName(arguments.csContactName);
    setCsContactPhone(arguments.csContactPhone);
    setCsContent(arguments.csContent);
    setCsDatePublished(arguments.csDatePublished);
    setCsLblBusiness(arguments.csLblBusiness);
    setCsLblCHP(arguments.csLblCHP);
    setCsLblEducation(arguments.csLblEducation);
    setCsLblEngineering(arguments.csLblEngineering);
    setCsLblLaw(arguments.csLblLaw);
    setCsLblLiberalArts(arguments.csLblLiberalArts);
    setCsLblMedicine(arguments.csLblMedicine);
    setCsLblMercerUniversity(arguments.csLblMercerUniversity);
    setCsLblMusic(arguments.csLblMusic);
    setCsLblNews(arguments.csLblNews);
    setCsLblNursing(arguments.csLblNursing);
    setCsLblPenfield(arguments.csLblPenfield);
    setCsLblPharmacy(arguments.csLblPharmacy);
    setCsLblTheology(arguments.csLblTheology);
    setCsLblWorkingAdultPrograms(arguments.csLblWorkingAdultPrograms);
    setCsShowInBusinessNews(arguments.csShowInBusinessNews);
    setCsShowInCHPNews(arguments.csShowInCHPNews);
    setCsShowInEducationNews(arguments.csShowInEducationNews);
    setCsShowInEngineeringNews(arguments.csShowInEngineeringNews);
    setCsShowInLawNews(arguments.csShowInLawNews);
    setCsShowInLiberalArtsNews(arguments.csShowInLiberalArtsNews);
    setCsShowInMedicineNews(arguments.csShowInMedicineNews);
    setCsShowInMusicNews(arguments.csShowInMusicNews);
    setCsShowInNursingNews(arguments.csShowInNursingNews);
    setCsShowInPenfieldNews(arguments.csShowInPenfieldNews);
    setCsShowInPharmacyNews(arguments.csShowInPharmacyNews);
    setCsShowInTheologyNews(arguments.csShowInTheologyNews);
    setCsShowInWorkingAdultProgramsNews(arguments.csShowInWorkingAdultProgramsNews);
    setCsShowOnBusinessHomepage(arguments.csShowOnBusinessHomepage);
    setCsShowOnCHPHomepage(arguments.csShowOnCHPHomepage);
    setCsShowOnEducationHomepage(arguments.csShowOnEducationHomepage);
    setCsShowOnEngineeringHomepage(arguments.csShowOnEngineeringHomepage);
    setCsShowOnLawHomepage(arguments.csShowOnLawHomepage);
    setCsShowOnLiberalArtsHomepage(arguments.csShowOnLiberalArtsHomepage);
    setCsShowOnMedicineHomepage(arguments.csShowOnMedicineHomepage);
    setCsShowOnMusicHomepage(arguments.csShowOnMusicHomepage);
    setCsShowOnNewsHomepage(arguments.csShowOnNewsHomepage);
    setCsShowOnNursingHomepage(arguments.csShowOnNursingHomepage);
    setCsShowOnPenfieldHomepage(arguments.csShowOnPenfieldHomepage);
    setCsShowOnPharmacyHomepage(arguments.csShowOnPharmacyHomepage);
    setCsShowOnTheologyHomepage(arguments.csShowOnTheologyHomepage);
    setCsShowOnUniversityHomepage(arguments.csShowOnUniversityHomepage);
    setCsShowOnWorkingAdultProgramsHomepage(arguments.csShowOnWorkingAdultProgramsHomepage);
    setCsSummary(arguments.csSummary);
    setCsSummaryHeaderPhoto(arguments.csSummaryHeaderPhoto);
    setCsTitle(arguments.csTitle);

    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

   █████   ██████  ██████ ███████ ███████ ███████  ██████  ██████  ███████
  ██   ██ ██      ██      ██      ██      ██      ██    ██ ██   ██ ██
  ███████ ██      ██      █████   ███████ ███████ ██    ██ ██████  ███████
  ██   ██ ██      ██      ██           ██      ██ ██    ██ ██   ██      ██
  ██   ██  ██████  ██████ ███████ ███████ ███████  ██████  ██   ██ ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  // public string function getSummaryHeaderPhoto(boolean isForExport = false) {
  //   if (! isForExport) {
  //     return VARIABLES.summaryHeaderPhoto;
  //   }
  //   if (0 == Len(VARIABLES.summaryHeaderPhoto)) {
  //     return '';
  //   }
  //   var deciphered = Application.ADF.csData.decipherCPImage(VARIABLES.summaryHeaderPhoto);
  //   // WriteDump(deciphered);
  //   return deciphered.resolvedURL.absolute;
  // }

  /*
   * getCategories
   */
  public string function getCategories() {
    var categories = arrayNew(1);

    if (isTruthy(getCsShowInBusinessNews()) || isTruthy(getCsShowOnBusinessHomepage())) {
      ArrayAppend(categories, 'Business & Economics');
    }
    if (isTruthy(getCsShowInCHPNews()) || isTruthy(getCsShowOnCHPHomepage())) {
      ArrayAppend(categories, 'Health Professions');
    }
    if (isTruthy(getCsShowInEducationNews()) || isTruthy(getCsShowOnEducationHomepage())) {
      ArrayAppend(categories, 'Education');
    }
    if (isTruthy(getCsShowInEngineeringNews()) || isTruthy(getCsShowOnEngineeringHomepage())) {
      ArrayAppend(categories, 'Engineering');
    }
    if (isTruthy(getCsShowInLawNews()) || isTruthy(getCsShowOnLawHomepage())) {
      ArrayAppend(categories, 'Law');
    }
    if (isTruthy(getCsShowInLiberalArtsNews()) || isTruthy(getCsShowOnLiberalArtsHomepage())) {
      ArrayAppend(categories, 'Liberal Arts');
    }
    if (isTruthy(getCsShowInMedicineNews()) || isTruthy(getCsShowOnMedicineHomepage())) {
      ArrayAppend(categories, 'Medicine');
    }
    if (isTruthy(getCsShowInMusicNews()) || isTruthy(getCsShowOnMusicHomepage())) {
      ArrayAppend(categories, 'Music');
    }
    if (isTruthy(getCsShowInNursingNews()) || isTruthy(getCsShowOnNursingHomepage())) {
      ArrayAppend(categories, 'Nursing');
    }
    if (isTruthy(getCsShowInPenfieldNews()) || isTruthy(getCsShowOnPenfieldHomepage())) {
      ArrayAppend(categories, 'Penfield');
    }
    if (isTruthy(getCsShowInPharmacyNews()) || isTruthy(getCsShowOnPharmacyHomepage())) {
      ArrayAppend(categories, 'Pharmacy');
    }
    if (isTruthy(getCsShowInTheologyNews()) || isTruthy(getCsShowOnTheologyHomepage())) {
      ArrayAppend(categories, 'Theology');
    }
    if (isTruthy(getCsShowInWorkingAdultProgramsNews()) || isTruthy(getCsShowOnWorkingAdultProgramsHomepage())) {
      ArrayAppend(categories, 'Working Adults');
    }

    if (0 == arrayLen(categories)) {
      arrayAppend(categories, 'General');
    }

    return arrayToList(categories);
  }

  /*
   * getContent
   */
  public string function getContent() {
    var content = VARIABLES.csContent;
    content = deMoronize(content);
    content = cleanContentHTML(content);
    var document = jSoup.parseBodyFragment(content);
    document = fullyQualifyURLsInLinksInDocument(document);
    document = removeExtraneousLinksFromDocument(document);
    document = removeEmptyPTagsFromDocument(document);
    document = stripMediaContactFromDocument(document);
    document = unwrapParagraphsInTablesInDocument(document);
    // document.OutputSettings().prettyPrint(true);
    content = document.body().html();

    var images = getImages();
    if (1 < listLen(images)) {
      content &= '#chr(10)#[gallery]#chr(10)#';
    }

    return content;
  }

  /*
   * getExcerpt
   */
  public string function getExcerpt() {
    return VARIABLES.csSummary;
  }

  /*
   * getImages
   */
  public string function getImages() {
    var images = '';
    var summaryHeaderPhotoURL = '';

    images = extractImageURLs(getCsContent());
    // DEBUG: Before images are processed
    // writeOutput('<div>[#images#]</div>');

    images = fullyQualifyURLList(images);
    // DEBUG: After images are processed
    // writeOutput('<div>(#images#)</div>');

    // DEBUG: Title images
    // writeOutput('<div>#getCSSummaryHeaderPhoto()#</div>');

    if (0 < Len(getCSSummaryHeaderPhoto())) {
      summaryHeaderPhotoURL = application.adf.csData.decipherCPImage(getCSSummaryHeaderPhoto());
      if (isStruct(summaryHeaderPhotoURL) &&
        structKeyExists(summaryHeaderPhotoURL, 'RESOLVEDURL') &&
        isStruct(summaryHeaderPhotoURL['RESOLVEDURL']) &&
        structKeyExists(summaryHeaderPhotoURL['RESOLVEDURL'], 'ABSOLUTE')) {
        summaryHeaderPhotoURL = summaryHeaderPhotoURL['RESOLVEDURL']['ABSOLUTE'];
        // writeDump(summaryHeaderPhotoURL);
        images = ListPrepend(images, summaryHeaderPhotoURL);
      }
    }

    if (0 == Len(images)) {
      images = listAppend(images, pickRandomImage());
    }

    images = normalizeURLListByFileName(images);

    return images;
  }

  /*
   * getPostAuthor
   */
  public string function getPostAuthor() {
    var postAuthor = getCSContactEmail();
    postAuthor = emailToLogin(postAuthor);
    if (0 == Len(Trim(postAuthor))) {
      postAuthor = 'news';
    }
    return postAuthor;
  }

  /*
   * No tags are being exports so far as I know
   */
  public string function getTags() {
    var tags = '';
    return tags;
  }

  /*
   * getPostDate
   */
  public string function getPostDate() {
    var date = getCsDatePublished();
    date = dateFormat(date, 'yyyy-mm-dd');
    return date;
  }

  /*
   * getPostSlug
   */
  public string function getPostSlug() {
    var pageID = getCSPageID();
    // writeDump(getCSPageID());
    // writeDump(application.adf.ceData.getElementInfoByPageID(getCSPageID()));
    // WriteDump(application.adf.csData.getCSPageURL(pageID));
    // WriteDump(application.adf.csData.getPageStandardMetadata(pageID));
    var metadata = application.adf.csData.getPageStandardMetadata(pageID);
    var fileName = metadata.FileName;
    var slug = replaceNoCase(fileName, '.cfm', '');
    return slug;
  }

  /*
   * getTitle
   */
  public string function getTitle() {
    return VARIABLES.csTitle;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  /*
   * This facilitites XML export feature
   * Not everything is HTML encdoded because of how WordPress and WPAllImport work
   */
  public struct function toStructForExport () {
    var s = {};

    s['title']       = encodeForXML(getTitle());
    s['content']     = encodeForXML(getContent());
    s['excerpt']     = encodeForXML(getExcerpt());
    s['images']      = encodeForXML(getImages());
    s['cs_page_id']  = encodeForXML(getCsPageID());
    s['categories']  = encodeForXML(getCategories());
    s['tags']        = encodeForXML(getTags());
    s['post_date']   = encodeForXML(getPostDate());
    s['post_slug']   = encodeForXML(getPostSlug());
    s['post_author'] = encodeForXML(getPostAuthor());

    return s;
  }

  /*
   *
   */
  public string function toXML () {
    var xml = '';
    var s = toStructForExport();

    savecontent variable='xml' {
      writeOutput('<article>#chr(10)#');
      writeOutput('<title>#s['title']#</title>#chr(10)#');
      writeOutput('<content>#s['content']#</content>#chr(10)#');
      writeOutput('<excerpt>#s['excerpt']#</excerpt>#chr(10)#');
      writeOutput('<images>#s['images']#</images>#chr(10)#');
      writeOutput('<cs_page_id>#s['cs_page_id']#</cs_page_id>#chr(10)#');
      writeOutput('<categories>#s['categories']#</categories>#chr(10)#');
      writeOutput('<tags>#s['tags']#</tags>#chr(10)#');
      writeOutput('<post_date>#s['post_date']#</post_date>#chr(10)#');
      writeOutput('<post_slug>#s['post_slug']#</post_slug>#chr(10)#');
      writeOutput('<post_author>#s['post_author']#</post_author>#chr(10)#');
      writeOutput('</article>#chr(10)#');
    }

    return xml;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  private string function extractImageURLs(required string corpus) {
    var urls = arrayNew(1);
    var dom = VARIABLES.jSoup.parseBodyFragment(corpus);
    ArrayEach(dom.select('img'), function(i) {
      var url = i.attr('src');
      arrayAppend(urls, url);
    });
    return arrayToList(urls);
  }

  /*
   * Basically, does it have a protocol
   * e.g.
   * - http:
   * - https:
   * - mailto:
   * - tel:
   */
  private boolean function isURLFullyQualified (required string url) {
    return 1 == REFindNoCase('^[a-z][a-z0-9+.-]*:', url);
  }

  private boolean function isURLProtocolRelative (required string url) {
    return 1 < Len(url) && '//' == Left(url, 2);
  }

  private boolean function isURLRootRelative(required string url) {
    return 1 == Len(url) && '/' == Left(url, 1) || 1 < Len(url) && '/' != Mid(url, 2, 1);
  }

  private string function fullyQualifyURLList(required string urlList) {
    var fqURLList = '';
    listEach(urlList, function(url) {
      var fqURL = fullyQualifyURL(url);
      // writeOutput('<div>#fqURL#</div>');
      fqURLList = ListAppend(fqURLList, fqURL);
    });
    return fqURLList;
  }

  private string function fullyQualifyURL (required string url) {
    var fqURL = '';

    if (isURLFullyQualified(url)) {
      fqURL &= url;
    } else if (isURLProtocolRelative(url)) {
      fqURL &= 'http:#url#';
    } else if (isURLRootRelative(url)) {
      fqURL &= 'http://';
      fqURL &= domainFromRootRelativeURL(url);
      fqURL &= stripDomainDirectoryFromURL(url);
    } else {
      fqURL = url;
    }

    return fqURL;
  }

  /*
   * This isn't necessary for urls to work
   * But it should help with 404s
   */
  private string function domainFromRootRelativeURL (url) {
    var domain = '';
    var results = REFindNoCase('(com|mu|tv)-([^/]+)', url, 1, true);
    var match = '';
    var prefix = '';
    var siteName = '';

    if (IsStruct(results) && 3 == ArrayLen(results.pos)) {
      match = Mid(url, results.pos[1], results.len[1]);
      prefix = Mid(url, results.pos[2], results.len[2]);
      siteName = Mid(url, results.pos[3], results.len[3]);
    }

    // WriteOutput('<div>Match #match#</div>');
    // WriteOutput('<div>Prefix #prefix#</div>');
    // WriteOutput('<div>Site Name #siteName#</div>');

    if ('com' == prefix) {
      domain = '#siteName#.com';
    } else if ('mu' == prefix) {
      domain = '#siteName#.mercer.edu';
    } else if ('tv' == prefix) {
      domain = '#siteName#.tv';
    } else {
      domain = 'www.mercer.edu';
    }

    return domain;
  }

  /*
   * This isn't necessary for images, but it does make regular links more useful
   */
  private string function stripDomainDirectoryFromURL (url) {
    var tmpURL = '';
    var escapedCPURL = replace(request.site.CP_URL, '/', '\/', 'all');
    var regex = '#escapedCPURL#(?:com|mu|tv)-(?:[^/]+)';
    var matches = REMatchNoCase(regex, url);
    // DEBUG: URL-matching Regular Expression
    // writeOutput('<div>#regex#</div>');
    // WriteDump(var = matches, label = 'stripDomainDirectoryFromURL directory');
    if (IsArray(matches) && 1 == ArrayLen(matches)) {
      tmpURL = Replace(url, matches[1], '');
    } else {
      tmpURL = url;
    }
    return tmpURL;
  }

  private any function stripMediaContactFromDocument (required any document) {
    var regexMediaContact = '^\s*Media\s+Contact\s*:\s*$';
    ArrayEach(document.select('*'), function (element) {
      var text = element.text();
      text = replaceNoCase(text, '&nbsp;', ' ');
      text = reReplace(text, '\s+', ' ');
      if (1 == REFind(regexMediaContact, text)) {
        element.remove();
      }
    });
    return document;
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
   * @param text    Text to be modified. (Required)
   * @return Returns a string.
   * @author Shawn Porter (sporter@rit.net)
   * @version 2, September 2, 2010
   */
  private string function deMoronize (text) {
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
    for (i = 128; i LTE 159; i = i + 1) {
      text = Replace(text, Chr(i), "", "All");
    }

    // map Latin-1 supplemental characters into
    // their &name; encoded substitutes
    text = Replace(text, Chr(160), "&nbsp;", "All");

    text = Replace(text, Chr(163), "&pound;", "All");

    text = Replace(text, Chr(169), "&copy;", "All");

    text = Replace(text, Chr(176), "&deg;", "All");

    // encode ASCII 160-255 using ? format
    for (i = 160; i LTE 255; i = i + 1) {
      text = REReplace(text, "(#Chr(i)#)", "&###i#;", "All");
    }

    for (i = 8216; i LTE 8218; i = i + 1) {
      text = Replace(text, Chr(i), "'", "All");
    }

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

  private any function fullyQualifyURLsInLinksInDocument(any document) {
    var links = document.select('a[href]');

    // writeDump(links);

    ArrayEach(links, function (link) {
      // DEBUG: Before link
      // writeOutput('<div>#link.attr("href")#</div>');
      var href = link.attr('href');
      var fqHref = fullyQualifyURL(href);
      link.attr('href', fqHref);
      // Debug: After link
      // writeOutput('<div>#link.attr("href")#</div>');
    });

    return document;
  }

  /*
   * h1s will be replaced with h2s in another function
   */
  private string function cleanContentHTML(string html) {
    var allowableTags = arrayNew(1);
    var whitelist = createObject('java', 'org.jsoup.safety.Whitelist');
    arrayAppend(allowableTags, 'a');
    arrayAppend(allowableTags, 'b');
    arrayAppend(allowableTags, 'br');
    arrayAppend(allowableTags, 'em');
    arrayAppend(allowableTags, 'h1');
    arrayAppend(allowableTags, 'h2');
    arrayAppend(allowableTags, 'h3');
    arrayAppend(allowableTags, 'h4');
    arrayAppend(allowableTags, 'h5');
    arrayAppend(allowableTags, 'h6');
    arrayAppend(allowableTags, 'i');
    arrayAppend(allowableTags, 'p');
    arrayAppend(allowableTags, 'strong');
    arrayAppend(allowableTags, 'table');
    arrayAppend(allowableTags, 'tbody');
    arrayAppend(allowableTags, 'td');
    arrayAppend(allowableTags, 'thead');
    arrayAppend(allowableTags, 'th');
    arrayAppend(allowableTags, 'tr');
    whitelist.addTags(allowableTags);
    whitelist.addAttributes('a', ['href']);
    whitelist.addAttributes('td', ['colspan', 'rowspan']);
    whitelist.addAttributes('th', ['colspan', 'rowspan']);
    return jSoup.clean(html, whitelist);
  }

  private any function removeEmptyPTagsFromDocument(any document) {
    var pTags = document.select('p');
    ArrayEach(pTags, function (p) {
      var text = p.text();
      text = replace(text, '&nbps;', ' ');
      var hasWords = 0 < ArrayLen(reMatch('\w', text));
      if (! hasWords) {
        p.remove();
      }
    });
    return document;
  }

  private any function removeExtraneousLinksFromDocument(any document) {
    var aTags = document.select('a');
    arrayEach(aTags, function(a) {
      if (! a.hasAttr('href')) {
        a.unwrap();
      }
    });
    return document;
  }

  private string function pickRandomImage() {
    var randomImages = arrayNew(1);
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DJI_0003.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DJI_0036.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DJI_0049.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DJI_0060.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DJI_0310.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DSC_7697.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DSC_7716.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DSC_7722.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DSC_8550.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/DSC_9141.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MATT4582.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MATT4596.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MATT4751.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MATT5589.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MATT7896.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MATT7907.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MATT7945.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MER_7373.jpg');
    ArrayAppend(randomImages, 'https://assets.mercer.edu/news-import-stock-images/MER_8635.jpg');
    return randomImages[randRange(1, arrayLen(randomImages))];
  }

  /*
   * Return the login derived from the given email address.
   * This is a blunt instrument; wield with caution.
   */
  private function emailToLogin(required string email) {
    return lCase(listFirst(email, '@'));
  }

  /*
   * This isn't strictly necessary, but it mirrors how the WP All Import plugin works
   * This keeps the export in line with the import
   */
  private function normalizeURLListByFileName(required string urlList) {
    var normalizedURLList = '';
    var fileNames = [];
    listEach(urlList, function (url) {
      var fileName = getFileFromPath(url);
      fileName = lCase(fileName);
      // writeDump(fileName);
      if (0 == arrayFind(fileNames, fileName)) {
        arrayAppend(fileNames, fileName);
        normalizedURLList = listAppend(normalizedURLList, url);
      }
    });
    return normalizedURLList;
  }

  /*
   * Paragraphs in tables just make the tables longer
   */
  private function unwrapParagraphsInTablesInDocument(required any document) {
    var tmpDocument = document;
    var tdPs = tmpDocument.select('table p:only-child');
    // writeDump(tdPs);
    arrayEach(tdPs, function(el) {
      el.unwrap();
    });
    return tmpDocument;
  }

}
