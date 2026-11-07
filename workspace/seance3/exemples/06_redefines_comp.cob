*> ---------------------------------------------------------------
*> Exemple 3.6 : REDEFINES, et formats de stockage DISPLAY / COMP / COMP-3
*> Un même nombre à 9 chiffres occupe 9, 4 ou 5 octets selon l'USAGE.
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. REDEF01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-DATE-NUM      PIC 9(8)  VALUE 20261107.
01 WS-DATE-DECOUPEE REDEFINES WS-DATE-NUM.
   05 WS-AN         PIC 9(4).
   05 WS-MOIS       PIC 99.
   05 WS-JOUR       PIC 99.

01 WS-DISPLAY-NUM   PIC 9(9)  VALUE 123456789.
01 WS-BINAIRE       PIC 9(9)  COMP    VALUE 123456789.
01 WS-PACKE         PIC 9(9)  COMP-3  VALUE 123456789.

PROCEDURE DIVISION.
    DISPLAY "Date          : " WS-DATE-NUM
    DISPLAY "  annee       : " WS-AN
    DISPLAY "  mois        : " WS-MOIS
    DISPLAY "  jour        : " WS-JOUR
    DISPLAY " "
    DISPLAY "USAGE DISPLAY : " FUNCTION LENGTH(WS-DISPLAY-NUM) " octets"
    DISPLAY "USAGE COMP    : " FUNCTION LENGTH(WS-BINAIRE) " octets"
    DISPLAY "USAGE COMP-3  : " FUNCTION LENGTH(WS-PACKE) " octets"
    ADD 1 TO WS-PACKE
    DISPLAY "COMP-3 + 1    : " WS-PACKE
    STOP RUN.
