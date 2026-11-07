*> ---------------------------------------------------------------
*> Exemple 2.3 : IF, tests de classe, conditions nommées (niveau 88)
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. COND01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-NOTE        PIC 99V9.
01 WS-CODE        PIC X(3).
01 WS-STATUT      PIC X.
   88 STATUT-ACTIF     VALUE "A".
   88 STATUT-SUSPENDU  VALUE "S".
   88 STATUT-VALIDE    VALUE "A" "S" "R".

PROCEDURE DIVISION.
    MOVE 14.5 TO WS-NOTE
    IF WS-NOTE >= 10
        DISPLAY "Note " WS-NOTE " : admis"
    ELSE
        DISPLAY "Note " WS-NOTE " : refuse"
    END-IF

    IF WS-NOTE >= 12 AND WS-NOTE < 16
        DISPLAY "Mention assez bien / bien"
    END-IF

    IF NOT (WS-NOTE < 10 OR WS-NOTE > 20)
        DISPLAY "Note dans l'intervalle 10..20"
    END-IF

    MOVE "123" TO WS-CODE
    IF WS-CODE IS NUMERIC
        DISPLAY "Code " WS-CODE " : numerique"
    END-IF
    MOVE "AB" TO WS-CODE
    IF WS-CODE IS ALPHABETIC
        DISPLAY "Code [" WS-CODE "] : alphabetique"
    END-IF
    MOVE "A1B" TO WS-CODE
    IF WS-CODE IS NOT NUMERIC AND WS-CODE IS NOT ALPHABETIC
        DISPLAY "Code " WS-CODE " : melange"
    END-IF

    MOVE "S" TO WS-STATUT
    IF STATUT-SUSPENDU
        DISPLAY "Compte suspendu"
    END-IF
    SET STATUT-ACTIF TO TRUE
    DISPLAY "Apres SET : statut = " WS-STATUT
    MOVE "Z" TO WS-STATUT
    IF NOT STATUT-VALIDE
        DISPLAY "Statut " WS-STATUT " invalide"
    END-IF
    STOP RUN.
