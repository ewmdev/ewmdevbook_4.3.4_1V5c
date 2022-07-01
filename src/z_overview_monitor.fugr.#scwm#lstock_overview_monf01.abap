*----------------------------------------------------------------------*
***INCLUDE /SCWM/LSTOCK_OVERVIEW_MONF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  initialization
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM initialization USING
                      iv_lgnum TYPE /scwm/lgnum
                      iv_repid TYPE sy-repid
                 CHANGING
                      ct_data  TYPE ANY TABLE.

  CLEAR:
    ct_data.

  CALL FUNCTION '/SCWM/DYNPRO_ELEMENTS_CLEAR'
    EXPORTING
      iv_repid       = iv_repid
      iv_excl_s_free = 'X'.

* Object for reading stock
  IF go_mon_stock IS NOT BOUND.
    CREATE OBJECT go_mon_stock
      EXPORTING
        iv_lgnum = iv_lgnum.
  ELSE.
*   Check if warehouse number has been changed
    IF go_mon_stock->mv_lgnum <> iv_lgnum.
      CREATE OBJECT go_mon_stock
        EXPORTING
          iv_lgnum = iv_lgnum.
    ENDIF.
  ENDIF.

ENDFORM.                    " initialization


*&---------------------------------------------------------------------*
*&      Form  refresh_dynsel_caption
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM refresh_dynsel_caption .

  IF s_free[] IS INITIAL.
    CLEAR: functxt-icon_text.
  ELSE.
    MOVE: text-dyn TO functxt-icon_text.
  ENDIF.
  sscrfields-functxt_02 = functxt.
  SET PF-STATUS sy-pfkey.

ENDFORM.                    " refresh_dynsel_caption


*&---------------------------------------------------------------------*
*&      Form  adjust_captions
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM adjust_captions .

  IF /scwm/cl_wme_monitor_srvc_ce=>is_cloud_wm( ) = abap_true.
    gv_txt02 = text-019.
  ELSE.
    gv_txt02 = text-002.
  ENDIF.

ENDFORM.                    " adjust_captions


*&---------------------------------------------------------------------*
*&      Form  lagp_aqua_alias
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM lagp_aqua_alias .

  CHECK lines( gt_tabname ) = 0.

  MOVE: '/SCWM/S_LAGP_ADVSEL' TO gs_tabname-tabname,
        'LA'                  TO gs_tabname-sel_alias.
  APPEND gs_tabname           TO gt_tabname.
  MOVE: '/SCWM/S_AQUA_ADVSEL' TO gs_tabname-tabname,
        'AQ'                  TO gs_tabname-sel_alias.
  APPEND gs_tabname           TO gt_tabname.

ENDFORM.                    " lagp_aqua_alias


*&---------------------------------------------------------------------*
*&      Form  aqua_alias
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM aqua_alias .

  CHECK lines( gt_tabname ) = 0.

  MOVE: '/SCWM/S_AQUA_ADVSEL' TO gs_tabname-tabname,
        'AQ'                  TO gs_tabname-sel_alias.
  APPEND gs_tabname           TO gt_tabname.

ENDFORM.                    " aqua_alias


*&---------------------------------------------------------------------*
*&      Form  lagp_alias
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM lagp_alias .

  CHECK lines( gt_tabname ) = 0.

  MOVE: '/SCWM/S_LAGP_ADVSEL' TO gs_tabname-tabname,
        ''                    TO gs_tabname-sel_alias.
  APPEND gs_tabname           TO gt_tabname.

ENDFORM.                    " lagp_alias
*
*&---------------------------------------------------------------------*
*&      Form  1510_modify_screen
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM 1510_modify_screen .

  CHECK sy-dynnr = '1510'.

  LOOP AT SCREEN.
    IF screen-name = 'P_MATNR' OR screen-name = 'P_PUOM' OR
       screen-name = 'P_QUAN'  OR screen-name = 'P_MEINS' OR
       screen-name = 'P_MAKTX'.
      screen-input = 0.

      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

  /scwm/s_ui_mon_suom_change-quan  = p_quan.
  /scwm/s_ui_mon_suom_change-meins = p_meins.
  /scwm/s_ui_mon_suom_change-quana = p_quana.
  /scwm/s_ui_mon_suom_change-altme = p_altme.

  p_quan  = /scwm/s_ui_mon_suom_change-quan.
  p_quana = /scwm/s_ui_mon_suom_change-quana.

  SET CURSOR FIELD 'P_QUANA'.
ENDFORM.                    " 1510_modify_screen
