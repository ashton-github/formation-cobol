*> ---------------------------------------------------------------
*> Exemple 3.7 : programme principal qui APPELLE un sous-programme
*> et utilise un copybook (COPY).
*> Lancer :
*>   cob seance3/exemples/07_call/maintva.cob seance3/exemples/07_call/subtva.cob
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. MAINTVA.

DATA DIVISION.
WORKING-STORAGE SECTION.
COPY CLIENT.
01 WS-HT       PIC 9(5)V99  VALUE 250.00.
01 WS-TAUX     PIC 99V99    VALUE 20.00.
01 WS-TVA      PIC 9(5)V99.
01 WS-TTC      PIC 9(6)V99.
01 WS-ED       PIC ZZZ,ZZ9.99.

PROCEDURE DIVISION.
    MOVE 42 TO CLI-ID
    MOVE "MARTIN" TO CLI-NOM
    MOVE "Lille" TO CLI-VILLE
    DISPLAY "Client : " CLIENT-REC

    CALL "SUBTVA" USING WS-HT WS-TAUX WS-TVA WS-TTC

    MOVE WS-HT  TO WS-ED
    DISPLAY "HT  : " WS-ED
    MOVE WS-TVA TO WS-ED
    DISPLAY "TVA : " WS-ED
    MOVE WS-TTC TO WS-ED
    DISPLAY "TTC : " WS-ED
    STOP RUN.
