*> Copybook TRNREC : enregistrement TRANSACTION (20 caractères)
01 TRN-REC.
   05 TRN-COMPTE   PIC 9(6).
   05 TRN-TYPE     PIC X.
      88 TRN-DEPOT      VALUE "D".
      88 TRN-RETRAIT    VALUE "R".
      88 TRN-VIREMENT   VALUE "V".
      88 TRN-TYPE-OK    VALUE "D" "R" "V".
   05 TRN-MONTANT  PIC 9(5)V99.
   05 TRN-DEST     PIC 9(6).
