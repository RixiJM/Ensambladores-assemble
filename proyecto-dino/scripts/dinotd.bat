tasm /zi main.asm
tasm /zi input.asm
tasm /zi logic.asm
tasm /zi draw.asm
tasm /zi score.asm
tasm /zi sprite.asm
tasm /zi menu.asm

tlink /v main.obj input.obj logic.obj draw.obj score.obj sprite.obj menu.obj

td main