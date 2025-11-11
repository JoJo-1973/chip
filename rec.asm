; RAM Expansion Controller (REC)

!ifndef __REC__ {
__REC__           = 1

REC               = $DF00       ; Indirizzo di base del chip REC

DMAST             = REC+$00     ; Registro di stato del chip REC
DMACMD            = REC+$01     ; Registro di comando del chip REC
DMAADL            = REC+$02     ; Indirizzo di base della memoria di sistema (byte basso)
DMAADH            = REC+$03     ; Indirizzo di base della memoria di sistema (byte alto)
DMALO             = REC+$04     ; Indirizzo di base della memoria di espansione (byte basso)
DMAHI             = REC+$05     ; Indirizzo di base della memoria di espansione (byte alto)
DMABNK            = REC+$06     ; Selettore del banco di memoria di espansione
DMADAL            = REC+$07     ; Numero di byte da trasferire (byte basso)
DMADAH            = REC+$08     ; Numero di byte da trasferire (byte alto)
DMASUM            = REC+$09     ; Registro di controllo delle interruzioni
DMAVER            = REC+$0A     ; Registro di controllo degli indirizzamenti

}