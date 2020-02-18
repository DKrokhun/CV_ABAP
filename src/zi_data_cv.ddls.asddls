@AbapCatalog.sqlViewName: 'ZIDATACV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic view for CV data'
define root view zi_data_cv
  as select from zinf_data_cv

  composition [1..*] of zinf_I_CVfile as _CVfile

{
      //zinf_data_cv
  key id,
      name,
      department,
      position_,
      grade,
      manager,
      request,
      updated,
      cvstatus,
      cvstatusid,
      cvid,
      upload,
      email,
      login,

      _CVfile
}
