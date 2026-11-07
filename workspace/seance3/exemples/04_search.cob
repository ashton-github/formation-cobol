*> ---------------------------------------------------------------
*> Exemple 3.4 : recherche dans une table
*>   SEARCH      = parcours séquentiel (table quelconque)
*>   SEARCH ALL  = dichotomie (table TRIÉE sur la clé, ASCENDING KEY)
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. SEARCH01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-TABLE-PAYS.
   05 WS-PAYS OCCURS 5 TIMES
         ASCENDING KEY IS WS-CODE
         INDEXED BY IDX-P.
      10 WS-CODE     PIC X(2).
      10 WS-NOM      PIC X(12).
01 WS-CHERCHE        PIC X(2).

PROCEDURE DIVISION.
    MOVE "BE" TO WS-CODE(1)   MOVE "Belgique"  TO WS-NOM(1)
    MOVE "CH" TO WS-CODE(2)   MOVE "Suisse"    TO WS-NOM(2)
    MOVE "DE" TO WS-CODE(3)   MOVE "Allemagne" TO WS-NOM(3)
    MOVE "ES" TO WS-CODE(4)   MOVE "Espagne"   TO WS-NOM(4)
    MOVE "FR" TO WS-CODE(5)   MOVE "France"    TO WS-NOM(5)

    MOVE "DE" TO WS-CHERCHE
    PERFORM 1000-RECHERCHER
    MOVE "XX" TO WS-CHERCHE
    PERFORM 1000-RECHERCHER
    STOP RUN.

1000-RECHERCHER.
    SET IDX-P TO 1
    SEARCH WS-PAYS
        AT END
            DISPLAY WS-CHERCHE " : inconnu (SEARCH)"
        WHEN WS-CODE(IDX-P) = WS-CHERCHE
            DISPLAY WS-CHERCHE " : " WS-NOM(IDX-P) " (SEARCH)"
    END-SEARCH

    SEARCH ALL WS-PAYS
        AT END
            DISPLAY WS-CHERCHE " : inconnu (SEARCH ALL)"
        WHEN WS-CODE(IDX-P) = WS-CHERCHE
            DISPLAY WS-CHERCHE " : " WS-NOM(IDX-P) " (SEARCH ALL)"
    END-SEARCH.
