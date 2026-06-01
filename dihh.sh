#!/bin/bash

# Очищаем экран для красивого интерфейса
clear
echo "=================================================="
echo "    GITHUB CONTRIBUTIONS BOOSTER (FOR THE CAT)    "
echo "=================================================="
echo ""

# Интерактивный сбор данных (User Input)
read -p "Boshlanish sanasini kiriting (DD.MM.YYYY): " START_DATE
read -p "Tugash sanasini kiriting (DD.MM.YYYY): " END_DATE
read -p "Minimal commitlar soni (kuniga): " MIN_COMMITS
read -p "Maximal commitlar soni (kuniga): " MAX_COMMITS

echo ""
echo "=================================================="
echo "Tayyorlanmoqda..."

# Проверка на пустые значения
if [ -z "$START_DATE" ] || [ -z "$END_DATE" ] || [ -z "$MIN_COMMITS" ] || [ -z "$MAX_COMMITS" ]; then
    echo "Xatolik: Barcha maydonlarni to'ldirish shart!"
    exit 1
fi

# DD.MM.YYYY → YYYY-MM-DD
parse_date() {
    local d="$1"
    echo "$d" | awk -F. '{print $3"-"$2"-"$1}'
}

START_FMT=$(parse_date "$START_DATE")
END_FMT=$(parse_date "$END_DATE")

echo "Diapazon: $START_DATE — $END_DATE"
echo "Har kungi commit: $MIN_COMMITS dan $MAX_COMMITS gacha (random)"
echo "=================================================="
echo "Protsess boshlandi..."
echo ""

if date --version >/dev/null 2>&1; then
    # GNU/Linux
    start_epoch=$(date -d "$START_FMT" +%s)
    end_epoch=$(date -d "$END_FMT" +%s)
    
    current=$start_epoch
    while [ "$current" -le "$end_epoch" ]; do
        commits=$((RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS))
        date_str=$(date -d "@$current" +"%Y-%m-%d")
        
        echo "[$date_str] → $commits ta commit yozilmoqda..."
        
        for ((j=1; j<=commits; j++)); do
            rh=$((RANDOM % 14 + 8))
            rm=$((RANDOM % 60))
            rs=$((RANDOM % 60))
            full_date="${date_str}T$(printf '%02d:%02d:%02d' $rh $rm $rs)"
            
            echo "flex $full_date $j" >> borsch.txt
            GIT_AUTHOR_DATE="$full_date" GIT_COMMITTER_DATE="$full_date" \
                git commit -am "feat: core submodules refactoring #$j" --quiet
        done
        current=$((current + 86400))
    done
else
    # macOS (BSD)
    start_epoch=$(date -j -f "%Y-%m-%d" "$START_FMT" +%s)
    end_epoch=$(date -j -f "%Y-%m-%d" "$END_FMT" +%s)
    
    current=$start_epoch
    while [ "$current" -le "$end_epoch" ]; do
        commits=$((RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS))
        date_str=$(date -r "$current" +"%Y-%m-%d")
        
        echo "[$date_str] → $commits ta commit yozilmoqda..."
        
        for ((j=1; j<=commits; j++)); do
            rh=$((RANDOM % 14 + 8))
            rm=$((RANDOM % 60))
            rs=$((RANDOM % 60))
            full_date="${date_str}T$(printf '%02d:%02d:%02d' $rh $rm $rs)"
            
            echo "flex $full_date $j" >> borsch.txt
            GIT_AUTHOR_DATE="$full_date" GIT_COMMITTER_DATE="$full_date" \
                git commit -am "feat: architecture optimization #$j" --quiet
        done
        current=$((current + 86400))
    done
fi

echo ""
echo "=================================================="
echo "Tayyor! Endi 'git push origin main' qilishingiz mumkin."
echo "=================================================="