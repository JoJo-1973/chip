# chip

Simboli dei chip del Commodore 64, del C128 e del VIC-20: indirizzi dei registri e codici colore di CIA, REC, SID, VDC, VIC e VIC-II. La libreria `chip` fa parte della Libreria di Sistema (progetto `chip.c64`) ed è scritta in assembly 6510 per C64Studio (sintassi ACME).

Questo documento deriva dai sorgenti. I file contengono solo definizioni di simboli, nessun codice e nessun dato: per ogni dettaglio fanno fede i sorgenti, dove ogni simbolo ha il suo commento.

<a id="contenuto"></a>
## Contenuto

| Modulo | Gruppo | Descrizione |
|---|---|---|
| [`cia.asm`](#modulo-cia) | Complex Interface Adapter (CIA) #1 | Registri del primo chip CIA |
| | Complex Interface Adapter (CIA) #2 | Registri del secondo chip CIA |
| [`rec.asm`](#modulo-rec) | Registri | Registri del RAM Expansion Controller |
| [`sid.asm`](#modulo-sid) | Registri | Registri del Sound Interface Device |
| [`vdc.asm`](#modulo-vdc) | Registri | Registri di accesso del Video Display Controller |
| | Registri interni del chip VDC | Numeri dei registri interni |
| | Codici colore del chip VDC | Codici colore del VDC |
| [`vic.asm`](#modulo-vic) | Registri | Registri del chip VIC del VIC-20 |
| | Codici colore del chip VIC | Codici colore del VIC |
| [`vic_ii.asm`](#modulo-vic_ii) | Registri | Registri del chip VIC-II |
| | Codici colore del chip VIC-II | Codici colore del VIC-II |
| | Codici colore primario dei caratteri in modalità multicolore | Colori primari in modalità multicolore |
| | Codici colore per la selezione del colore di sfondo nella stampa in modo ECM | Selettori dei colori di sfondo ECM |
| | Codici PETSCII per la selezione del colore di sfondo nella stampa in modo ECM | Codici PETSCII dei colori di sfondo ECM |

## Uso

### Inclusione

La cartella `chip` sta nella cartella delle librerie di C64Studio, accanto alle altre librerie di sistema. Il sorgente principale del programma include i file di simboli che gli servono nella parte dedicata ai simboli, prima del codice:

```
!source <chip/cia.asm>, once
!source <chip/vic_ii.asm>, once
```

I file non includono altri file. Le altre librerie dichiarano i file di simboli che richiedono nelle `Dipendenze Esterne` dei contratti d'interfaccia.

### Configurazione

Due parti sono condizionate.

| Parametro | Modulo | Valore nel template | Effetto |
|---|---|---|---|
| `__C128_C64_MODE` | `vic_ii.asm` | `0` | 1 = aggiunge i registri extra del C128 (`XSCAN`, `CLKRATE`) |
| `__C128_DCR` | `vdc.asm` | `0` | 1 = aggiunge il registro extra del C128DCR (`VDCSYN`) |

I parametri si definiscono nella copia di `config.asm` della Soluzione e devono essere definiti prima dell'inclusione del modulo.

<a id="modulo-cia"></a>
## cia.asm

Registri dei due chip CIA (MOS 6526, Commodore 64 e C128). Ogni gruppo ha il simbolo dell'indirizzo di base e i sedici registri, definiti come base più spostamento.

| Gruppo | Base | Contenuto |
|---|---|---|
| CIA #1 | `CIA_1` (`$DC00`) | Da `CIAPRA` a `CIACRB` |
| CIA #2 | `CIA_2` (`$DD00`) | Da `CI2PRA` a `CI2CRB` |

[↑ Torna al contenuto](#contenuto)

<a id="modulo-rec"></a>
## rec.asm

Registri del RAM Expansion Controller (MOS 8726, Commodore 64 e C128): dall'indirizzo di base `REC` (`$DF00`), da `DMAST` a `DMAVER`.

[↑ Torna al contenuto](#contenuto)

<a id="modulo-sid"></a>
## sid.asm

Registri del Sound Interface Device (MOS 6581/8580, Commodore 64 e C128): dall'indirizzo di base `SID` (`$D400`), da `FRELO1` a `ENV3`. Comprendono i registri delle tre voci (`1`, `2` e `3` in fondo al nome), quelli del filtro e del volume, la posizione dei paddle (`POTX`, `POTY`) e le uscite dell'oscillatore e dell'inviluppo della voce #3 (`RANDOM`, `ENV3`).

[↑ Torna al contenuto](#contenuto)

<a id="modulo-vdc"></a>
## vdc.asm

Registri e codici colore del Video Display Controller (MOS 8563/8568, Commodore 128). Con `__C128_DCR = 1` il file aggiunge il registro extra usato nella versione del chip installata sul C128DCR.

| Gruppo | Contenuto |
|---|---|
| Registri | `VDC` (`$D600`), `VDCADR` (registro di indirizzamento / stato) e `VDCDAT` (registro dati) |
| Registri interni del chip VDC | Numeri dei registri interni, da `VDCHZT` (0) a `VDCDRM` (36); con `__C128_DCR = 1` anche `VDCSYN` (37) |
| Codici colore del chip VDC | Da `VDC_BLACK` (`$00`) a `VDC_WHITE` (`$0F`), più `VDC_TRANSPARENT` (`$FF`), valore fittizio che indica che il registro colore non va alterato |

[↑ Torna al contenuto](#contenuto)

<a id="modulo-vic"></a>
## vic.asm

Registri e codici colore del chip VIC (MOS 6560/6561, Commodore VIC-20).

| Gruppo | Contenuto |
|---|---|
| Registri | Dall'indirizzo di base `VIC` (`$9000`), da `VICCRO` a `VICCRF` |
| Codici colore del chip VIC | Da `VIC_BLACK` (`$00`) a `VIC_LIGHT_YELLOW` (`$0F`), più `VIC_TRANSPARENT` (`$FF`), valore fittizio che indica che il registro colore non va alterato |

[↑ Torna al contenuto](#contenuto)

<a id="modulo-vic_ii"></a>
## vic_ii.asm

Registri e codici colore del chip VIC-II (MOS 6567/6569, Commodore 64 e C128). Con `__C128_C64_MODE = 1` il file aggiunge i registri extra usati nella versione del chip installata sul C128.

| Gruppo | Contenuto |
|---|---|
| Registri | Dall'indirizzo di base `VIC` (`$D000`), da `SP0X` a `SP7COL` (`$D02E`); con `__C128_C64_MODE = 1` anche `XSCAN` (`$D02F`) e `CLKRATE` (`$D030`) |
| Codici colore del chip VIC-II | Da `VIC_BLACK` (`$00`) a `VIC_LIGHT_GREY` (`$0F`) |
| Codici colore primario dei caratteri in modalità multicolore | Da `VIC_MC_BLACK` a `VIC_MC_YELLOW`: il codice del colore con il bit #3 a 1; segue `VIC_TRANSPARENT` (`$FF`), valore fittizio che indica che il registro colore non va alterato |
| Codici colore per la selezione del colore di sfondo nella stampa in modo ECM | Da `VIC_BG0` a `VIC_BG3` (da `$00` a `$03`) |
| Codici PETSCII per la selezione del colore di sfondo nella stampa in modo ECM | Da `ECM_BG0` a `ECM_BG3` (da `$01` a `$04`) |

[↑ Torna al contenuto](#contenuto)

<a id="limiti-noti"></a>
## Limiti noti

- `vic.asm` e `vic_ii.asm` definiscono gli stessi simboli (`VIC`, `VIC_BLACK`, `VIC_WHITE`, `VIC_TRANSPARENT` e altri), alcuni con valori diversi (per esempio `VIC`): un programma include l'uno o l'altro, non entrambi.

[↑ Torna al contenuto](#contenuto)
