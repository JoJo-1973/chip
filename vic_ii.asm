; ==============================================================================
; FILE:           vic_ii.asm
; PROGETTO:       Libreria Chip (chip.c64)
; TARGET:         ACME Assembler / MOS 6567/6569 VIC-II (Commodore 64 / C128)
; DESCRIZIONE:    Registri e codici colore del chip VIC-II. Con
;                 __C128_C64_MODE = 1 aggiunge il supporto per i registri extra
;                 usati nella versione del chip installata sul C128.
; ==============================================================================

VIC                 = $D000     ; Indirizzo base del chip VIC-II

SP0X                = VIC+$00   ; Posizione orizzontale sprite #0
SP0Y                = VIC+$01   ; Posizione verticale sprite #0
SP1X                = VIC+$02   ; Posizione orizzontale sprite #1
SP1Y                = VIC+$03   ; Posizione verticale sprite #1
SP2X                = VIC+$04   ; Posizione orizzontale sprite #2
SP2Y                = VIC+$05   ; Posizione verticale sprite #2
SP3X                = VIC+$06   ; Posizione orizzontale sprite #3
SP3Y                = VIC+$07   ; Posizione verticale sprite #3
SP4X                = VIC+$08   ; Posizione orizzontale sprite #4
SP4Y                = VIC+$09   ; Posizione verticale sprite #4
SP5X                = VIC+$0A   ; Posizione orizzontale sprite #5
SP5Y                = VIC+$0B   ; Posizione verticale sprite #5
SP6X                = VIC+$0C   ; Posizione orizzontale sprite #6
SP6Y                = VIC+$0D   ; Posizione verticale sprite #6
SP7X                = VIC+$0E   ; Posizione orizzontale sprite #7
SP7Y                = VIC+$0F   ; Posizione verticale sprite #7
MSIGX               = VIC+$10   ; MSB delle posizioni orizzontali degli sprite
SCROLY              = VIC+$11   ; Registro di controllo e scorrimento verticale fine
RASTER              = VIC+$12   ; Linea di raster attuale
LPENX               = VIC+$13   ; Posizione orizzontale della penna ottica
LPENY               = VIC+$14   ; Posizione verticale della penna ottica
SPENA               = VIC+$15   ; Abilitazione sprite
SCROLX              = VIC+$16   ; Registro di controllo e scorrimento orizzontale fine
YXPAND              = VIC+$17   ; Espansione sprite in direzione verticale
VMCSB               = VIC+$18   ; Registro di controllo della memoria video
VICIRQ              = VIC+$19   ; Registro dei flag di interrupt
IRQMSK              = VIC+$1A   ; Registro di maschera IRQ
SPBGPR              = VIC+$1B   ; Priorità sprite/caratteri
SPMC                = VIC+$1C   ; Abilitazione sprite multicolore
XXPAND              = VIC+$1D   ; Espansione sprite in direzione orizzontale
SPSPCL              = VIC+$1E   ; Collisione sprite/sprite
SPBGCL              = VIC+$1F   ; Collisione sprite/caratteri
EXTCOL              = VIC+$20   ; Colore del bordo
BGCOL0              = VIC+$21   ; Colore dello sfondo
BGCOL1              = VIC+$22   ; Colore ausiliare di sfondo #1
BGCOL2              = VIC+$23   ; Colore ausiliare di sfondo #2
BGCOL3              = VIC+$24   ; Colore ausiliare di sfondo #3
SPMC0               = VIC+$25   ; Colore ausiliare degli sprite #1
SPMC1               = VIC+$26   ; Colore ausiliare degli sprite #2
SP0COL              = VIC+$27   ; Colore dello sprite #0
SP1COL              = VIC+$28   ; Colore dello sprite #1
SP2COL              = VIC+$29   ; Colore dello sprite #2
SP3COL              = VIC+$2A   ; Colore dello sprite #3
SP4COL              = VIC+$2B   ; Colore dello sprite #4
SP5COL              = VIC+$2C   ; Colore dello sprite #5
SP6COL              = VIC+$2D   ; Colore dello sprite #6
SP7COL              = VIC+$2E   ; Colore dello sprite #7

!if (__C128_C64_MODE = 1) {     ; Registri extra del C128.
  XSCAN             = VIC+$2F   ; Registro di scansione dei tasti supplementari
  CLKRATE           = VIC+$30   ; Registro di controllo della frequenza di clock
}

; ------------------------------------------------------------------------------
; Codici colore del chip VIC-II
; ------------------------------------------------------------------------------

VIC_BLACK           = $00       ; Codice VIC del colore nero
VIC_WHITE           = $01       ; Codice VIC del colore bianco
VIC_RED             = $02       ; Codice VIC del colore rosso
VIC_CYAN            = $03       ; Codice VIC del colore ciano
VIC_PURPLE          = $04       ; Codice VIC del colore viola
VIC_GREEN           = $05       ; Codice VIC del colore verde
VIC_BLUE            = $06       ; Codice VIC del colore blu
VIC_YELLOW          = $07       ; Codice VIC del colore giallo
VIC_ORANGE          = $08       ; Codice VIC del colore arancione
VIC_BROWN           = $09       ; Codice VIC del colore marrone
VIC_LIGHT_RED       = $0A       ; Codice VIC del colore rosso chiaro
VIC_DARK_GREY       = $0B       ; Codice VIC del colore grigio scuro
VIC_MEDIUM_GREY     = $0C       ; Codice VIC del colore grigio medio
VIC_LIGHT_GREEN     = $0D       ; Codice VIC del colore verde chiaro
VIC_LIGHT_BLUE      = $0E       ; Codice VIC del colore azzurro
VIC_LIGHT_GREY      = $0F       ; Codice VIC del colore grigio chiaro

; ------------------------------------------------------------------------------
; Codici colore primario dei caratteri in modalità multicolore
; ------------------------------------------------------------------------------

VIC_MC_BLACK        = $00 | $08 ; Colore primario nero
VIC_MC_WHITE        = $01 | $08 ; Colore primario bianco
VIC_MC_RED          = $02 | $08 ; Colore primario rosso
VIC_MC_CYAN         = $03 | $08 ; Colore primario ciano
VIC_MC_PURPLE       = $04 | $08 ; Colore primario viola
VIC_MC_GREEN        = $05 | $08 ; Colore primario verde
VIC_MC_BLUE         = $06 | $08 ; Colore primario blu
VIC_MC_YELLOW       = $07 | $08 ; Colore primario giallo

VIC_TRANSPARENT     = $FF       ; Valore fittizio usato per indicare che il registro colore non va alterato

; ------------------------------------------------------------------------------
; Codici colore per la selezione del colore di sfondo nella stampa in modo ECM
; ------------------------------------------------------------------------------

VIC_BG0             = $00       ; Colore di sfondo #0
VIC_BG1             = $01       ; Colore di sfondo #1
VIC_BG2             = $02       ; Colore di sfondo #2
VIC_BG3             = $03       ; Colore di sfondo #3

; ------------------------------------------------------------------------------
; Codici PETSCII per la selezione del colore di sfondo nella stampa in modo ECM
; ------------------------------------------------------------------------------

ECM_BG0             = $01       ; Colore di sfondo #0
ECM_BG1             = $02       ; Colore di sfondo #1
ECM_BG2             = $03       ; Colore di sfondo #2
ECM_BG3             = $04       ; Colore di sfondo #3
