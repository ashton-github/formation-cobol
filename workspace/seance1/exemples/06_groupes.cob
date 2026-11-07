*> ---------------------------------------------------------------
*> Exemple 1.6 : niveaux (01, 05, 10), groupes et INITIALIZE
*> Un GROUPE n'a pas de PIC : c'est la concaténation de ses éléments.
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. GROUPES.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-EMPLOYE.
   05 WS-MATRICULE   PIC 9(5)     VALUE 10234.
   05 WS-IDENTITE.
      10 WS-NOM      PIC X(15)    VALUE "MARTIN".
      10 WS-PRENOM   PIC X(12)    VALUE "Sophie".
   05 WS-SALAIRE     PIC 9(5)V99  VALUE 3250.50.
01 WS-LIGNE          PIC X(40)    VALUE ALL "-".

PROCEDURE DIVISION.
    DISPLAY WS-LIGNE
    DISPLAY "Enregistrement complet : " WS-EMPLOYE
    DISPLAY "Identite seule         : " WS-IDENTITE
    DISPLAY "Nom seul               : " WS-NOM
    DISPLAY "Longueur du groupe     : " FUNCTION LENGTH(WS-EMPLOYE) " octets"
    INITIALIZE WS-EMPLOYE
    DISPLAY "Apres INITIALIZE       : " WS-EMPLOYE
    MOVE "DURAND" TO WS-NOM
    MOVE ZEROS TO WS-SALAIRE
    DISPLAY "Apres MOVE             : " WS-EMPLOYE
    DISPLAY WS-LIGNE
    STOP RUN.
