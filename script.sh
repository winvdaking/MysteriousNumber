#!/bin/bash
touch test.txt
maVariable=456
echo "${maVariable}";
    
### -gt = Greater Than
### -ge = Greater Than or Equal
### -lt = Lesser Than
### -le = Lesser Than or Equal
### -eq = Equal

### ==
### !=

if [ ${maVariable} -gt 500 ]; then
    echo "Je fais des trucs"
else
    echo "Je fais d'autres trucs"
fi;

