*&---------------------------------------------------------------------*
*& Report ZAOZDEMIR_P_ABAP_750
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAOZDEMIR_P_ABAP_750.

TYPES :BEGIN OF ty_first,
         werks  TYPE werks_d,
         arbpl  TYPE arbpl,
         toplam TYPE menge_d,
         meins  TYPE meins,
         islem  TYPE int8,
       END OF ty_first.

TYPES : tt_first TYPE TABLE OF ty_first WITH EMPTY KEY.

DATA : lt_first_v2 TYPE tt_first,
       lt_first_v3 TYPE tt_first.

DATA(lt_first) = VALUE tt_first(
                       ( werks = '2013' arbpl = '07' toplam = '16'   meins = '' )
                       ( werks = '2013' arbpl = '07' toplam = '32'   meins = '' )
                       ( werks = '2015' arbpl = '09' toplam = '07'   meins = '' ) ).

lt_first_v2 = VALUE #( FOR GROUPS ls_member OF <ls_first> IN lt_first
                                                       GROUP BY ( werks = <ls_first>-werks
                                                                  arbpl = <ls_first>-arbpl )
                         ( VALUE #( arbpl  = ls_member-arbpl
                                    werks  = ls_member-werks
                                    toplam = REDUCE netwr( INIT val TYPE menge_d
                                                           FOR ls_first IN GROUP ls_member
                                                           NEXT val = val + ls_first-toplam ) ) ) ) .

lt_first_v3 = VALUE tt_first( FOR ls_first IN lt_first_v2 LET lv_meins = 'ADT'
                                                              lv_number_v1 = 5
                                                              lv_number_v2 = 3 IN ( meins  = lv_meins
                                                                                    werks  = ls_first-werks
                                                                                    arbpl  = ls_first-arbpl
                                                                                    toplam = ls_first-toplam
                                                                                    islem  = lv_number_v1 * lv_number_v2  ) ).
