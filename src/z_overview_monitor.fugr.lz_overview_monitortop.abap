FUNCTION-POOL z_overview_monitor.           "MESSAGE-ID ..

* INCLUDE LZ_OVERVIEW_MONITORD...            " Local class definition

"1. Global data
TYPE-POOLS: rsds, wmegc, abap, icon.
TABLES: sscrfields, /scwm/s_ui_mon_suom_change.
TYPES:
  BEGIN OF lsty_btch_val,
    matid         TYPE /scwm/de_matid,
    batchid       TYPE /scwm/de_batchid,
    zz_vend_batch TYPE /scwm/de_charg,
    zz_prod_dat   TYPE /scwm/de_bprod_date,
  END OF lsty_btch_val,
  ltty_btch_val TYPE STANDARD TABLE OF lsty_btch_val.
CONSTANTS: gc_vbtch TYPE atnam VALUE 'LOBM_LICHA',
           gc_hsdat TYPE atnam VALUE 'LOBM_HSDAT'.
DATA:
  functxt        TYPE smp_dyntxt,
  gs_tabname     TYPE /scwm/s_tabname_alias,
  gt_tabname     TYPE /scwm/tt_tabname_alias,
  gt_wherecl_tab TYPE rsds_twhere,
  gt_whereclause TYPE rsds_where_tab,
  gv_matnr_sel   TYPE /scwm/s_lagp_mon_f4-matnr,
  gv_matid_sel   TYPE /scwm/de_matid,
  gv_stcat_sel   TYPE /scwm/s_lagp_mon_f4-stcat,
  gv_entit_sel   TYPE /scwm/s_lagp_mon_f4-entitled,
  gv_owner_sel   TYPE /scwm/s_lagp_mon_f4-owner,
  gv_batch_sel   TYPE /scwm/s_lagp_mon_f4-charg,
  gv_free_sel    TYPE char255,
  go_mon_stock   TYPE REF TO /scwm/cl_mon_stock,
  gt_btchval     TYPE ltty_btch_val.
"Additional declarations S4
DATA gv_txt02.
DATA p_altme.
DATA p_quana.
DATA p_meins.
DATA p_quan.
"2. Build selection-screen 100
SELECTION-SCREEN BEGIN OF SCREEN 100 AS WINDOW.
  SELECTION-SCREEN BEGIN OF BLOCK warehouse.
    PARAMETERS:
    p_lgnum TYPE /scwm/s_lagp_mon_f4-lgnum NO-DISPLAY.
  SELECTION-SCREEN END OF BLOCK warehouse.
  SELECTION-SCREEN BEGIN OF BLOCK stock_batch WITH FRAME TITLE TEXT-001.
    SELECT-OPTIONS:
    s_matnr FOR gv_matnr_sel,
    s_stcat FOR gv_stcat_sel,
    s_owner FOR gv_owner_sel,
    s_entit FOR gv_entit_sel,
    s_batch FOR gv_batch_sel,
    s_matid FOR gv_matid_sel NO-DISPLAY.
  SELECTION-SCREEN END OF BLOCK stock_batch.
  SELECTION-SCREEN BEGIN OF BLOCK exclude
    WITH FRAME TITLE TEXT-002.
    PARAMETERS:
      p_lgpla TYPE xfeld,
      p_rsrc  TYPE xfeld,
      p_tu    TYPE xfeld,
      p_ybtch TYPE xfeld.
  SELECTION-SCREEN END OF BLOCK exclude.
  SELECTION-SCREEN BEGIN OF BLOCK free.
    SELECT-OPTIONS:
    s_free FOR gv_free_sel NO-DISPLAY.
  SELECTION-SCREEN END OF BLOCK free.
  SELECTION-SCREEN: FUNCTION KEY 1.
  SELECTION-SCREEN: FUNCTION KEY 2.
  SELECTION-SCREEN: FUNCTION KEY 3.
SELECTION-SCREEN END OF SCREEN 100.
"3. Include of standard routines
INCLUDE:
/scwm/lstock_overview_monf01,
/scwm/lstock_overview_monf02.
