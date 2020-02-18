@AbapCatalog.sqlViewName: 'ZINFCVFILE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for  table zinf_cv_file'
define view zinf_I_CVfile as select from zinf_cv_file 
association to parent zi_data_cv as _DataCV on $projection.id = _DataCV.id  

{
    //zinf_cv_file
    key id,
    key cvid,
    updated,
    cvname,
    cvftype,
    cvcontent,
    
    _DataCV
}
