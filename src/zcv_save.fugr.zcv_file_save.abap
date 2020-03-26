FUNCTION ZCV_FILE_SAVE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"----------------------------------------------------------------------
DATA: lt_insert TYPE TABLE OF zinf_cv_file.
DATA: ls_insert TYPE zinf_cv_file.
      ls_insert-id = 1.
      ls_insert-cvid = 2.

INSERT INTO zinf_cv_file VALUES @ls_insert.




ENDFUNCTION.
