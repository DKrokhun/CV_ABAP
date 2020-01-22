@EndUserText.label: 'Projection view for zinf_I_CVfile'
@AccessControl.authorizationCheck: #CHECK

@UI: {
 headerInfo: { typeName: 'CV file', typeNamePlural: 'CV files', title: { type: #STANDARD, value: 'id' } } }

@Search.searchable: true
define root view entity zinf_C_CVfile
  as projection on zinf_I_CVfile
{
      //zinf_I_CVfile

      @UI.facet: [ { id:              'CVfile',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'CV file',
                     position:        10 } ]
      @Search.defaultSearchElement: true
  key id,

      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 20 } ],
          selectionField: [ { position: 20 } ] }
  key cvid,

      @UI: {
          lineItem:       [ { position: 30, importance: #HIGH } ],
          identification: [ { position: 30 } ],
          selectionField: [ { position: 30 } ] }
      updated,

      @UI: {
          lineItem:       [ { position: 40, importance: #MEDIUM } ],
          identification: [ { position: 40 } ] }
      cvname,

      cvftype,
      cvcontent
}
