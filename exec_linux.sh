#!/bin/bash
# Script para copiar archivos del proyecto dino en Ubuntu

mkdir -p ~/Documents/TASM

cp proyecto-dino/src/intRand.asm ~/Documents/TASM/intRand.asm
cp proyecto-dino/src/main.asm ~/Documents/TASM/main.asm
cp proyecto-dino/src/espera.asm ~/Documents/TASM/espera.asm
cp proyecto-dino/src/logic.asm ~/Documents/TASM/logic.asm
cp proyecto-dino/src/dino.asm ~/Documents/TASM/dino.asm
cp proyecto-dino/src/score.asm ~/Documents/TASM/score.asm
cp proyecto-dino/src/sprite.asm ~/Documents/TASM/sprite.asm
cp proyecto-dino/src/libsp.asm ~/Documents/TASM/libsp.asm
cp proyecto-dino/src/archivo.asm ~/Documents/TASM/archivo.asm
cp proyecto-dino/src/menu.asm ~/Documents/TASM/menu.asm
cp proyecto-dino/docs/dino.conf ~/Documents/TASM/dino.conf
cp proyecto-dino/scripts/dino.bat ~/Documents/TASM/dino.bat
cp proyecto-dino/scripts/dinotd.bat ~/Documents/TASM/dinotd.bat

# Ejecutar DOSBox con el archivo de configuración
dosbox -conf ~/Documents/TASM/dino.conf