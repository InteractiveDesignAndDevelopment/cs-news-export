/**
 * Authors.cfc
 *
 * @author Todd Sayre
 * @date 2017=08-10
 **/
component accessors=true output=false persistent=false {

  property name='ceData' type='array';

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init () {
    if (1 == ArrayLen(ARGUMENTS)) {
      if (IsSimpleValue(ARGUMENTS[1])) {
        if (IsNumeric(ARGUMENTS[1])) {
          setCEData(findByPageID(ARGUMENTS[1]));
        } else if ('all' == LCase(ARGUMENTS[1])) {
          // WriteOutput('<div>All News Articles</div>');
          setCEData(application.adf.ceData.getCEData('News Article'));
        }
      } else if (IsArray(ARGUMENTS[1])) {
        setCEData(ARGUMENTS[1]);
      }
    }

    // setCEData([]);

    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

   █████   ██████  ██████ ███████ ███████ ███████  ██████  ██████  ███████
  ██   ██ ██      ██      ██      ██      ██      ██    ██ ██   ██ ██
  ███████ ██      ██      █████   ███████ ███████ ██    ██ ██████  ███████
  ██   ██ ██      ██      ██           ██      ██ ██    ██ ██   ██      ██
  ██   ██  ██████  ██████ ███████ ███████ ███████  ██████  ██   ██ ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  // public void function setCEData (required array ceData) {
  //   VARIABLES.ceData = ARGUMENTS.ceData;

  //   // WriteDump(ceData);

  //   authors = ArrayMap(VARIABLES.ceData, function (s) {
  //     return new Author(s);
  //   });
  // }

  // ceData without media contact information is filtered out
  public void function setCEData (required array ceData) {
    var tmpCEData = ceData;

    tmpCEData = ArrayFilter(tmpCEData, function(ceDatum) {
      return 0 < Len(ceDatum.values.contactEmail) && 0 < Len(ceDatum.values.contactName);
    });

    VARIABLES.ceData = tmpCEData;

    // WriteDump(ceData);
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██    ██ ██████  ██      ██  ██████
  ██   ██ ██    ██ ██   ██ ██      ██ ██
  ██████  ██    ██ ██████  ██      ██ ██
  ██      ██    ██ ██   ██ ██      ██ ██
  ██       ██████  ██████  ███████ ██  ██████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function findByPageID (required numeric id) {
    var ceData = ArrayFilter(getCEData(), function (datum) {
      return ARGUMENTS.id == datum.pageID;
    });

    return new Authors(ceData);
  }

  public component function first (numeric x = 1) {
    if (length() < x) {
      x = length();
    }

    var tmpCEData = ArraySlice(getCEData(), 1, x);

    return new Authors(tmpCEData);
  }

  public component function get (required numeric x) {
    return new Author(getCEData()[x]);
  }

  public component function last (numeric x = 1) {
    if (length() < x) {
      x = length();
    }

    var tmpCEData = ArraySlice(getCEData(), length() - x, x);

    return new Authors(tmpCEData);
  }

  public numeric function length () {
    return ArrayLen(getCEData());
  }

  public component function sort (sortProp = 'username') {
    var tmpCEData = getCEData();

    ArraySort(tmpCEData, function(e1, e2) {
      var a1 = new Author(e1);
      var a2 = new Author(e2);
      var v1 = '';
      var v2 = '';

      if ('username' == sortProp) {
        v1 = LCase(a1.getUserName());
        v2 = LCase(a2.getUserName());
      }

      // WriteOutput('<div>v1 = #v1#</div>');
      // WriteOutput('<div>v2 = #v2#</div>');

      return compare(v1, v2);
    });

    return new Authors(tmpCEData);
  }

  public array function toArray () {
    var arr = getCEData();

    // WriteDump(var = getCEData(), label = 'toArray ceData');

    arr = ArrayMap(arr, function(ceDatum) {
      return new Author(ceDatum);
    });

    return arr;
  }

  public component function unique () {
    var tmpCEData = getCEData();
    var seenUserNames = [];

    tmpCEData = ArrayFilter(tmpCEData, function(ceDatum) {
      var a = new Author(ceDatum);
      var u = a.getUsername();

      if (! ArrayFindNoCase(seenUserNames, u)) {
        ArrayAppend(seenUserNames, u);
        return true;
      } else {
        return false;
      }
    });

    return new Authors(tmpCEData);
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██████  ██████  ██ ██    ██  █████  ████████ ███████
  ██   ██ ██   ██ ██ ██    ██ ██   ██    ██    ██
  ██████  ██████  ██ ██    ██ ███████    ██    █████
  ██      ██   ██ ██  ██  ██  ██   ██    ██    ██
  ██      ██   ██ ██   ████   ██   ██    ██    ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

}