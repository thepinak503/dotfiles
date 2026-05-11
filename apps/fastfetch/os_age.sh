#!/bin/bash
INSTALL_DATE=""
if [ -f /var/log/pacman.log ]; then
    FIRST_ENTRY=$(head -1 /var/log/pacman.log 2>/dev/null | grep -oP '\[\K[0-9-]+')
    if [ -n "$FIRST_ENTRY" ]; then
        INSTALL_DATE="$FIRST_ENTRY"
    fi
fi
if [ -z "$INSTALL_DATE" ]; then
    BIRTH_TIME=$(stat / --format=%w 2>/dev/null | cut -d' ' -f1)
    if [ -n "$BIRTH_TIME" ] && [ "$BIRTH_TIME" != "-" ]; then
        INSTALL_DATE="$BIRTH_TIME"
    fi
fi
if [ -z "$INSTALL_DATE" ] && [ -f /var/log/pacman.log ]; then
    INSTALL_DATE=$(date -r /var/log/pacman.log +%Y-%m-%d 2>/dev/null)
fi
if [ -n "$INSTALL_DATE" ]; then
    INSTALL_EPOCH=$(date -d "$INSTALL_DATE" +%s 2>/dev/null)
    NOW_EPOCH=$(date +%s)
    DAYS_DIFF=$(( (NOW_EPOCH - INSTALL_EPOCH) / 86400 ))
    if [ "$DAYS_DIFF" -lt 0 ]; then
        DAYS_DIFF=0
    fi
    if [ "$DAYS_DIFF" -eq 0 ]; then
        echo "Installed today"
    elif [ "$DAYS_DIFF" -eq 1 ]; then
        echo "1 day"
    elif [ "$DAYS_DIFF" -lt 30 ]; then
        echo "$DAYS_DIFF days"
    elif [ "$DAYS_DIFF" -lt 365 ]; then
        MONTHS=$(( DAYS_DIFF / 30 ))
        REMAINDER=$(( DAYS_DIFF % 30 ))
        if [ "$REMAINDER" -gt 0 ]; then
            echo "$MONTHS months, $REMAINDER days ($DAYS_DIFF days)"
        else
            echo "$MONTHS months ($DAYS_DIFF days)"
        fi
    else
        YEARS=$(( DAYS_DIFF / 365 ))
        MONTHS=$(( (DAYS_DIFF % 365) / 30 ))
        if [ "$MONTHS" -gt 0 ]; then
            echo "$YEARS years, $MONTHS months ($DAYS_DIFF days)"
        else
            echo "$YEARS years ($DAYS_DIFF days)"
        fi
    fi
else
    echo "Unknown"
fi
