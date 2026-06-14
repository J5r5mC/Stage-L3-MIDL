# Du PDDL aux réseaux STNU et MaSTNU

Ce dépôt est basé sur le dépôt GitHub de 
[victorpaleologue/optic-planner](https://github.com/victorpaleologue/optic-planner),
qui propose une version modernisée d'OPTIC permettant une compilation out-of-the-box.
Le README original de ce dépôt est conservé ci-dessous.

## Modifications apportées dans le cadre du stage

Dans le cadre d'un stage de licence à l'IRIT (Université de Toulouse), encadré par 
Frédéric Maris, le fichier `FFSolver.cpp` a été modifié afin d'extraire les points 
temporels identifiés par le planificateur dans un fichier JSON. Chaque point temporel 
est décrit par :
- le nom et les paramètres de l'action associée,
- si c'est le début ou la fin de l'action,
- le temps d'attente minimal avant d'effectuer l'action,
- le temps maximal s'il y en a un,
- l'agent qui effectue l'action.

Les zones modifiées commencent au commentaire `// Début Ajout` et se terminent au 
commentaire `// Fin de l'ajout` (2 zones au total).

Une fois le planificateur compilé, copier le fichier `mastnu_to_stnus.ipynb` dans le 
dossier `optic/build/src/optic/`. Dans ce même dossier, créer un dossier `stnu/`. 
C'est dans ce dossier que seront générés les STNUs issus du partitionnement du MaSTNU.

Si vous ne souhaitez pas recompiler le planificateur et voulez simplement observer les 
résultats, le fichier `stn_final_plan.json` contient le MaSTNU incomplet produit par 
le planificateur. Le dossier `stnu/` contient quant à lui le partitionnement de ce 
MaSTNU en plusieurs STNUs, un par agent.

Le fichier `json_to_txt.ipynb` permet de convertir un STNU du format JSON vers le 
format TXT standardisé d'Andrea Micheli. Il s'applique sur le fichier 
`Exemple_STNU.json` et produit le fichier `Exemple_STNU.txt`. Attention, il ne peut 
pas être utilisé sur les STNUs du dossier `stnu/` car ils sont incomplets.

---

# OPTIC: Optimising Preferences and Time-Dependent Costs

https://nms.kcl.ac.uk/planning/software/optic.html

Modernized OPTIC to build out-of-the-box.
Some small modifications to the build system and source have been done.

## Dependencies & How to Build

Simply build with `CMake`:
```sh
# I recommend the ninja build system
cmake -Bbuild -GNinja .
cmake --build build
```

You will need the following dependencies:
- CMake for building
- Flex/Bison for parsing
- COIN-OR OSI, CLP, CBC, and CoinUtils
- GNU Scientific Library (GSL)

## How to Run

By default, the `optic-clp` solver will be built.
From the top-level directory, it can be run (given a domain and problem `.pddl` file) 
with:
```sh
./build/src/optic/optic-clp domain.pddl problem.pddl
```
See [README.old](README.old) for some other solver details.