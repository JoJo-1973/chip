; Video Display Controller (VDC)

; Opzioni: __C128_DCR = 1         Aggiunge il supporto per il registro extra usato nella versione del chip installata sul C128DCR

VDC               = $D600       ; Indirizzo di base del chip VDC

VDCADR            = VDC+$00     ; Registro di indirizzamento / stato
VDCDAT            = VDC+$01     ; Registro dati

; Registri interni del chip VDC
VDCHZT            = 0           ; Numero totale di colonne
VDCHZD            = 1           ; Numero visualizzato di colonne
VDCHZS            = 2           ; Posizione di sincronismo orizzontale
VDCSYW            = 3           ; Larghezza dei sincronismi orizzontale e verticale
VDCVET            = 4           ; Numero totale di righe
VDCVEA            = 5           ; Controllo fine della posizione verticale
VDCVED            = 6           ; Numero visualizzato di righe
VDCVES            = 7           ; Posizione di sincronismo verticale
VDCILC            = 8           ; Registro di controllo modalità interlacciata
VDCCTV            = 9           ; Numero di linne di scansione per carattere
VDCCSS            = 10          ; Registro di controllo del cursore
VDCCES            = 11          ; Linea finale di scansione del cursore
VDCDSH            = 12          ; Indirizzo di base della memoria schermo (alto)
VDCDSL            = 13          ; Indirizzo di base della memoria schermo (basso)
VDCCPH            = 14          ; Indirizzo della posizione del cursore (alto)
VDCCPL            = 15          ; Indirizzo della posizione del cursore (basso)
VDCLPV            = 16          ; Posizione verticale della penna ottica
VDCLPH            = 17          ; Posizione orizzontale della penna ottica
VDCUAH            = 18          ; Puntatore alla memoria video (alto)
VDCUAL            = 19          ; Puntatore alla memoria video (basso)
VDCATH            = 20          ; Indirizzo di base della memoria attributi (alto)
VDCATL            = 21          ; Indirizzo di base della memoria attributi (basso)
VDCHCP            = 22          ; Dimensione orizzontale dei caratteri
VDCVCP            = 23          ; Dimensione verticale dei caratteri
VDCMVS            = 24          ; Controllo fine dello scorrimento verticale
VDCMHS            = 25          ; Controllo fine dello scorrimento orizzontale
VDCCOL            = 26          ; Colore di sfondo e dei caratteri
VDCRIN            = 27          ; Incremento indirizzo per riga
VDCCSR            = 28          ; Indirizzo del set di caratteri
VDCUDL            = 29          ; Posizione della linea di sottolineatura
VDCWDC            = 30          ; Numero di byte (-1) per le operazioni di copia o scrittura
VDCDTA            = 31          ; Selettore di lettura / scrittura della memoria
VDCBLH            = 32          ; Indirizzo sorgente per la copia di blocchi di memoria (alto)
VDCBLL            = 33          ; Indirizzo sorgente per la copia di blocchi di memoria (basso)
VDCDEB            = 34          ; Posizione iniziale blanking orizzontale
VDCDEE            = 35          ; Posizione finale blanking orizzontale
VDCDRM            = 36          ; Numero di cicli di rinfresco memoria per linea di scansione

!ifdef __C128_DCR {
  VDCSYN          = 37          ; Polarità dei sincronismi orizzontale e verticale
}

; Codici colore del chip VDC

VDC_BLACK         = 0           ; Codice VDC del colore nero
VDC_DARK_GREY     = 1           ; Codice VDC del colore grigio scuro
VDC_DARK_BLUE     = 2           ; Codice VDC del colore blu scuro
VDC_LIGHT_BLUE    = 3           ; Codice VDC del colore blu chiaro
VDC_DARK_GREEN    = 4           ; Codice VDC del colore verde scuro
VDC_LIGHT_GREEN   = 5           ; Codice VDC del colore verde chiaro
VDC_DARK_CYAN     = 6           ; Codice VDC del colore ciano scuro
VDC_LIGHT_CYAN    = 7           ; Codice VDC del colore ciano chiaro
VDC_DARK_RED      = 8           ; Codice VDC del colore rosso scuro
VDC_LIGHT_RED     = 9           ; Codice VDC del colore rosso chiaro
VDC_DARK_PURPLE   = 10          ; Codice VDC del colore viola scuro
VDC_LIGHT_PURPLE  = 11          ; Codice VDC del colore viola chiaro
VDC_DARK_YELLOW   = 12          ; Codice VDC del colore giallo scuro
VDC_LIGHT_YELLOW  = 13          ; Codice VDC del colore giallo chiaro
VDC_LIGHT_GREY    = 14          ; Codice VDC del colore grigio chiaro
VDC_WHITE         = 15          ; Codice VDC del colore bianco

VDC_TRANSPARENT   = $FF         ; Valore fittizio usato per indicare che il registro colore non va alterato
