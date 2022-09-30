#!/bin/bash
# Mysterious Number
echo "Bienvenue sur Mysterious Number, vous devez trouver le nombre en 0 et 99 !";
# Saisi nom de l'utilisateur
read -p "Veuillez saisir votre nom : " saisieNom;

if [ -z ${saisieNom} ]; then
    printf '%s\n' "Vous devez saisir votre nom !";
    exit 0;
fi;

read -p "Veuillez saisir le nombre d'essai : " nbEssaiChoisi;

if [ -z ${nbEssaiChoisi} ]; then
    printf '%s\n' "Vous devez saisir un nombre d'essai !";
    exit 0;
fi;

if ! [[ ${nbEssaiChoisi} =~ ^[0-9]*$ ]]; then
    printf '%s\n' "Vous devez saisir un nombre valide !";
    exit 0;
fi;

read -p "Veuillez saisir un nombre : " saisieUser;

if [ -z ${saisieUser} ]; then
    printf '%s\n' "Vous devez saisir un nombre !";
    exit 0;
fi;

if ! [[ ${saisieUser} =~ ^[0-9]*$ ]]; then
    printf '%s\n' "Vous devez saisir un nombre valide !";
    exit 0;
fi;

# Initialisation des variables
nbEssai=1;
ptHisto=0;
nbPlace=1;
nbRandom=${RANDOM:0:2};

# Lancement du jeu
# Vérification de la saisie user et du nombre d'essai
while [ ${saisieUser} -ne ${nbRandom} ] && [ ${nbEssai} -ne ${nbEssaiChoisi} ]; do
    ((nbEssai++))
    if [ ${saisieUser} -gt ${nbRandom} ]; then
        echo "Le nombre Mysterious est plus petit réessayez :";
    else
        echo "Le nombre Mysterious est plus grand réessayez :";
    fi
    read saisieUser;
done;

# Vérification si le joueur à trouver le nombre
if [ ${saisieUser} -eq ${nbRandom} ]; then
    echo "Félicitations ! Vous avez trouvé le nombre : ${nbRandom} en ${nbEssai} coups !";
else
    echo "Dommage le mysterious number est : ${nbRandom}";
fi;

if grep -w -q "${saisieNom}" scoreboard.txt; then
    # Récupère son nombre d'essai dans scoreboard.txt
    ptHisto=`grep -w ${saisieNom} scoreboard.txt | awk '{print $2}'`;
    if [ "${ptHisto}" -gt "${nbEssai}" ]; then
        # Remplace son ancien score par le nouveau (s'il est mieux)
        sed "s/${saisieNom} ${ptHisto}/${saisieNom} ${nbEssai}/" scoreboard.txt;
        echo "Vous venez de battre votre ancien record qui était de : ${ptHisto} !";
    elif [ "${ptHisto}" -eq "${nbEssai}" ]; then
        echo "Vous avez réussi avec le même nombre d'essai !";
    else
        echo "Vous n'avez pas battu votre record, dommage...";
    fi;
else
    echo "${saisieNom} ${nbEssai}" >> scoreboard.txt;
fi;

# Calcul sa position dans le classement
cat scoreboard.txt | while read line; do
    laLigne=`grep -w ${line} scoreboard.txt | awk '{print $2}'`;
    if [ ${nbEssai} -gt ${laLigne} ]; then
        ((nbPlace++))
    fi;
done;

# bug - nbPlace garde 1 en valeur
if [ ${nbPlace} -eq 1 ]; then
    echo "${saisieNom}, vous êtes ${nbPlace}er ! Félicitations !";
else
    echo "${saisieNom}, vous êtes ${nbPlace} ième !";
fi;

exit;