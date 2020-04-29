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

  DATA: tsl TYPE timestamp,
        itab like entities,
        ls_update TYPE zinf_data_cv.

        GET TIME STAMP FIELD tsl.

     ls_update-cvstatus = entities[ 1 ]-cvstatus.
     ls_update-cvstatusid = entities[ 1 ]-cvstatusid.
     ls_update-updated = tsl.
     ls_update-id = entities[ 1 ]-id.


     UPDATE ZINF_DATA_CV SET
     zinf_data_cv~cvstatus      = @ls_update-cvstatus,
     zinf_data_cv~cvstatusid    = @ls_update-cvstatusid,
     zinf_data_cv~updated       = @ls_update-updated
     WHERE zinf_data_cv~id      = @ls_update-id.




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
  DATA tsl TYPE timestampl.

  GET TIME STAMP FIELD tsl.

  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD upload.

    DATA tsl TYPE timestampl.
    DATA itab LIKE KEYS.
    DATA: zfile TYPE STRING,
          zname TYPE STRING,
          ztype TYPE STRING,
          zunescaped_string TYPE STRING.

    DATA: lt_insert TYPE TABLE OF zinf_cv_file,
          ls_insert TYPE zinf_cv_file,
          lv_id TYPE INT4,
          lv_cvid TYPE INT4.

*        zunescaped_string = cl_http_utility=>unescape_url( zfile ).


        SELECT MAX( id ) FROM zinf_cv_file INTO @DATA(lv_max_id).
        SELECT MAX( cvid ) FROM zinf_cv_file INTO @DATA(lv_max_cvid).

        lv_id = lv_max_id.
        lv_cvid = lv_max_cvid.

        itab = KEYS.
        ls_insert-id = itab[ 1 ]-id.
        ls_insert-cvid = lv_cvid + 1.


        zfile = itab[ 1 ]-%param-cvcontent.
        zname = itab[ 1 ]-%param-cvname.
        ztype = itab[ 1 ]-%param-cvftype.


        GET TIME STAMP FIELD tsl.
        GET TIME STAMP FIELD DATA(zv_tsl).
        ls_insert-updated = zv_tsl. "timestamp field

        ls_insert-cvcontent = itab[ 1 ]-%param-cvcontent.
        ls_insert-cvftype = itab[ 1 ]-%param-cvftype.
        ls_insert-cvname = itab[ 1 ]-%param-cvname.

        INSERT INTO zinf_cv_file VALUES @ls_insert.

*        zcl_save_cv=>save_cv( EXPORTING i_scv_file = ls_insert ).


*     create(  ).

  ENDMETHOD.

  METHOD get_features.
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
