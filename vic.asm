; Video Interface Chip (VIC)

VIC               = $9000       ; Indirizzo base del chip VIC

VICCRO            = VIC+$00     ; Centraggio orizzontale dello schermo e modo interlacciato
VICCRI            = VIC+$01     ; Centraggio verticale dello schermo
VICCR2            = VIC+$02     ; Colonne visualizzate / Indirizzo schermo (bit #9)
VICCR3            = VIC+$03     ; Righe visualizzate / Posizione raster (bit #0)
VICCR4            = VIC+$04     ; Posizione raster (bit #8 - #1)
VICCR5            = VIC+$05     ; Indirizzo schermo (bit #13 - #10) / Indirizzo mappa caratteri (bit #13 - #10)
VICCR6            = VIC+$06     ; Penna ottica (ascissa)
VICCR7            = VIC+$07     ; Penna ottica (ordinata)
VICCR8            = VIC+$08     ; Paddle X
VICCR9            = VIC+$09     ; Paddle Y
VICCRA            = VIC+$0A     ; Frequenza oscillatore #1 (basso)
VICCRB            = VIC+$0B     ; Frequenza oscillatore #2 (alto)
VICCRC            = VIC+$0C     ; Frequenza oscillatore #3 (soprano)
VICCRD            = VIC+$0D     ; Frequenza oscillatore #4 (rumore)
VICCRE            = VIC+$0E     ; Colore ausiliario / Volume
VICCRF            = VIC+$0F     ; Colore sfondo / bordo / modalità inversa
