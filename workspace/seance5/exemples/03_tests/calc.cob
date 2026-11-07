*> Sous-programme testé : calculatrice à 4 opérations.
*> Codes retour : 0 = ok, 1 = division par zéro, 2 = opérateur inconnu.
IDENTIFICATION DIVISION.
PROGRAM-ID. CALC.

DATA DIVISION.
LINKAGE SECTION.
01 LK-A       PIC S9(5)V99.
01 LK-B       PIC S9(5)V99.
01 LK-OP      PIC X.
01 LK-RES     PIC S9(7)V99.
01 LK-CODE    PIC 9.

PROCEDURE DIVISION USING LK-A LK-B LK-OP LK-RES LK-CODE.
    MOVE 0 TO LK-CODE
    MOVE 0 TO LK-RES
    EVALUATE LK-OP
        WHEN "+"
            COMPUTE LK-RES = LK-A + LK-B
        WHEN "-"
            COMPUTE LK-RES = LK-A - LK-B
        WHEN "*"
            COMPUTE LK-RES = LK-A * LK-B
        WHEN "/"
            IF LK-B = 0
                MOVE 1 TO LK-CODE
            ELSE
                COMPUTE LK-RES = LK-A / LK-B
            END-IF
        WHEN OTHER
            MOVE 2 TO LK-CODE
    END-EVALUATE
    GOBACK.
