*> ---------------------------------------------------------------
*> Exemple 2.4 : EVALUATE (le "switch/case" de COBOL)
*> ---------------------------------------------------------------
IDENTIFICATION DIVISION.
PROGRAM-ID. EVAL01.

DATA DIVISION.
WORKING-STORAGE SECTION.
01 WS-NOTE      PIC 99      VALUE 13.
01 WS-MENTION   PIC X(12).
01 WS-JOUR      PIC 9       VALUE 6.
01 WS-OP        PIC X       VALUE "*".

PROCEDURE DIVISION.
    *> EVALUATE TRUE : chaque WHEN est une condition, la première vraie gagne
    EVALUATE TRUE
        WHEN WS-NOTE >= 16  MOVE "TRES BIEN"    TO WS-MENTION
        WHEN WS-NOTE >= 14  MOVE "BIEN"         TO WS-MENTION
        WHEN WS-NOTE >= 12  MOVE "ASSEZ BIEN"   TO WS-MENTION
        WHEN WS-NOTE >= 10  MOVE "PASSABLE"     TO WS-MENTION
        WHEN OTHER          MOVE "INSUFFISANT"  TO WS-MENTION
    END-EVALUATE
    DISPLAY "Note " WS-NOTE " -> " WS-MENTION

    *> EVALUATE sur une valeur : listes (WHEN empilés) et intervalles (THRU)
    EVALUATE WS-JOUR
        WHEN 1 THRU 5
            DISPLAY "Jour ouvre"
        WHEN 6
        WHEN 7
            DISPLAY "Week-end"
        WHEN OTHER
            DISPLAY "Numero de jour invalide"
    END-EVALUATE

    EVALUATE WS-OP
        WHEN "+"  DISPLAY "Addition"
        WHEN "-"  DISPLAY "Soustraction"
        WHEN "*"  DISPLAY "Multiplication"
        WHEN "/"  DISPLAY "Division"
        WHEN OTHER DISPLAY "Operateur inconnu"
    END-EVALUATE
    STOP RUN.
