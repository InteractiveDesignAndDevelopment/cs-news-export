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

}