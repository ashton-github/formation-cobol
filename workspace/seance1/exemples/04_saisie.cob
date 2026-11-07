*> ---------------------------------------------------------------
*> Exemple 1.4 : ACCEPT (saisie) et DISPLAY (affichage)
*> "WITH NO ADVANCING" garde le curseur sur la même ligne.
*> FUNCTION TRIM retire les espaces de fin de zone.
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. SAISIE01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-PRENOM  PIC X(20).
01 WS-ANNEE   PIC 9(4).

PROCEDURE DIVISION.
    DISPLAY "Votre prenom ? " WITH NO ADVANCING
    ACCEPT WS-PRENOM
    DISPLAY "Votre annee de naissance ? " WITH NO ADVANCING
    ACCEPT WS-ANNEE
    DISPLAY "Bonjour " FUNCTION TRIM(WS-PRENOM)
            ", ne(e) en " WS-ANNEE
    STOP RUN.
