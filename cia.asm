; Complex Interface Adapter

; Complex Interface Adapter (CIA) #1
CIA_1             = $DC00       ; Indirizzo di base del chip CIA #1

CIAPRA            = CIA_1+$00   ; Registro di controllo porte dati A
CIAPRB            = CIA_1+$01   ; Registro di controllo porte dati B
CIDDRA            = CIA_1+$02   ; Registro direzione dati A
CIDDRB            = CIA_1+$03   ; Registro direzione dati B
TIMALO            = CIA_1+$04   ; Timer A (byte basso)
TIMAHI            = CIA_1+$05   ; Timer A (byte alto)
TIMBLO            = CIA_1+$06   ; Timer B (byte basso)
TIMBHI            = CIA_1+$07   ; Timer B (byte alto)
TODTEN            = CIA_1+$08   ; Orologio Time-Of-Day (decimi di secondo)
TODSEC            = CIA_1+$09   ; Orologio Time-Of-Day (secondi)
TODMIN            = CIA_1+$0A   ; Orologio Time-Of-Day (minuti)
TODHRS            = CIA_1+$0B   ; Orologio Time-Of-Day (ore)
CIASDR            = CIA_1+$0C   ; Porta dati seriale
CIAICR            = CIA_1+$0D   ; Registro di controllo interrupt
CIACRA            = CIA_1+$0E   ; Registro di controllo A
CIACRB            = CIA_1+$0F   ; Registro di controllo B

; Complex Interface Adapter (CIA) #2
CIA_2             = $DD00       ; Indirizzo di base del chip CIA #2

CI2PRA            = CIA_2+$00   ; Registro di controllo porte dati A
CI2PRB            = CIA_2+$01   ; Registro di controllo porte dati B
C2DDRA            = CIA_2+$02   ; Registro direzione dati A
C2DDRB            = CIA_2+$03   ; Registro direzione dati B
TI2ALO            = CIA_2+$04   ; Timer A (byte basso)
TI2AHI            = CIA_2+$05   ; Timer A (byte alto)
TI2BLO            = CIA_2+$06   ; Timer B (byte basso)
TI2BHI            = CIA_2+$07   ; Timer B (byte alto)
TO2TEN            = CIA_2+$08   ; Orologio Time-Of-Day (decimi di secondo)
TO2SEC            = CIA_2+$09   ; Orologio Time-Of-Day (secondi)
TO2MIN            = CIA_2+$0A   ; Orologio Time-Of-Day (minuti)
TO2HRS            = CIA_2+$0B   ; Orologio Time-Of-Day (ore)
CI2SDR            = CIA_2+$0C   ; Porta dati seriale
CI2ICR            = CIA_2+$0D   ; Registro di controllo interrupt
CI2CRA            = CIA_2+$0E   ; Registro di controllo A
CI2CRB            = CIA_2+$0F   ; Registro di controllo B
