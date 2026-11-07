*> ---------------------------------------------------------------
*> Exemple 1.3 : les principaux types de PICTURE
*>   9  = chiffre      X = caractère quelconque      A = lettre
*>   S  = signe        V = virgule décimale implicite
*>   Z, . = éditions (affichage formaté)
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. TYPESPIC.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-ENTIER    PIC 9(4)      VALUE 42.
01 WS-SIGNE     PIC S9(4)     VALUE -42.
01 WS-DECIMAL   PIC 9(3)V99   VALUE 123.45.
01 WS-TEXTE     PIC X(10)     VALUE "COBOL".
01 WS-ALPHA     PIC A(5)      VALUE "ABC".
01 WS-EDITE     PIC ZZZ9.99.

PROCEDURE DIVISION.
    MOVE WS-DECIMAL TO WS-EDITE
    DISPLAY "Entier   : [" WS-ENTIER "]"
    DISPLAY "Signe    : [" WS-SIGNE "]"
    DISPLAY "Decimal  : [" WS-DECIMAL "]"
    DISPLAY "Texte    : [" WS-TEXTE "]"
    DISPLAY "Alpha    : [" WS-ALPHA "]"
    DISPLAY "Edite    : [" WS-EDITE "]"
    DISPLAY "Taille de WS-DECIMAL : " FUNCTION LENGTH(WS-DECIMAL) " octets"
    STOP RUN.
