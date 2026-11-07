# Formation COBOL — environnement pratique (GnuCOBOL, sans Docker)

Tout ce qu'il faut pour programmer en COBOL avec **GnuCOBOL installé directement sur votre machine**.
Une seule commande, `cob`, compile et exécute vos programmes.

## 1. Contenu

```
cobol-formation/
├── scripts/            cob (Linux/macOS/WSL) · cob.cmd (Windows natif) · verifier_installation.sh
└── workspace/          <- vous travaillez ici
    ├── seance1/ … seance5/
    │   ├── exemples/   programmes commentés, un par notion
    │   ├── tp/         énoncés des TP (TPn.md)
    │   └── corriges/   corrigés (formateur)
    └── projet/         mini-projet BANQUE (énoncé, données, squelettes, solution, résultats attendus)
```

## 2. Installer GnuCOBOL (une seule fois, 5 à 10 minutes)

| Système | Procédure |
| --- | --- |
| **Windows (recommandé : WSL)** | Dans PowerShell (administrateur) : `wsl --install`, redémarrer, ouvrir « Ubuntu », puis : `sudo apt update && sudo apt install -y gnucobol` |
| Windows natif (alternative) | Installer une distribution Windows de GnuCOBOL (binaires proposés sur https://gnucobol.sourceforge.io), vérifier que `cobc` est dans le PATH |
| **macOS** | Installer Homebrew (https://brew.sh) puis `brew install gnucobol` |
| **Ubuntu / Debian** | `sudo apt update && sudo apt install -y gnucobol` |
| Fedora | `sudo dnf install gnucobol` |

Vérification : `cobc --version` affiche une version 3.x (3.1 ou plus).

Sans aucune installation (secours, séances 1 à 3 seulement) : un compilateur COBOL en ligne
(par exemple OneCompiler ou Tutorialspoint) suffit pour tester un programme sans fichiers.
Les séances 4 et 5 exigent une installation locale (fichiers).

## 3. Rendre la commande `cob` disponible

**Linux, macOS, WSL** — depuis le dossier `cobol-formation` :

```bash
chmod +x scripts/cob scripts/verifier_installation.sh
echo "export PATH=\"\$PATH:$(pwd)/scripts\"" >> ~/.bashrc     # macOS (zsh) : remplacer ~/.bashrc par ~/.zshrc
source ~/.bashrc
```

**Windows natif** — ajouter le dossier `scripts` à la variable PATH (Paramètres → Variables d'environnement), rouvrir le terminal. La commande est alors `cob` (fichier `cob.cmd`).

Test d'installation :

```bash
scripts/verifier_installation.sh
```

ou, à la main, depuis le dossier `workspace` :

```bash
cob seance1/exemples/01_hello.cob
```

Résultat attendu :

```
>> Compilation : cobc -x -free  seance1/exemples/01_hello.cob
>> OK - execution :
-----------------------------------------------
Bonjour, monde COBOL !
-----------------------------------------------
>> Fin du programme (code retour 0)
```

## 4. La commande `cob`

| Commande | Effet |
| --- | --- |
| `cob prog.cob` | Compile puis exécute |
| `cob -c prog.cob` | Compile seulement |
| `cob -d prog.cob` | Mode débogage (détecte les indices hors limites…) |
| `cob -f prog.cob` | Source au **format fixe** (colonnes 7-72) au lieu du format libre |
| `cob main.cob sub.cob` | Programme principal + sous-programme(s) liés |
| `cob -h` | Aide |

Les copybooks (`COPY`) sont cherchés dans le dossier du programme et dans `../copy`.

**Règle d'or : lancez les commandes depuis le dossier `workspace`** (les chemins des fichiers de données,
comme `seance4/data/produits.dat`, sont relatifs à ce dossier). Pour le mini-projet, placez-vous dans
`workspace/projet`. Éditeur recommandé : VS Code (extension « GnuCOBOL » d'Oleg Kunitsyn) ou tout éditeur de texte.

## 5. Format libre ou format fixe ?

Les exemples sont en **format libre** (pas de contrainte de colonnes), plus simple pour débuter.
Le COBOL « historique » (mainframe) est en **format fixe** : colonnes 1-6 numéros de ligne, colonne 7
indicateur (`*` = commentaire), colonnes 8-11 zone A, 12-72 zone B. Pour un source en format fixe : `cob -f prog.cob`.

## 6. Dépannage

| Problème | Solution |
| --- | --- |
| `cobc: command not found` | GnuCOBOL non installé, ou terminal non rouvert après modification du PATH |
| `cob: command not found` | Étape 3 non faite : lancer `scripts/cob` avec son chemin complet |
| `Permission denied` sur `cob` | `chmod +x scripts/cob` |
| `file not found` à l'exécution | Vous n'êtes pas dans le bon dossier (`pwd`) : `workspace` ou `workspace/projet` |
| Accents illisibles | Terminal en UTF-8 ; éviter les accents dans les zones `PIC X` dimensionnées |
| Fichier indexé corrompu ou périmé | Supprimer `workspace/seance4/out/*.idx` (ou `projet/out/*.idx`) et relancer la création |
| Fichiers WSL | Travaillez dans le disque Linux de WSL (`~/cobol-formation`) plutôt que dans `/mnt/c` : plus rapide et sans souci de droits |
| Version ancienne de GnuCOBOL (2.x) | Mettre à jour (3.x requis pour `FUNCTION`, `-free`, etc.) |
