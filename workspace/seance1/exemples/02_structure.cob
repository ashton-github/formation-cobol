*> ---------------------------------------------------------------
*> Exemple 1.2 : les 4 divisions d'un programme COBOL
*> Observer : un PIC 9(5)V99 ne montre PAS la virgule à l'affichage
*> (le "V" est une virgule implicite, elle n'occupe aucun octet).
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. STRUCT01.

ENVIRONMENT DIVISION.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-NOM       PIC X(20)    VALUE "Alice Martin".
01 WS-AGE       PIC 9(3)     VALUE 30.
01 WS-SALAIRE   PIC 9(5)V99  VALUE 2450.75.

PROCEDURE DIVISION.
MAIN-PARA.
    DISPLAY "Nom     : " WS-NOM
    DISPLAY "Age     : " WS-AGE
    DISPLAY "Salaire : " WS-SALAIRE
    STOP RUN.
