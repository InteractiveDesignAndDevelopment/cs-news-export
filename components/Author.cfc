/**
 * Author.cfc
 *
 * @author Todd Sayre
 * @date 2017=08-11
 **/
component accessors=true output=false persistent=false {

  property name='ceDatum' type='struct';

  name = '';
  userName = '';
  emailAddress = '';

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public component function init (required struct ceDatum) {

    setCEDatum(ARGUMENTS.ceDatum);

    return this;
  }

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

   █████   ██████  ██████ ███████ ███████ ███████  ██████  ██████  ███████
  ██   ██ ██      ██      ██      ██      ██      ██    ██ ██   ██ ██
  ███████ ██      ██      █████   ███████ ███████ ██    ██ ██████  ███████
  ██   ██ ██      ██      ██           ██      ██ ██    ██ ██   ██      ██
  ██   ██  ██████  ██████ ███████ ███████ ███████  ██████  ██   ██ ███████

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  public string function getEmailAddress () {
    return LCase(getCEDatum().values.contactEmail);
  }

  public string function getName () {
    // WriteDump(getCEDatum());
    return getCEDatum().values.contactName;
  }

  public string function getUsername () {
    return LCase(ListFirst(getCEDatum().values.contactEmail, '@'));
  }

  public void function setCEDatum (required struct ceDatum) {
    VARIABLES.ceDatum = ARGUMENTS.ceDatum;
  }

}