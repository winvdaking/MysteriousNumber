#!/bin/bash
# Mysterious Number Leaderboard

cat scoreboard.txt | while read line; do
    echo "${line}";
done;

exit;