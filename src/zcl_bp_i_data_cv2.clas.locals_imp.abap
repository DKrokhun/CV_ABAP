CLASS lhc_CV_data DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE CV_data.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE CV_data.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE CV_data.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK CV_data.

    METHODS read FOR READ
      IMPORTING keys FOR READ CV_data RESULT result.

    METHODS cba_CVFILE FOR MODIFY
      IMPORTING entities_cba FOR CREATE CV_data\_cvfile.

    METHODS rba_CVFILE FOR READ
      IMPORTING keys_rba FOR READ CV_data\_cvfile FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_CV_data IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.


  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD cba_CVFILE.
  ENDMETHOD.

  METHOD rba_CVFILE.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_CV_file DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE CV_file.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE CV_file.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE CV_file.

    METHODS read FOR READ
      IMPORTING keys FOR READ CV_file RESULT result.

    METHODS upload FOR MODIFY
      IMPORTING keys FOR ACTION CV_file~upload RESULT result.

    METHODS uploadEmployeesList FOR MODIFY
      IMPORTING keys FOR ACTION CV_data~uploadEmployeesList RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR CV_file RESULT result.

ENDCLASS.

CLASS lhc_CV_file IMPLEMENTATION.

  METHOD create.
    MODIFY ENTITY zinf_I_CVfile

    CREATE FROM VALUE #( FOR entity IN entities  ( cvid = entity-cvid
                                                   id = entity-id ) )
        FAILED failed
        REPORTED reported.

  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD update.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD upload.
    DATA tsl TYPE timestamp.
    DATA: lv_max_cvid TYPE i,
          lt_file     TYPE TABLE OF zinf_cv_file.

    FIELD-SYMBOLS: <ls_key> LIKE LINE OF keys.

    ASSIGN keys[ 1 ] TO <ls_key>.
    CHECK sy-subrc = 0.

    SELECT MAX( cvid ) FROM zinf_cv_file WHERE id = @<ls_key>-id INTO @lv_max_cvid.

    lv_max_cvid += 1.

    GET TIME STAMP FIELD tsl.

*    MODIFY ENTITY zinf_I_CVfile
*
*    UPDATE FROM VALUE #( FOR key IN keys ( cvid = lv_max_cvid
*                                           id = key-id
*                                           cvname = key-%param-cvname
*                                           cvcontent = key-%param-cvcontent
*                                           cvftype = key-%param-cvftype
*                                           updated = tsl
*                                           %control-cvname = if_abap_behv=>mk-on
*                                           %control-updated = if_abap_behv=>mk-on ) )
*        FAILED failed
*        REPORTED reported.

    lt_file = VALUE #( FOR key IN keys ( cvid      = lv_max_cvid
                                         id        = key-id
                                         cvname    = key-%param-cvname
                                         cvcontent = key-%param-cvcontent
                                         cvftype   = key-%param-cvftype
                                         updated   = tsl ) ).

    INSERT zinf_cv_file FROM TABLE @lt_file.

  ENDMETHOD.

  METHOD get_features.
  ENDMETHOD.

  METHOD uploademployeeslist.
    DATA: lt_table   TYPE TABLE OF zinf_cv_employee,
          lt_data_cv TYPE TABLE OF zinf_data_cv,
          lv_max_id  TYPE i.

    FIELD-SYMBOLS: <ls_table>   TYPE zinf_cv_employee,
                   <fs_data_cv> TYPE zinf_data_cv.

    IF 1 = 0.
    ENDIF.

    DATA(xstring) = keys[ 1 ]-%param-cvcontent.

    DATA(string) = cl_http_utility=>decode_base64( encoded = xstring ).

    CALL TRANSFORMATION zifn_cv_upload_transformation SOURCE XML string
    RESULT  Employees = lt_table.

    DELETE FROM zinf_data_cv WHERE id IS NOT INITIAL.

    lv_max_id += 1.

    LOOP AT lt_table ASSIGNING <ls_table>.
      APPEND INITIAL LINE TO lt_data_cv ASSIGNING <fs_data_cv>.

      <fs_data_cv>-id = lv_max_id.
      <fs_data_cv>-name = <ls_table>-fullname.
      <fs_data_cv>-position_ = <ls_table>-position.
      <fs_data_cv>-email = <ls_table>-email.
      <fs_data_cv>-department = <ls_table>-department.
      <fs_data_cv>-cvstatus = 'NeedToUpdate'.

      lv_max_id += 1.
    ENDLOOP.

    INSERT zinf_data_cv FROM TABLE @lt_data_cv.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_data_cv DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS check_before_save REDEFINITION.

    METHODS finalize          REDEFINITION.

    METHODS save              REDEFINITION.

ENDCLASS.

CLASS lsc_zi_data_cv IMPLEMENTATION.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD save.
*    CALL FUNCTION 'ZCV_FILE_SAVE'.
  ENDMETHOD.

ENDCLASS.
