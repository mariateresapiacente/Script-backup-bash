#!/bin/bash

# Directory dei file log
LOG_DIR="$HOME/Desktop/esercizioUnix/esercizio/file_log_dir"

# Directory di destinazione dei backup
BACKUP_DIR="$HOME/Desktop/esercizioUnix/esercizio/Backup_Log"

# Timestamp per nome file
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# creo la directory di backup se non esiste
mkdir -p "$BACKUP_DIR"

# Backup e compressione dei file log
for FILE in "$LOG_DIR"/*.log; do
    if [ -e "$FILE" ]; then
        NOME_FILE=$(basename "$FILE")
        
        echo "Backup di: $NOME_FILE"
        
        # Copio il file
        if cp "$FILE" "$BACKUP_DIR/${NOME_FILE}_$TIMESTAMP"; then
            echo "File copiato con successo."
            
            # Comprimo
            if gzip "$BACKUP_DIR/${NOME_FILE}_$TIMESTAMP"; then
                echo "File compresso correttamente."
            else
                echo "Errore nella compressione di $NOME_FILE"
            fi
        else
            echo "Errore nella copia di $NOME_FILE"
        fi
    fi
done

echo "Backup completato."

exit 0