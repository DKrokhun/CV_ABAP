@AbapCatalog.sqlViewName: 'ZINFCVFILE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for  table zinf_cv_file'
define root view zinf_I_CVfile as select from zinf_cv_file {
    //zinf_cv_file
    key id,
    key cvid,
    updated,
    cvname,
    cvftype,
    cvcontent
}
