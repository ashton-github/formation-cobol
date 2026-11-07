*> ---------------------------------------------------------------
*> Exemple 3.2 : initialiser une table avec des valeurs (REDEFINES)
*> Technique classique : FILLER avec VALUE + REDEFINES en table.
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. TABLE02.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-MOIS-DATA.
   05 FILLER PIC X(9) VALUE "JANVIER  ".
   05 FILLER PIC X(9) VALUE "FEVRIER  ".
   05 FILLER PIC X(9) VALUE "MARS     ".
   05 FILLER PIC X(9) VALUE "AVRIL    ".
   05 FILLER PIC X(9) VALUE "MAI      ".
   05 FILLER PIC X(9) VALUE "JUIN     ".
   05 FILLER PIC X(9) VALUE "JUILLET  ".
   05 FILLER PIC X(9) VALUE "AOUT     ".
   05 FILLER PIC X(9) VALUE "SEPTEMBRE".
   05 FILLER PIC X(9) VALUE "OCTOBRE  ".
   05 FILLER PIC X(9) VALUE "NOVEMBRE ".
   05 FILLER PIC X(9) VALUE "DECEMBRE ".
01 WS-MOIS-TAB REDEFINES WS-MOIS-DATA.
   05 WS-MOIS     PIC X(9) OCCURS 12 TIMES.

01 WS-NUM-MOIS    PIC 99.

PROCEDURE DIVISION.
    DISPLAY "Numero de mois (1-12) ? " WITH NO ADVANCING
    ACCEPT WS-NUM-MOIS
    IF WS-NUM-MOIS >= 1 AND WS-NUM-MOIS <= 12
        DISPLAY "Mois : " FUNCTION TRIM(WS-MOIS(WS-NUM-MOIS))
    ELSE
        DISPLAY "Numero invalide"
    END-IF
    STOP RUN.
