@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection view for CV data'


@UI: {
 headerInfo: { typeName: 'CV', typeNamePlural: 'CVs', title: { type: #STANDARD, value: 'id' } } }

@Search.searchable: true

define root view entity zc_data_cv
  as projection on zi_data_cv
{
      //zi_data_cv

      @UI.facet: [ { id:              'CV',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'CV',
                     position:        10 } ]

      @UI: {
          lineItem:       [ { position: 10, importance: #HIGH } ],
          identification: [ { position: 10, label: 'CV ID [1,...,99999999]' } ] }
      @Search.defaultSearchElement: true
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
      login
}
