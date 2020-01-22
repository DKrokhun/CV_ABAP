CLASS lhc_CVfile DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS upload       FOR MODIFY IMPORTING   keys FOR ACTION CVfile~upload              RESULT result.
    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR CVfile RESULT result.

ENDCLASS.

CLASS lhc_CVfile IMPLEMENTATION.

  METHOD get_features.

    READ ENTITY zinf_i_cvfile FROM VALUE #( FOR keyval IN keys
                                                      (  %key                    = keyval-%key
                                                         %control-id      = if_abap_behv=>mk-on
                                                         %control-cvid = if_abap_behv=>mk-on ) )
                                RESULT DATA(lt_cf_files).


    result = VALUE #( FOR ls_files IN lt_cf_files
                       ( %key                           = ls_files-%key
                         %features-%action-upload = if_abap_behv=>fc-o-enabled
                      ) ).

  ENDMETHOD.

  METHOD upload.

  ENDMETHOD.

ENDCLASS.
