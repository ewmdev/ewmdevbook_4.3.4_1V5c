FUNCTION z_ewm_avlstock_no_bins_mon.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_LGNUM) TYPE  /SCWM/LGNUM
*"     REFERENCE(IV_VARIANT) TYPE  VARIANT OPTIONAL
*"     REFERENCE(IV_MODE) TYPE  /SCWM/DE_MON_FM_MODE DEFAULT '1'
*"  EXPORTING
*"     REFERENCE(ET_DATA) TYPE  /SCWM/TT_AQUA_ALL_MON
*"     REFERENCE(EV_RETURNCODE) TYPE  XFELD
*"     REFERENCE(EV_VARIANT) TYPE  VARIANT
*"  CHANGING
*"     REFERENCE(CT_TAB_RANGE) TYPE  RSDS_TRANGE OPTIONAL
*"  RAISING
*"      /SCWM/CX_MON_NOEXEC
*"----------------------------------------------------------------------

  DATA:
    lv_repid   TYPE sy-repid,
    lt_mapping TYPE /scwm/tt_map_selopt2field.

  lv_repid = sy-repid.
  CLEAR gt_tabname.
* 1 Only display popup and exit
  IF iv_mode = '3'.
    CALL FUNCTION 'RS_VARIANT_CATALOG'
      EXPORTING
        report               = lv_repid
        dynnr                = '0100'
      IMPORTING
        sel_variant          = ev_variant
      EXCEPTIONS
        no_report            = 1
        report_not_existent  = 2
        report_not_supplied  = 3
        no_variants          = 4
        no_variant_selected  = 5
        variant_not_existent = 6
        OTHERS               = 7.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    RETURN.
  ENDIF.
* 2 Initialization (clear screen elements)
  PERFORM initialization
    USING
      iv_lgnum
      lv_repid
    CHANGING
      et_data.
* 3 Fill mapping table
  PERFORM aqua_mapping    CHANGING lt_mapping.
  PERFORM bin_ind_mapping CHANGING lt_mapping.
  PERFORM ybtch_mapping   CHANGING lt_mapping.
  IF iv_variant IS NOT INITIAL.
* 4 Use selection criteria
    CALL FUNCTION 'RS_SUPPORT_SELECTIONS'
      EXPORTING
        report               = lv_repid
        variant              = iv_variant
      EXCEPTIONS
        variant_not_existent = 1
        variant_obsolete     = 2
        OTHERS               = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.
  IF lines( ct_tab_range ) > 0.
    CALL FUNCTION '/SCWM/RANGETAB2SELOPT'
      EXPORTING
        iv_repid     = lv_repid
        it_mapping   = lt_mapping
      CHANGING
        ct_tab_range = ct_tab_range.
  ELSEIF iv_variant IS INITIAL.
    p_rsrc  = 'X'.
    p_tu    = 'X'.
    p_ybtch = 'X'.
  ENDIF.
  IF iv_mode = '1'.
* 6 Show selection screen
    p_lgnum = iv_lgnum.
    CALL SELECTION-SCREEN '0100' STARTING AT 10 10
    ENDING AT 130 30.
    IF sy-subrc <> 0.
      ev_returncode = 'X'.
      RETURN.
    ENDIF.
  ENDIF.
* Prepare WHERECLAUSE
  CLEAR gt_tabname.
  PERFORM aqua_alias.
* Convert free select-options to where clause
  CALL FUNCTION '/SCWM/SFREE2WHERE4MON'
    EXPORTING
      it_tabname     = gt_tabname
      it_selopt      = s_free[]
    IMPORTING
      et_whereclause = gt_whereclause.
* Export selection criteria
  CALL FUNCTION '/SCWM/SELOPT2RANGETAB'
    EXPORTING
      iv_repid     = lv_repid
      it_mapping   = lt_mapping
    IMPORTING
      et_tab_range = ct_tab_range.
* 7. Select the data according to selection criteria
* 8. convert ui fields
  CALL METHOD go_mon_stock->get_available_stock
    EXPORTING
      iv_skip_bin      = p_lgpla
      iv_skip_resource = p_rsrc
      iv_skip_tu       = p_tu
      it_matnr_r       = s_matnr[]
      it_cat_r         = s_stcat[]
      it_owner_r       = s_owner[]
      it_entitled_r    = s_entit[]
      it_charg_r       = s_batch[]
      it_whereclause   = gt_whereclause
    IMPORTING
      et_stock_mon     = DATA(lt_stock_mon)
      ev_error         = ev_returncode.
* Fill extensions (Y36D)
  CHECK NOT lt_stock_mon IS INITIAL.
  IF p_ybtch IS INITIAL.
    PERFORM batch_val USING lt_stock_mon iv_mode.
    SORT gt_btchval BY matid batchid.
  ENDIF.
* Fill exporting table
  LOOP AT lt_stock_mon ASSIGNING FIELD-SYMBOL(<fs_stock_mon>).
    DATA(ls_data) = CORRESPONDING /scwm/s_aqua_all_mon(
                      <fs_stock_mon> MAPPING
                      unit        = meins
                      cat_txt     = cat_text
                      doccat      = stref_doccat
                      stock_docno = stock_docno_ext ).
    READ TABLE gt_btchval ASSIGNING FIELD-SYMBOL(<fs_batch>)
      WITH KEY matid   = <fs_stock_mon>-matid
               batchid = <fs_stock_mon>-batchid
      BINARY SEARCH.
    IF sy-subrc EQ 0.
      ls_data = CORRESPONDING #( BASE ( ls_data ) <fs_batch> ).
    ELSE.
      CLEAR: ls_data-zz_prod_dat, ls_data-zz_vend_batch.
    ENDIF.
    APPEND ls_data TO et_data.
  ENDLOOP.
ENDFUNCTION.
