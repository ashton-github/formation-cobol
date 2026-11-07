*> ---------------------------------------------------------------
*> Exemple 2.2 : zones ÉDITÉES, format français (virgule décimale)
*>   Z = chiffre ou espace (suppression des zéros non significatifs)
*>   9 = chiffre toujours affiché      * = protection par astérisques
*>   . = séparateur de milliers (avec DECIMAL-POINT IS COMMA)
*>   , = séparateur décimal             - / CR = signe
*> Remarque : avec DECIMAL-POINT IS COMMA, les littéraux s'écrivent 1234,50
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. EDIT01.

ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
SPECIAL-NAMES.
    DECIMAL-POINT IS COMMA.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-NEGATIF   PIC S9(7)V99  VALUE -1234567,89.
01 WS-POSITIF   PIC 9(7)V99   VALUE 1234,50.
01 WS-ZERO      PIC 9(7)V99   VALUE 0.
01 WS-DATE      PIC 9(8)      VALUE 14071990.
01 WS-ED-Z      PIC Z.ZZZ.ZZ9,99.
01 WS-ED-SIGNE  PIC Z.ZZZ.ZZ9,99-.
01 WS-ED-CR     PIC Z.ZZZ.ZZ9,99CR.
01 WS-ED-ETOILE PIC *.***.**9,99.
01 WS-ED-DATE   PIC 99/99/9999.
01 WS-ED-BLANC  PIC Z.ZZZ.ZZ9,99 BLANK WHEN ZERO.

PROCEDURE DIVISION.
    MOVE WS-POSITIF TO WS-ED-Z
    DISPLAY "Zero supprimes      : [" WS-ED-Z "]"

    MOVE WS-NEGATIF TO WS-ED-Z
    DISPLAY "Negatif sans signe  : [" WS-ED-Z "]  (le signe est perdu)"

    MOVE WS-NEGATIF TO WS-ED-SIGNE
    DISPLAY "Signe a droite      : [" WS-ED-SIGNE "]"

    MOVE WS-NEGATIF TO WS-ED-CR
    DISPLAY "Credit/Debit (CR)   : [" WS-ED-CR "]"

    MOVE WS-POSITIF TO WS-ED-ETOILE
    DISPLAY "Protege (cheque)    : [" WS-ED-ETOILE "]"

    MOVE WS-DATE TO WS-ED-DATE
    DISPLAY "Date                : [" WS-ED-DATE "]"

    MOVE WS-ZERO TO WS-ED-BLANC
    DISPLAY "Zero -> blancs      : [" WS-ED-BLANC "]"
    STOP RUN.
