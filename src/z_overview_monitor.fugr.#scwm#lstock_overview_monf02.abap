*----------------------------------------------------------------------*
***INCLUDE /SCWM/LSTOCK_OVERVIEW_MONF02 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  lagp_mapping
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM lagp_mapping
         CHANGING
           ct_mapping TYPE /scwm/tt_map_selopt2field.

  DATA: ls_mapping  TYPE /scwm/s_map_selopt2field.

  MOVE: '/SCWM/LAGP'      TO ls_mapping-tablename,
        'S_LGPLA'         TO ls_mapping-selname,
        'LGPLA'           TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  CLEAR ls_mapping-is_key.
  MOVE: 'S_LGTYP'         TO ls_mapping-selname,
        'LGTYP'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_LGBER'         TO ls_mapping-selname,
        'LGBER'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_LPTYP'         TO ls_mapping-selname,
        'LPTYP'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_KZLER'         TO ls_mapping-selname,
        'KZLER'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_AISLE'         TO ls_mapping-selname,
        'AISLE'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_STACK'         TO ls_mapping-selname,
        'STACK'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_LEVEL'         TO ls_mapping-selname,
        'LVL_V'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_BINSC'         TO ls_mapping-selname,
        'BINSC'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_DEPTH'         TO ls_mapping-selname,
        'DEPTH'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: 'S_PSA'           TO ls_mapping-selname,
        'PSA'             TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: '/SCWM/RSRC'      TO ls_mapping-tablename,
        'S_RSRC'          TO ls_mapping-selname,
        'RSRC'            TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: '/SCWM/TUNIT'     TO ls_mapping-tablename,
        'S_TUEXT'         TO ls_mapping-selname,
        'TU_NUM_EXT'      TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: '/SCWM/TUNIT'     TO ls_mapping-tablename,
        'S_TSP'           TO ls_mapping-selname,
        'TSP'             TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.

ENDFORM.                    " lagp_mapping


*&---------------------------------------------------------------------*
*&      Form  aqua_mapping
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM aqua_mapping
         CHANGING ct_mapping TYPE /scwm/tt_map_selopt2field.

  DATA: ls_mapping TYPE /scwm/s_map_selopt2field.

  CLEAR ls_mapping-is_key.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'S_MATID'         TO ls_mapping-selname,
        'MATID'           TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  CLEAR ls_mapping-is_key.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'S_MATNR'         TO ls_mapping-selname,
        'MATNR'           TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  CLEAR ls_mapping-is_key.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'S_ENTIT'         TO ls_mapping-selname,
        'ENTITLED'        TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  CLEAR ls_mapping-is_key.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'S_OWNER'         TO ls_mapping-selname,
        'OWNER'           TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  CLEAR ls_mapping-is_key.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'S_STCAT'         TO ls_mapping-selname,
        'CAT'             TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  CLEAR ls_mapping-is_key.
  MOVE: '/SCWM/QUAN'      TO ls_mapping-tablename,
        'S_STOID'         TO ls_mapping-selname,
        'STOID'           TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.
  CLEAR ls_mapping-is_key.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'S_BATCH'         TO ls_mapping-selname,
        'CHARG'           TO ls_mapping-fieldname,
        'X'               TO ls_mapping-is_key.
  APPEND ls_mapping       TO ct_mapping.

ENDFORM.                    " aqua_mapping


*&---------------------------------------------------------------------*
*&      Form  huident_mapping
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM huident_mapping
         CHANGING ct_mapping TYPE /scwm/tt_map_selopt2field.

  DATA: ls_mapping TYPE /scwm/s_map_selopt2field.

  MOVE: '/SCWM/AQUA'        TO ls_mapping-tablename,
        'S_HUIDEN'          TO ls_mapping-selname,
        'HUIDENT'           TO ls_mapping-fieldname,
        'X'                 TO ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'S_HUTYP'           TO ls_mapping-selname,
        'LETYP'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'S_P_MAT'           TO ls_mapping-selname,
        'PMAT_GUID'         TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'S_PMTYP'           TO ls_mapping-selname,
        'PMTYP'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/SERH'        TO ls_mapping-tablename,
        'S_SERID'           TO ls_mapping-selname,
        'LSERID'            TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/SERI'        TO ls_mapping-tablename,
        'S_UII'             TO ls_mapping-selname,
        'UII'               TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'P_SSTAT'           TO ls_mapping-selname,
        'SYSTEM_STATUS'     TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'P_USTAT'           TO ls_mapping-selname,
        'USER_STATUS'       TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'P_EMPTY'           TO ls_mapping-selname,
        'EMPTY'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'S_IDART'           TO ls_mapping-selname,
        'IDART'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/HUHDR'       TO ls_mapping-tablename,
        'S_IDENT'           TO ls_mapping-selname,
        'IDENT'             TO ls_mapping-fieldname.
  APPEND ls_mapping         TO ct_mapping.
  CLEAR ls_mapping-is_key.

ENDFORM.                    " huident_mapping


*&---------------------------------------------------------------------*
*&      Form  bin_ind_mapping
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
*----------------------------------------------------------------------*
FORM bin_ind_mapping
         CHANGING ct_mapping TYPE /scwm/tt_map_selopt2field.

  DATA: ls_mapping TYPE /scwm/s_map_selopt2field.

  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'P_LGPLA'         TO ls_mapping-selname,
        'X_BIN'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'P_RSRC'          TO ls_mapping-selname,
        'X_RESOURCE'      TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'P_TU'            TO ls_mapping-selname,
        'X_TU'            TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'P_DIFF'          TO ls_mapping-selname,
        'X_DIFF'          TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.
  MOVE: '/SCWM/AQUA'      TO ls_mapping-tablename,
        'P_LGNM'          TO ls_mapping-selname,
        'LGNUM'           TO ls_mapping-fieldname.
  APPEND ls_mapping       TO ct_mapping.

ENDFORM.                    " bin_ind_mapping
*&---------------------------------------------------------------------*
*& Form pas_mapping
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pas_mapping
  CHANGING ct_mapping TYPE /scwm/tt_map_selopt2field.

  DATA: ls_mapping TYPE /scwm/s_map_selopt2field.

  MOVE: '/SCWM/PRALLSTCK'        TO ls_mapping-tablename,
        'S_MATNR'          TO ls_mapping-selname,
        'MATID'           TO ls_mapping-fieldname,
        'X'                 TO ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/PRALLSTCK'       TO ls_mapping-tablename,
        'S_OWNER'           TO ls_mapping-selname,
        'OWNER'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/PRALLSTCK'       TO ls_mapping-tablename,
        'S_ENTIT'           TO ls_mapping-selname,
        'ENTITLED'         TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/PRALLSTCK'       TO ls_mapping-tablename,
        'S_BATCH'           TO ls_mapping-selname,
        'CHARG'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/PRALLSTCK'       TO ls_mapping-tablename,
        'S_LGPLA'           TO ls_mapping-selname,
        'LGPLA'         TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/PRALLSTCK'       TO ls_mapping-tablename,
        'S_DOCCAT'           TO ls_mapping-selname,
        'REF_DOCCAT'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/PRALLSTCK'       TO ls_mapping-tablename,
        'S_DOCNO'           TO ls_mapping-selname,
        'REF_DOCNO'         TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.
  MOVE: '/SCWM/PRALLSTCK'       TO ls_mapping-tablename,
        'S_ITMNO'           TO ls_mapping-selname,
        'REF_ITMNO'             TO ls_mapping-fieldname.
  CLEAR ls_mapping-is_key.
  APPEND ls_mapping         TO ct_mapping.

ENDFORM.
