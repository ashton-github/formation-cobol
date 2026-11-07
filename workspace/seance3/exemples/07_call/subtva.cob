*> Sous-programme : calcule TVA et TTC.
*> Les paramètres sont passés PAR REFERENCE : le sous-programme
*> modifie directement les zones de l'appelant.
IDENTIFICATION DIVISION.
PROGRAM-ID. SUBTVA.

DATA DIVISION.
LINKAGE SECTION.
01 LK-HT      PIC 9(5)V99.
01 LK-TAUX    PIC 99V99.
01 LK-TVA     PIC 9(5)V99.
01 LK-TTC     PIC 9(6)V99.

PROCEDURE DIVISION USING LK-HT LK-TAUX LK-TVA LK-TTC.
    COMPUTE LK-TVA ROUNDED = LK-HT * LK-TAUX / 100
    COMPUTE LK-TTC = LK-HT + LK-TVA
    GOBACK.
