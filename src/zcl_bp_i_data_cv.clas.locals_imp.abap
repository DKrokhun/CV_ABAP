*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_DataCV DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS upload       FOR MODIFY IMPORTING   keys FOR ACTION CV_data~upload              RESULT result.
    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR CV_data RESULT result.

ENDCLASS.

CLASS lhc_DataCV IMPLEMENTATION.

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
    SELECT MAX( id ) FROM zinf_cv_file INTO @DATA(lv_max).

    DATA(ls_Line) = VALUE zinf_cv_file( id = lv_max ).

    INSERT zinf_cv_file FROM @ls_line.
  ENDMETHOD.

ENDCLASS.
