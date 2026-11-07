*> ---------------------------------------------------------------
*> Exemple 5.2 : un bug classique (indice hors limites)
*> A essayer deux fois :
*>   cob seance5/exemples/02_bug_indice.cob       (silencieux, dangereux)
*>   cob -d seance5/exemples/02_bug_indice.cob    (erreur détectée et localisée)
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. BUGIDX.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-TAB.
   05 WS-ELT     PIC 99 OCCURS 5 TIMES.
01 WS-I         PIC 99.

PROCEDURE DIVISION.
    PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 6
        MOVE WS-I TO WS-ELT(WS-I)
        DISPLAY "Ecriture a l'indice " WS-I
    END-PERFORM
    DISPLAY "Fin normale (mais la memoire a ete corrompue !)"
    STOP RUN.
