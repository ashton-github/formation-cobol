*> ---------------------------------------------------------------
*> Exemple 1.5 : les règles du MOVE
*>   Numérique : alignement sur la virgule décimale, troncature à
*>               GAUCHE (chiffres de poids fort perdus) et à droite
*>               pour les décimales.
*>   Texte     : alignement à GAUCHE, complété par des espaces,
*>               ou tronqué à DROITE.
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. MOVES01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-NUM-SRC     PIC 9(5)     VALUE 12345.
01 WS-NUM-PETIT   PIC 9(3).
01 WS-NUM-GRAND   PIC 9(7).
01 WS-DEC-SRC     PIC 9(3)V99  VALUE 123.45.
01 WS-ENT-DST     PIC 9(3).
01 WS-TXT-SRC     PIC X(10)    VALUE "BONJOUR LE".
01 WS-TXT-COURT   PIC X(5).
01 WS-TXT-LONG    PIC X(15).

PROCEDURE DIVISION.
    MOVE WS-NUM-SRC TO WS-NUM-PETIT
    MOVE WS-NUM-SRC TO WS-NUM-GRAND
    MOVE WS-DEC-SRC TO WS-ENT-DST
    MOVE WS-TXT-SRC TO WS-TXT-COURT
    MOVE WS-TXT-SRC TO WS-TXT-LONG

    DISPLAY "12345 vers 9(3)      : " WS-NUM-PETIT    *> chiffres de gauche perdus
    DISPLAY "12345 vers 9(7)      : " WS-NUM-GRAND    *> complété par des zéros
    DISPLAY "123.45 vers 9(3)     : " WS-ENT-DST      *> décimales perdues
    DISPLAY "Texte vers X(5)      : [" WS-TXT-COURT "]"
    DISPLAY "Texte vers X(15)     : [" WS-TXT-LONG "]"
    STOP RUN.
