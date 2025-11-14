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

; Codici colore del chip VIC
VIC_BLACK         = 0           ; Codice VIC del colore nero
VIC_WHITE         = 1           ; Codice VIC del colore bianco
VIC_RED           = 2           ; Codice VIC del colore rosso
VIC_CYAN          = 3           ; Codice VIC del colore ciano
VIC_PURPLE        = 4           ; Codice VIC del colore viola
VIC_GREEN         = 5           ; Codice VIC del colore verde
VIC_BLUE          = 6           ; Codice VIC del colore blu
VIC_YELLOW        = 7           ; Codice VIC del colore giallo
VIC_ORANGE        = 8           ; Codice VIC del colore arancione
VIC_LIGHT_ORANGE  = 9           ; Codice VIC del colore arancione chiaro
VIC_PINK          = 10          ; Codice VIC del colore rosa
VIC_LIGHT_CYAN    = 11          ; Codice VIC del colore ciano chiaro
VIC_LIGHT_PURPLE  = 12          ; Codice VIC del colore viola chiaro
VIC_LIGHT_GREEN   = 13          ; Codice VIC del colore verde chiaro
VIC_LIGHT_BLUE    = 14          ; Codice VIC del colore azzurro
VIC_LIGHT_YELLOW  = 15          ; Codice VIC del colore giallo chiaro

VIC_TRANSPARENT   = $FF         ; Valore fittizio usato per indicare che il registro colore non va alterato
