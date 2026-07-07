#!/bin/bash

DAYS_BACK=2
COMMITS_PER_DAY=9999

echo "Погнали крутить счётчик для кота..."

for ((i=$DAYS_BACK; i>=0; i--)); do
    CURRENT_DATE=$(date -v-"${i}"d +"%Y-%m-%d %H:%M:%S")
    
    echo "Забиваем дату: $CURRENT_DATE"
    
    for ((j=1; j<=$COMMITS_PER_DAY; j++)); do
        echo "flex $i $j" >> borsch.txt
        GIT_AUTHOR_DATE="$CURRENT_DATE" GIT_COMMITTER_DATE="$CURRENT_DATE" git commit -am "feat: something changed #$j" --quiet
    done
done

echo "Локально упаковано! Привязываем репу и пушим..."
