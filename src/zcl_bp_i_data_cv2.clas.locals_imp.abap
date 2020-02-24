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
    DATA tsl TYPE timestampl.

    GET TIME STAMP FIELD tsl.

    MODIFY ENTITY zinf_I_CVfile

    UPDATE FROM VALUE #( FOR key IN keys ( cvid = key-cvid
                                           id = key-id
                                           cvname = 'New'
                                           updated = tsl
                                           %control-cvname = if_abap_behv=>mk-on
                                           %control-updated = if_abap_behv=>mk-on ) )
        FAILED failed
        REPORTED reported.

*    READ ENTITY zinf_I_CVfile
*    FROM VALUE #( FOR key IN keys ( cvid = key-cvid
*                                    id = key-id
*                                    %control = VALUE #(
*                                          updated       = if_abap_behv=>mk-on
*                                          cvftype       = if_abap_behv=>mk-on
*                                          cvname       = if_abap_behv=>mk-on
*                                        ) ) )
*                                     RESULT DATA(lt_file).
*
*    result =    VALUE #( FOR file IN lt_file ( cvid = file-cvid
*                                               %param    = file
*                                             ) ).

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
  ENDMETHOD.

ENDCLASS.
