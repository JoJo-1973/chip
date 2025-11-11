; Sound Interface Device (SID)

SID               = $D400       ; Indirizzo di base del chip SID

FRELO1            = SID+$00     ; Controllo frequenza voce #1 (byte basso)
FREHI1            = SID+$01     ; Controllo frequenza voce #1 (byte alto)
PWLO1             = SID+$02     ; Larghezza onda quadra voce #1 (byte basso)
PWHI1             = SID+$03     ; Larghezza onda quadra voce #1 (byte alto)
VCREG1            = SID+$04     ; Registro di controllo voce #1
ATDCY1            = SID+$05     ; Registro Attack/Delay voce #1
SUREL1            = SID+$06     ; Registro Sustain/Release voce #1
FRELO2            = SID+$07     ; Controllo frequenza voce #2 (byte basso)
FREHI2            = SID+$08     ; Controllo frequenza voce #2 (byte alto)
PWLO2             = SID+$09     ; Larghezza onda quadra voce #2 (byte basso)
PWHI2             = SID+$0A     ; Larghezza onda quadra voce #2 (byte alto)
VCREG2            = SID+$0B     ; Registro di controllo voce #2
ATDCY2            = SID+$0C     ; Registro Attack/Delay voce #2
SUREL2            = SID+$0D     ; Registro Sustain/Release voce #2
FRELO3            = SID+$0E     ; Controllo frequenza voce #3 (byte basso)
FREHI3            = SID+$0F     ; Controllo frequenza voce #3 (byte alto)
PWLO3             = SID+$10     ; Larghezza onda quadra voce #3 (byte basso)
PWHI3             = SID+$11     ; Larghezza onda quadra voce #3 (byte alto)
VCREG3            = SID+$12     ; Registro di controllo voce #3
ATDCY3            = SID+$13     ; Registro Attack/Delay voce #3
SUREL3            = SID+$14     ; Registro Sustain/Release voce #3
CUTLO             = SID+$15     ; Frequenza di taglio del filtro (byte basso)
CUTHI             = SID+$16     ; Frequenza di taglio del filtro (byte alto)
RESON             = SID+$17     ; Registro di controllo risonanza dei filtri
SIGVOL            = SID+$18     ; Volume e registro di selezione dei filtri
POTX              = SID+$19     ; Posizione paddle #1 (o #3)
POTY              = SID+$1A     ; Posizione paddle #2 (o #4)
RANDOM            = SID+$1B     ; Uscita oscillatore #3 / generatore di numeri casuali
ENV3              = SID+$1C     ; Uscita generatore di inviluppo #3
