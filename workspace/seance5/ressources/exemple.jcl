//* ----------------------------------------------------------------
//* Exemple de JCL (mainframe z/OS) : compilation + exécution batch
//* (à lire : ce fichier n'est PAS exécutable dans l'environnement d'exercices)
//* ----------------------------------------------------------------
//BANQUEJ  JOB (ACCT),'TRAITEMENT COMPTES',CLASS=A,MSGCLASS=X
//*
//* Etape 1 : exécuter le programme TRAITE
//STEP010  EXEC PGM=TRAITE
//STEPLIB  DD DSN=PROD.LOADLIB,DISP=SHR
//COMPTES  DD DSN=PROD.COMPTES.VSAM,DISP=SHR
//TRANSAC  DD DSN=PROD.TRANSAC.DU.JOUR,DISP=SHR
//REJETS   DD DSN=PROD.REJETS.DU.JOUR,DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(5,5)),RECFM=FB,LRECL=80
//SYSOUT   DD SYSOUT=*
//*
//* Etape 2 : éditer le relevé seulement si l'étape 1 s'est bien terminée
//STEP020  EXEC PGM=EDITION,COND=(4,LT,STEP010)
//STEPLIB  DD DSN=PROD.LOADLIB,DISP=SHR
//COMPTES  DD DSN=PROD.COMPTES.VSAM,DISP=SHR
//RELEVE   DD SYSOUT=*
