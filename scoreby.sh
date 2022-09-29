#!/bin/bash
# Mysterious Number Leaderboard
echo "Entrez le nom d'utilisateur :";
read input;
result=`cat scoreboard.txt | grep -w "${input}" scoreboard.txt | awk '{print $2}'`;
echo "${result}";
exit;