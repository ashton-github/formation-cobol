*> ---------------------------------------------------------------
*> Exemple 3.5 : traitement de chaînes
*>   UNSTRING (découper)  STRING (assembler)  INSPECT (compter/remplacer)
*>   zone(debut:longueur) = référence modifiée (sous-chaîne)
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. CHAINE01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-CSV       PIC X(30) VALUE "DUPONT,Jean,Lyon".
01 WS-NOM       PIC X(15).
01 WS-PRENOM    PIC X(15).
01 WS-VILLE     PIC X(15).
01 WS-LIGNE     PIC X(60).
01 WS-PTR       PIC 99.
01 WS-LONG      PIC 99.
01 WS-TEXTE     PIC X(30) VALUE "COBOL est un langage fiable".
01 WS-COMPTE    PIC 99.

PROCEDURE DIVISION.
    *> --- UNSTRING : découper selon un séparateur
    UNSTRING WS-CSV DELIMITED BY ","
        INTO WS-NOM WS-PRENOM WS-VILLE
    END-UNSTRING
    DISPLAY "Nom=[" FUNCTION TRIM(WS-NOM) "] Prenom=["
            FUNCTION TRIM(WS-PRENOM) "] Ville=["
            FUNCTION TRIM(WS-VILLE) "]"

    *> --- STRING : assembler (vider la cible avant !)
    MOVE SPACES TO WS-LIGNE
    MOVE 1 TO WS-PTR
    STRING FUNCTION TRIM(WS-PRENOM) DELIMITED BY SIZE
           " "                      DELIMITED BY SIZE
           FUNCTION TRIM(WS-NOM)    DELIMITED BY SIZE
           " ("                     DELIMITED BY SIZE
           FUNCTION TRIM(WS-VILLE)  DELIMITED BY SIZE
           ")"                      DELIMITED BY SIZE
        INTO WS-LIGNE WITH POINTER WS-PTR
        ON OVERFLOW DISPLAY "Debordement !"
    END-STRING
    COMPUTE WS-LONG = WS-PTR - 1
    DISPLAY "Assemble : " FUNCTION TRIM(WS-LIGNE) " (" WS-LONG " caracteres)"

    *> --- INSPECT : compter, remplacer, convertir
    MOVE 0 TO WS-COMPTE
    INSPECT WS-TEXTE TALLYING WS-COMPTE FOR ALL "a"
    DISPLAY "Nombre de 'a' : " WS-COMPTE
    INSPECT WS-TEXTE REPLACING ALL "a" BY "4"
    DISPLAY "Apres REPLACING : " WS-TEXTE
    INSPECT WS-TEXTE CONVERTING "abcdefghijklmnopqrstuvwxyz"
                             TO "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    DISPLAY "Apres CONVERTING : " WS-TEXTE

    *> --- Référence modifiée et fonctions
    DISPLAY "5 premiers car. : " WS-TEXTE(1:5)
    DISPLAY "Minuscules      : " FUNCTION LOWER-CASE(WS-TEXTE)
    DISPLAY "Inverse         : " FUNCTION REVERSE(FUNCTION TRIM(WS-TEXTE))
    DISPLAY "Longueur utile  : " FUNCTION LENGTH(FUNCTION TRIM(WS-TEXTE))
    STOP RUN.
