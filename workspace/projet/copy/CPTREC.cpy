*> Copybook CPTREC : enregistrement COMPTE (31 caractères)
*> Fichier indexé out/comptes.idx, clé = CPT-NUM
01 CPT-REC.
   05 CPT-NUM      PIC 9(6).
   05 CPT-NOM      PIC X(15).
   05 CPT-TYPE     PIC X.
      88 CPT-COURANT    VALUE "C".
      88 CPT-EPARGNE    VALUE "E".
      88 CPT-TYPE-OK    VALUE "C" "E".
   05 CPT-SOLDE    PIC 9(7)V99.
