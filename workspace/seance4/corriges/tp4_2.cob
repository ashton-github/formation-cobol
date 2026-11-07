*> Corrigé TP4.2 : gestion de clients (fichier indexé, menu)
IDENTIFICATION DIVISION.
PROGRAM-ID. TP42.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-CLI ASSIGN TO "seance4/out/clients.idx"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CI-ID
        FILE STATUS IS WS-FS.

DATA DIVISION.
FILE SECTION.
FD F-CLI.
01 ENR-CLI.
   05 CI-ID         PIC 9(5).
   05 CI-NOM        PIC X(15).
   05 CI-PRENOM     PIC X(12).
   05 CI-VILLE      PIC X(12).
   05 CI-SOLDE      PIC 9(7)V99.

WORKING-STORAGE SECTION.
01 WS-FS            PIC XX.
   88 FS-OK                VALUE "00".
   88 FS-FIN               VALUE "10".
   88 FS-ABSENT            VALUE "35".
01 WS-CHOIX         PIC 9.
01 WS-FIN           PIC X VALUE "N".
   88 FIN-OUI              VALUE "O".
01 WS-SAISIE        PIC X(30).
01 WS-ID            PIC 9(5).
01 WS-MONTANT       PIC 9(7)V99.
01 WS-OPERATION     PIC X.
01 WS-ED-SOLDE      PIC Z,ZZZ,ZZ9.99.

PROCEDURE DIVISION.
0000-PRINCIPAL.
    PERFORM 1000-OUVERTURE
    PERFORM 2000-MENU UNTIL FIN-OUI
    CLOSE F-CLI
    DISPLAY "Au revoir"
    STOP RUN.

1000-OUVERTURE.
    OPEN I-O F-CLI
    IF FS-ABSENT
        DISPLAY "Fichier absent : creation d'un fichier vide"
        OPEN OUTPUT F-CLI
        CLOSE F-CLI
        OPEN I-O F-CLI
    END-IF
    IF NOT FS-OK
        DISPLAY "Erreur d'ouverture, statut " WS-FS
        STOP RUN
    END-IF.

2000-MENU.
    DISPLAY " "
    DISPLAY "1. Consulter   2. Ajouter   3. Crediter/debiter"
    DISPLAY "4. Supprimer   5. Lister    0. Quitter"
    DISPLAY "Choix ? " WITH NO ADVANCING
    ACCEPT WS-CHOIX
    EVALUATE WS-CHOIX
        WHEN 1  PERFORM 2100-CONSULTER
        WHEN 2  PERFORM 2200-AJOUTER
        WHEN 3  PERFORM 2300-MOUVEMENT
        WHEN 4  PERFORM 2400-SUPPRIMER
        WHEN 5  PERFORM 2500-LISTER
        WHEN 0  SET FIN-OUI TO TRUE
        WHEN OTHER DISPLAY "Choix invalide"
    END-EVALUATE.

2100-CONSULTER.
    PERFORM 8000-DEMANDER-ID
    READ F-CLI
        INVALID KEY
            DISPLAY "Client " WS-ID " inconnu"
        NOT INVALID KEY
            PERFORM 8100-AFFICHER-CLIENT
    END-READ.

2200-AJOUTER.
    PERFORM 8000-DEMANDER-ID
    INITIALIZE ENR-CLI
    MOVE WS-ID TO CI-ID
    DISPLAY "Nom ? " WITH NO ADVANCING
    ACCEPT CI-NOM
    DISPLAY "Prenom ? " WITH NO ADVANCING
    ACCEPT CI-PRENOM
    DISPLAY "Ville ? " WITH NO ADVANCING
    ACCEPT CI-VILLE
    MOVE 0 TO CI-SOLDE
    WRITE ENR-CLI
        INVALID KEY
            DISPLAY "Ajout refuse : le client " WS-ID " existe deja"
        NOT INVALID KEY
            DISPLAY "Client " WS-ID " ajoute"
    END-WRITE.

2300-MOUVEMENT.
    PERFORM 8000-DEMANDER-ID
    READ F-CLI
        INVALID KEY
            DISPLAY "Client " WS-ID " inconnu"
        NOT INVALID KEY
            PERFORM 2310-APPLIQUER-MOUVEMENT
    END-READ.

2310-APPLIQUER-MOUVEMENT.
    DISPLAY "Credit (C) ou debit (D) ? " WITH NO ADVANCING
    ACCEPT WS-OPERATION
    DISPLAY "Montant ? " WITH NO ADVANCING
    ACCEPT WS-SAISIE
    COMPUTE WS-MONTANT = FUNCTION NUMVAL(WS-SAISIE)
    EVALUATE WS-OPERATION
        WHEN "C"
        WHEN "c"
            ADD WS-MONTANT TO CI-SOLDE
                ON SIZE ERROR
                    DISPLAY "Depassement de capacite, operation annulee"
                NOT ON SIZE ERROR
                    PERFORM 2320-REECRIRE
            END-ADD
        WHEN "D"
        WHEN "d"
            IF WS-MONTANT > CI-SOLDE
                DISPLAY "Debit refuse : solde insuffisant"
            ELSE
                SUBTRACT WS-MONTANT FROM CI-SOLDE
                PERFORM 2320-REECRIRE
            END-IF
        WHEN OTHER
            DISPLAY "Operation inconnue"
    END-EVALUATE.

2320-REECRIRE.
    REWRITE ENR-CLI
        INVALID KEY
            DISPLAY "Erreur de reecriture (statut " WS-FS ")"
        NOT INVALID KEY
            MOVE CI-SOLDE TO WS-ED-SOLDE
            DISPLAY "Nouveau solde : " WS-ED-SOLDE
    END-REWRITE.

2400-SUPPRIMER.
    PERFORM 8000-DEMANDER-ID
    DELETE F-CLI RECORD
        INVALID KEY
            DISPLAY "Client " WS-ID " inconnu"
        NOT INVALID KEY
            DISPLAY "Client " WS-ID " supprime"
    END-DELETE.

2500-LISTER.
    MOVE 0 TO CI-ID
    START F-CLI KEY IS NOT LESS THAN CI-ID
        INVALID KEY
            DISPLAY "Fichier vide"
        NOT INVALID KEY
            PERFORM UNTIL FS-FIN
                READ F-CLI NEXT RECORD
                    AT END CONTINUE
                    NOT AT END PERFORM 8100-AFFICHER-CLIENT
                END-READ
            END-PERFORM
    END-START.

8000-DEMANDER-ID.
    DISPLAY "Numero de client ? " WITH NO ADVANCING
    ACCEPT WS-SAISIE
    COMPUTE WS-ID = FUNCTION NUMVAL(WS-SAISIE)
    MOVE WS-ID TO CI-ID.

8100-AFFICHER-CLIENT.
    MOVE CI-SOLDE TO WS-ED-SOLDE
    DISPLAY CI-ID " " CI-NOM " " CI-PRENOM " " CI-VILLE " " WS-ED-SOLDE.
