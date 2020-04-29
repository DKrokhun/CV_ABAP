CLASS zcl_generate_data DEFINITION
 PUBLIC
 FINAL
 CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GENERATE_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:itab TYPE TABLE OF zinf_data_cv.

*   read current timestamp
    GET TIME STAMP FIELD DATA(zv_tsl).

*   fill internal travel table (itab)
    itab = VALUE #(
  ( id = 1 name = 'Avro Lancaster' department = 'Aviation' cvstatus = 'NeedToUpdate' )
  ( id = 2 name = 'Uziel Gal' department = 'Weaponry' cvstatus = 'NeedToUpdate' )
  ( id = 3 name = 'Kalashnikov Mikhail' department = 'Weaponry' cvstatus = 'NeedToUpdate' )
  ( id = 4 name = 'Mikoyan i Gurevich' department = 'Aviation' cvstatus = 'NeedToUpdate' )
 ).

*   delete existing entries in the database table
    DELETE FROM zinf_data_cv.
    DELETE FROM zinf_cv_file.

*   insert the new table entries
    INSERT zinf_data_cv FROM TABLE @itab.

*   check the result
    SELECT * FROM zinf_data_cv INTO TABLE @itab.
    out->write( sy-dbcnt ).
    out->write( 'Travel data inserted successfully!').

  ENDMETHOD.
ENDCLASS.
