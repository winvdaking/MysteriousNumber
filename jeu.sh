#!/bin/bash
## Mysterious Number
echo "Bienvenue sur Mysterious Number, vous devez trouver le nombre en 0 et 99 !";
echo "Veuillez saisir votre nom :"
read saisieNom;
nbRandom=${RANDOM:0:1};
echo "Veuillez saisir un nombre :";
read saisieUser;
nbEssai=1;
ptHisto=0;
nbPlace=1;

while [ ${saisieUser} -ne ${nbRandom} ]
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

cat scoreboard.txt | while read line; do
    laLigne=`grep -w ${line} scoreboard.txt | awk '{print $2}'`;
    if [ "${laLigne}" -lt ${nbEssai} ]; then
        ((nbPlace++));
    fi;
    echo ${nbPlace};
done;
echo ${nbPlace};
if [ ${nbPlace} -eq 1 ]; then
    echo "${saisieNom}, vous êtes ${nbPlace}er ! Félicitations !";
else
    echo "${saisieNom}, vous êtes ${nbPlace} ième !";
fi;
exit;