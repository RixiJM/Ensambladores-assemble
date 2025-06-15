@echo off
COPY "proyecto-dino\src\main.asm" "C:\Tasm 1.4\Tasm\main.asm"
COPY "proyecto-dino\src\input.asm" "C:\Tasm 1.4\Tasm\input.asm"
COPY "proyecto-dino\src\logic.asm" "C:\Tasm 1.4\Tasm\logic.asm"
COPY "proyecto-dino\src\draw.asm" "C:\Tasm 1.4\Tasm\draw.asm"
COPY "proyecto-dino\src\score.asm" "C:\Tasm 1.4\Tasm\score.asm"
COPY "proyecto-dino\src\sprite.asm" "C:\Tasm 1.4\Tasm\sprite.asm"
COPY "proyecto-dino\src\menu.asm" "C:\Tasm 1.4\Tasm\menu.asm"
COPY "proyecto-dino\docs\dino.conf" "C:\Tasm 1.4\Techapple.net\dino.conf"
COPY "proyecto-dino\scripts\dino.bat" "C:\Tasm 1.4\Tasm\dino.bat"
COPY "proyecto-dino\scripts\dinotd.bat" "C:\Tasm 1.4\Tasm\dinotd.bat"

"C:\Tasm 1.4\Techapple.net\DOSBox.exe" -conf "C:\Tasm 1.4\Techapple.net\dino.conf"