; Video Interface Chip II (VIC-II)

; Opzioni: __C128_C64_MODE = 1    Aggiunge il supporto per i registri extra usati nella versione del chip installata sul C128

VIC               = $D000       ; Indirizzo base del chip VIC-II

SP0X              = VIC+$00     ; Posizione orizzontale sprite #0
SP0Y              = VIC+$01     ; Posizione verticale sprite #0
SP1X              = VIC+$02     ; Posizione orizzontale sprite #1
SP1Y              = VIC+$03     ; Posizione verticale sprite #1
SP2X              = VIC+$04     ; Posizione orizzontale sprite #2
SP2Y              = VIC+$05     ; Posizione verticale sprite #2
SP3X              = VIC+$06     ; Posizione orizzontale sprite #3
SP3Y              = VIC+$07     ; Posizione verticale sprite #3
SP4X              = VIC+$08     ; Posizione orizzontale sprite #4
SP4Y              = VIC+$09     ; Posizione verticale sprite #4
SP5X              = VIC+$0A     ; Posizione orizzontale sprite #5
SP5Y              = VIC+$0B     ; Posizione verticale sprite #5
SP6X              = VIC+$0C     ; Posizione orizzontale sprite #6
SP6Y              = VIC+$0D     ; Posizione verticale sprite #6
SP7X              = VIC+$0E     ; Posizione orizzontale sprite #7
SP7Y              = VIC+$0F     ; Posizione verticale sprite #7
MSIGX             = VIC+$10     ; MSB delle posizioni orizzontali degli sprites
SCROLY            = VIC+$11     ; Registro di controllo e scorrimento verticale fine
RASTER            = VIC+$12     ; Linea raster attuale
LPENX             = VIC+$13     ; Posizione orizzontale della penna ottica
LPENY             = VIC+$14     ; Posizione verticale della penna ottica
SPENA             = VIC+$15     ; Abilitazione sprites
SCROLX            = VIC+$16     ; Registro di controllo e scorrimento orizzontale fine
YXPAND            = VIC+$17     ; Espansione sprites in direzione verticale
VMCSB             = VIC+$18     ; Registro di controllo della memoria video
VICIRQ            = VIC+$19     ; Registro dei flag di interrupt
IRQMSK            = VIC+$1A     ; Registro di maschera IRQ
SPBGPR            = VIC+$1B     ; Priorità sprite/caratteri
SPMC              = VIC+$1C     ; Abilitazione sprites multicolore
XXPAND            = VIC+$1D     ; Espansione sprites in direzione orizzontale
SPSPCL            = VIC+$1E     ; Collisione sprite/sprite
SPBGCL            = VIC+$1F     ; Collisione sprite/caratteri
EXTCOL            = VIC+$20     ; Colore del bordo
BGCOL0            = VIC+$21     ; Colore dello sfondo
BGCOL1            = VIC+$22     ; Colore ausiliare di sfondo #1
BGCOL2            = VIC+$23     ; Colore ausiliare di sfondo #2
BGCOL3            = VIC+$24     ; Colore ausiliare di sfondo #3
SPMC0             = VIC+$25     ; Colore ausiliare degli sprites #1
SPMC1             = VIC+$26     ; Colore ausiliare degli sprites #2
SP0COL            = VIC+$27     ; Colore dello sprite #0
SP1COL            = VIC+$28     ; Colore dello sprite #1
SP2COL            = VIC+$29     ; Colore dello sprite #2
SP3COL            = VIC+$2A     ; Colore dello sprite #3
SP4COL            = VIC+$2B     ; Colore dello sprite #4
SP5COL            = VIC+$2C     ; Colore dello sprite #5
SP6COL            = VIC+$2D     ; Colore dello sprite #6
SP7COL            = VIC+$2E     ; Colore dello sprite #7

!ifdef __C128_C64_MODE {
  XSCAN           = VIC+$2F     ; Registro di scansione dei tasti supplementari
  CLKRATE         = VIC+$30     ; Registro di controllo della frequenza di clock
}

; Codici colore del chip VIC-II
VIC_BLACK         = 0           ; Codice VIC del colore nero
VIC_WHITE         = 1           ; Codice VIC del colore bianco
VIC_RED           = 2           ; Codice VIC del colore rosso
VIC_CYAN          = 3           ; Codice VIC del colore ciano
VIC_PURPLE        = 4           ; Codice VIC del colore viola
VIC_GREEN         = 5           ; Codice VIC del colore verde
VIC_BLUE          = 6           ; Codice VIC del colore blu
VIC_YELLOW        = 7           ; Codice VIC del colore giallo
VIC_ORANGE        = 8           ; Codice VIC del colore arancione
VIC_BROWN         = 9           ; Codice VIC del colore marrone
VIC_LIGHT_RED     = 10          ; Codice VIC del colore rosso chiaro
VIC_DARK_GREY     = 11          ; Codice VIC del colore grigio scuro
VIC_MEDIUM_GREY   = 12          ; Codice VIC del colore grigio medio
VIC_LIGHT_GREEN   = 13          ; Codice VIC del colore verde chiaro
VIC_LIGHT_BLUE    = 14          ; Codice VIC del colore azzurro
VIC_LIGHT_GREY    = 15          ; Codice VIC del colore grigio chiaro

VIC_TRANSPARENT   = $FF         ; Valore fittizio usato per indicare che il registro colore non va alterato

; Codici PETSCII per la selezione del colore di sfondo nella stampa in Extended Color Mode
ECM_BG0           = 1           ; Colore di sfondo #0
ECM_BG1           = 2           ; Colore di sfondo #1
ECM_BG2           = 3           ; Colore di sfondo #2
ECM_BG3           = 4           ; Colore di sfondo #3

; Variabili utente
BGCOL             = TEMP_1      ; Registro utente: seleziona il colore di sfondo da applicare all'output su schermo quando il modo colore esteso è attivo
