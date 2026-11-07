*> SQUELETTE - Programme 1 : CHARGE   (à compléter : zones TODO)
*> But : data/comptes.dat (séquentiel) -> out/comptes.idx (indexé)
*> Lancer depuis le dossier workspace/projet :  cob squelettes/charge_squelette.cob
IDENTIFICATION DIVISION.
PROGRAM-ID. CHARGE.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT F-ENTREE ASSIGN TO "data/comptes.dat"
        ORGANIZATION IS LINE SEQUENTIAL
        FILE STATUS IS WS-FS-ENT.
    SELECT F-COMPTES ASSIGN TO "out/comptes.idx"
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS CPT-NUM
        FILE STATUS IS WS-FS-CPT.

DATA DIVISION.
FILE SECTION.
FD F-ENTREE.
01 ENR-ENTREE       PIC X(31).
FD F-COMPTES.
COPY CPTREC.

WORKING-STORAGE SECTION.
01 WS-FS-ENT        PIC XX.
   88 ENT-OK               VALUE "00".
   88 ENT-FIN              VALUE "10".
01 WS-FS-CPT        PIC XX.
   88 CPT-OK               VALUE "00".
*> TODO : compteurs lus / charges / rejetes

PROCEDURE DIVISION.
0000-PRINCIPAL.
    *> TODO 1 : ouvrir F-ENTREE (INPUT) et F-COMPTES (OUTPUT), tester les statuts
    *> TODO 2 : lire le premier enregistrement
    *> TODO 3 : boucle jusqu'à la fin du fichier
    *>          - MOVE ENR-ENTREE TO CPT-REC
    *>          - valider : CPT-NUM et CPT-SOLDE numériques, CPT-TYPE-OK
    *>          - WRITE CPT-REC ... INVALID KEY (doublon) / NOT INVALID KEY
    *> TODO 4 : fermer les fichiers et afficher le résumé (lus / charges / rejetes)
    STOP RUN.
