#!/bin/bash
# Mysterious Number
echo "Bienvenue sur Mysterious Number, vous devez trouver le nombre en 0 et 99 !";
# Saisi nom de l'utilisateur
echo "Veuillez saisir votre nom :"
read saisieNom;
nbRandom=${RANDOM:0:2};

echo "Veuillez saisir le nombre d'essai :";
read nbEssaiChoisi;

# Saisi nombre de l'utilisateur
echo "Veuillez saisir un nombre :";
read saisieUser;

# Initialisation des variables
nbEssai=1;
ptHisto=0;
nbPlace=1;

# Lancement du jeu
while [ ${saisieUser} -ne ${nbRandom} && ${nbEssai} -ne ${nbEssaiChoisi}]
do
    ((nbEssai++))
    if [ ${saisieUser} -gt ${nbRandom} ]; then
        echo "Le nombre Mysterious est plus petit réessayez :";
    else
        echo "Le nombre Mysterious est plus grand réessayez :";
    fi
    read saisieUser;
done;

echo "Félicitations ! Vous avez trouvé le nombre : ${nbRandom} en ${nbEssai} coups !";

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
    if [ ${laLigne} -lt ${nbEssai} ]; then
        ((nbPlace++));
    fi;
    echo ${nbPlace};
done;

# bug - nbPlace garde 1 en valeur
echo ${nbPlace};
if [ ${nbPlace} -eq 1 ]; then
    echo "${saisieNom}, vous êtes ${nbPlace}er ! Félicitations !";
else
    echo "${saisieNom}, vous êtes ${nbPlace} ième !";
fi;
exit;