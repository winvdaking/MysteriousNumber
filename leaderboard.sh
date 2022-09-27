#!/bin/bash
# Mysterious Number Leaderboard

cat scoreboard.txt | while read line; do
    echo "${line}";
    joueur=`grep -w ${line} scoreboard.txt | awk '{print $1}'`;
    point=`grep -w ${line} scoreboard.txt | awk '{print $2}'`;
    echo "${joueur} : ${point}";
done;

exit;