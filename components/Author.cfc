/**
 * Author.cfc
 *
 * @author Todd Sayre
 * @date 2017=08-11
 **/
component accessors=true output=false persistent=false {

  property name='displayName' type='string';
  property name='email'       type='string';
  property name='firstName'   type='string';
  property name='lastName'    type='string';
  property name='login'       type='string';
  property name='role'        type='string';

  /* =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

  ██ ███    ██ ██ ████████
  ██ ████   ██ ██    ██
  ██ ██ ██  ██ ██    ██
  ██ ██  ██ ██ ██    ██
  ██ ██   ████ ██    ██

  =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= */

  /*
   * init
   */
  public component function init (
      required string login,
      required string email,
      required string displayName,
      required string firstName,
      required string lastName,
      required string role) {

    variables.login       = arguments.login;
    variables.email       = arguments.email;
    variables.displayName = arguments.displayName;
    variables.firstName   = arguments.firstName;
    variables.lastName    = arguments.lastName;
    variables.role        = arguments.role;

    return this;
  }

  /*
   * toStructForExport
   */
  public struct function toStructForExport () {
    var s = structNew();

    s['first_name']   = getFirstName();
    s['last_name']    = getLastName();
    s['role']         = getRole();
    s['login']        = getLogin();
    s['display_name'] = getDisplayName();
    s['email']        = getEmail();

    return s;
  }

  /*
   *
   */
  public string function toXML () {
    var xml = '';
    var s = toStructForExport();

    savecontent variable='xml' {
      writeOutput('<author>');
      writeOutput('<first_name>#s['first_name']#</first_name>');
      writeOutput('<last_name>#s['last_name']#</last_name>');
      writeOutput('<role>#s['role']#</role>');
      writeOutput('<login>#s['login']#</login>');
      writeOutput('<email>#s['email']#</email>');
      writeOutput('<display_name>#s['display_name']#</display_name>');
      writeOutput('</author>');
    }

    return xml;
  }

}