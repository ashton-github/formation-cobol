*> ---------------------------------------------------------------
*> Exemple 2.6 : squelette d'un programme STRUCTURÉ (menu en boucle)
*>   0000 principal  /  1000 init  /  2000 traitement  /  3000 fin
*> Entrées pour tester : 1, 2, 5, 0
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. STRUCT02.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-CHOIX     PIC 9      VALUE 0.
01 WS-FIN       PIC X      VALUE "N".
   88 FIN-OUI              VALUE "O".
01 WS-NB-ACTIONS PIC 99    VALUE 0.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    PERFORM 1000-INITIALISATION
    PERFORM 2000-TRAITEMENT UNTIL FIN-OUI
    PERFORM 3000-TERMINAISON
    STOP RUN.

1000-INITIALISATION.
    DISPLAY "=== Debut du programme ===".

2000-TRAITEMENT.
    PERFORM 2100-AFFICHER-MENU
    ACCEPT WS-CHOIX
    EVALUATE WS-CHOIX
        WHEN 1
            PERFORM 2200-DIRE-BONJOUR
        WHEN 2
            DISPLAY "Option 2 : rien de special"
            ADD 1 TO WS-NB-ACTIONS
        WHEN 0
            SET FIN-OUI TO TRUE
        WHEN OTHER
            DISPLAY "Choix invalide"
    END-EVALUATE.

2100-AFFICHER-MENU.
    DISPLAY " "
    DISPLAY "1. Dire bonjour"
    DISPLAY "2. Autre action"
    DISPLAY "0. Quitter"
    DISPLAY "Votre choix ? " WITH NO ADVANCING.

2200-DIRE-BONJOUR.
    DISPLAY "Bonjour !"
    ADD 1 TO WS-NB-ACTIONS.

3000-TERMINAISON.
    DISPLAY "Actions realisees : " WS-NB-ACTIONS
    DISPLAY "=== Fin du programme ===".
