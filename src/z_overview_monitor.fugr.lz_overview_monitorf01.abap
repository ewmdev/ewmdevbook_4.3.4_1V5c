*&---------------------------------------------------------------------*
*& Include          LZ_OVERVIEW_MONITORF01
*&---------------------------------------------------------------------*
*&---------------------------------------------------*
*& Form BATCH_VAL
*----------------------------------------------------*
FORM batch_val USING
it_stock_mon TYPE /scwm/tt_stock_mon
iv_mode TYPE /scwm/de_mon_fm_mode.
  DATA:
    ls_whbatch    TYPE /scwm/s_batch,
    lt_whbatch    TYPE /scwm/tt_batch,
    lo_batch_appl TYPE REF TO /scwm/cl_batch_appl,
    ls_batch      TYPE /scwm/s_ui_batch,
    lt_val_num    TYPE tt_bapi1003_alloc_values_num,
    lt_val_char   TYPE tt_bapi1003_alloc_values_char,
    lt_val_curr   TYPE tt_bapi1003_alloc_values_curr,
    ls_btchval    TYPE lsty_btch_val.
  FIELD-SYMBOLS:
    <ls_stock_mon> TYPE /scwm/s_stock_mon,
    <val_char>     TYPE bapi1003_alloc_values_char.
* 1 clear buffers
  /scwm/cl_batch_appl=>cleanup( ).
* 2 check for REFRESH-Mode
  IF iv_mode NE 4.
    CLEAR gt_btchval.
  ENDIF.
  LOOP AT it_stock_mon ASSIGNING <ls_stock_mon>.
    ls_whbatch-lgnum = <ls_stock_mon>-lgnum.
    ls_whbatch-batchid = <ls_stock_mon>-batchid.
    ls_whbatch-matid = <ls_stock_mon>-matid.
    APPEND ls_whbatch TO lt_whbatch.
  ENDLOOP.
  SORT lt_whbatch BY lgnum batchid matid.
  DELETE ADJACENT DUPLICATES FROM lt_whbatch.
  LOOP AT lt_whbatch INTO ls_whbatch
  WHERE matid IS NOT INITIAL
  AND batchid IS NOT INITIAL.
    CLEAR: ls_batch, ls_btchval,
    lt_val_num, lt_val_char, lt_val_curr.
* 3 if we have the record in buffer – we use it
    IF iv_mode EQ 4.
      READ TABLE gt_btchval TRANSPORTING NO FIELDS
      WITH KEY matid = ls_whbatch-matid
      batchid = ls_whbatch-batchid
      BINARY SEARCH.
      CHECK NOT sy-subrc = 0.
    ENDIF.
* 4 get instance
    TRY.
        lo_batch_appl ?= /scwm/cl_batch_appl=>get_instance(
        iv_productid = ls_whbatch-matid
        iv_batchid = ls_whbatch-batchid
        iv_lgnum = ls_whbatch-lgnum ).
      CATCH /scwm/cx_batch_management.
        CONTINUE.
    ENDTRY.
* 5 get batch and values
    TRY.
        lo_batch_appl->get_batch(
        IMPORTING
        es_batch = ls_batch
        et_val_num = lt_val_num
        et_val_char = lt_val_char
        et_val_curr = lt_val_curr ).
      CATCH /scwm/cx_batch_management.
    ENDTRY.
*6 fill global table
    READ TABLE lt_val_char ASSIGNING <val_char>
    WITH KEY charact = gc_vbtch.
    IF sy-subrc = 0.
      ls_btchval-zz_vend_batch = <val_char>-value_char.
    ENDIF.
    MOVE-CORRESPONDING ls_batch TO ls_btchval.
    ls_btchval-zz_prod_dat = ls_batch-prod_date.
    APPEND ls_btchval TO gt_btchval.
  ENDLOOP.
ENDFORM. " BATCH_VAL
*&---------------------------------------------------*
*& Form YBTCH_MAPPING
*&---------------------------------------------------*
FORM ybtch_mapping
CHANGING ct_mapping TYPE /scwm/tt_map_selopt2field.
  DATA: ls_mapping TYPE /scwm/s_map_selopt2field.
  MOVE: '/SCWM/AQUA' TO ls_mapping-tablename,
  'P_YBTCH' TO ls_mapping-selname,
  'X_BTCH' TO ls_mapping-fieldname.
  APPEND ls_mapping TO ct_mapping.
ENDFORM. " YBTCH_MAPPING
