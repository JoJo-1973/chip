# chip

Simboli e utilità dei chip del Commodore 64, del C128 e del VIC-20: indirizzi dei registri e codici colore di CIA, REC, SID, VDC, VIC e VIC-II, interruzioni NMI e di raster, modi grafici del VIC-II. La libreria `chip` fa parte della Libreria di Sistema (progetto `chip.c64`) ed è scritta in assembly 6510 per C64Studio (sintassi ACME).

Questo documento deriva dai sorgenti. Per ogni dettaglio fanno fede i contratti d'interfaccia nelle intestazioni delle macro e delle subroutine.

<a id="contenuto"></a>
## Contenuto

| Modulo | Utilità | Descrizione |
|---|---|---|
| [`cia.asm`](#modulo-cia) | Complex Interface Adapter (CIA) #1 | Registri del primo chip CIA |
| | Complex Interface Adapter (CIA) #2 | Registri del secondo chip CIA |
| [`nmi_tools.asm`](#modulo-nmi_tools) | [`NMI_HIBASE`](#utilita-nmi_hibase) | Resetta HIBASE dopo RUN/STOP + RESTORE |
| | [`NMI_RESTORE`](#utilita-nmi_restore) | Ripristina il vettore NMI originale |
| [`raster_tools.asm`](#modulo-raster_tools) | [`m_Init_Raster_System`](#utilita-m_init_raster_system) | Prepara il sistema ai Raster IRQ |
| | [`m_Start_Raster_IRQ`](#utilita-m_start_raster_irq) | Avvia una catena di Raster IRQ |
| | [`m_Enter_Raster_IRQ`](#utilita-m_enter_raster_irq) | Entra in un gestore Raster IRQ |
| | [`m_Next_Raster_IRQ`](#utilita-m_next_raster_irq) | Prepara il prossimo Raster IRQ, esce |
| | [`m_Set_Rasterline`](#utilita-m_set_rasterline) | Imposta la linea di raster di confronto |
| | [`m_Raster_Grip`](#utilita-m_raster_grip) | Compensa i cicli extra del VIC-II NTSC |
| | [`m_Start_Unstable_IRQ`](#utilita-m_start_unstable_irq) | Avvia una catena di IRQ instabili |
| | [`m_Enter_Unstable_IRQ`](#utilita-m_enter_unstable_irq) | Entra in un gestore IRQ instabile |
| | [`m_Next_Unstable_IRQ`](#utilita-m_next_unstable_irq) | Prepara il prossimo IRQ instabile, esce |
| | [`m_Start_Stable_IRQ`](#utilita-m_start_stable_irq) | Avvia una catena di IRQ stabili |
| | [`m_Enter_Stable_IRQ`](#utilita-m_enter_stable_irq) | Entra in un gestore IRQ stabile |
| | [`m_Next_Stable_IRQ`](#utilita-m_next_stable_irq) | Prepara il prossimo IRQ stabile, esce |
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
| [`vic_ii_tools.asm`](#modulo-vic_ii_tools) | [`m_VIC_Bitmap_On`](#utilita-m_vic_bitmap_on) | Abilita il modo bitmap |
| | [`m_VIC_Bitmap_Off`](#utilita-m_vic_bitmap_off) | Disabilita il modo bitmap |
| | [`m_VIC_Ext_Color_On`](#utilita-m_vic_ext_color_on) | Abilita il modo ECM |
| | [`m_VIC_Ext_Color_Off`](#utilita-m_vic_ext_color_off) | Disabilita il modo ECM |
| | [`m_VIC_Multicolor_On`](#utilita-m_vic_multicolor_on) | Abilita il modo multicolore |
| | [`m_VIC_Multicolor_Off`](#utilita-m_vic_multicolor_off) | Disabilita il modo multicolore |
| | [`VIC_PALETTE`](#utilita-vic_palette) | Imposta i registri colore del VIC-II |
| | [`VIC_BANK`](#utilita-vic_bank) | Seleziona il banco di memoria del VIC-II |
| | [`VIC_SCREEN`](#utilita-vic_screen) | Posiziona la memoria schermo |
| | [`VIC_CHARGEN`](#utilita-vic_chargen) | Posiziona il generatore di caratteri |
| | [`VIC_BITMAP`](#utilita-vic_bitmap) | Posiziona la memoria ad alta risoluzione |
| | [`VIC_COPY_CHARGEN`](#utilita-vic_copy_chargen) | Sposta il generatore di caratteri in RAM |
| | [`COMPUTE_CELL_ADDRESS`](#utilita-compute_cell_address) | Calcola l'indirizzo di una cella video |
| | [`GET_SCREEN_CELL`](#utilita-get_screen_cell) | Legge una cella della memoria schermo |
| | [`GET_COLOR_CELL`](#utilita-get_color_cell) | Legge una cella della memoria colore |

## Uso

### Inclusione

La cartella `chip` sta nella cartella delle librerie di C64Studio, accanto alle altre librerie di sistema. Il sorgente principale del programma include i file di simboli che usa nella parte dedicata ai simboli e i moduli con codice nella parte dedicata al codice:

```
!source <chip/cia.asm>, once
!source <chip/vic_ii.asm>, once
!source <chip/vic_ii_tools.asm>, once
```

La libreria non ha un modulo principale: ogni modulo si include da sé e nessun modulo include altri file. Gli altri file che un modulo richiede arrivano dal programma, che li include prima, nella parte dedicata ai simboli (ultima colonna):

| Modulo | Include da sé | File da includere prima |
|---|---|---|
| `cia.asm` | Nessuno | Nessuno |
| `nmi_tools.asm` | Nessuno | `<c64/symbols.asm>` |
| `raster_tools.asm` | Nessuno | `<c64/symbols.asm>`, `<chip/cia.asm>`, `<chip/vic_ii.asm>`, `<system/6510_tools.asm>`, `<system/standard.asm>` |
| `rec.asm` | Nessuno | Nessuno |
| `sid.asm` | Nessuno | Nessuno |
| `vdc.asm` | Nessuno | Nessuno |
| `vic.asm` | Nessuno | Nessuno |
| `vic_ii.asm` | Nessuno | Nessuno |
| `vic_ii_tools.asm` | Nessuno | `<c64/symbols.asm>`, `<chip/cia.asm>`, `<chip/vic_ii.asm>`, `<system/6510_tools.asm>`, `<system/branch.asm>` |

### Configurazione

Le macro si assemblano quando vengono invocate. Ogni subroutine viene assemblata solo se il suo parametro vale `1` nella copia di `config.asm` della Soluzione. Nel template tutti i parametri valgono `0`.

| Parametro | Subroutine | Richiede anche |
|---|---|---|
| `__USE_NMI_HIBASE` | `NMI_HIBASE` |  |
| `__USE_NMI_RESTORE` | `NMI_RESTORE` |  |
| `__USE_VIC_PALETTE` | `VIC_PALETTE` |  |
| `__USE_VIC_BANK` | `VIC_BANK` |  |
| `__USE_VIC_SCREEN` | `VIC_SCREEN` | `__USE_VIC_BANK` |
| `__USE_VIC_CHARGEN` | `VIC_CHARGEN` | `__USE_VIC_BANK` |
| `__USE_VIC_BITMAP` | `VIC_BITMAP` | `__USE_VIC_BANK` |
| `__USE_VIC_COPY_CHARGEN` | `VIC_COPY_CHARGEN` | `__USE_VIC_CHARGEN` |
| `__USE_COMPUTE_CELL_ADDRESS` | `COMPUTE_CELL_ADDRESS` |  |
| `__USE_GET_SCREEN_CELL` | `GET_SCREEN_CELL` | `__USE_COMPUTE_CELL_ADDRESS` |
| `__USE_GET_COLOR_CELL` | `GET_COLOR_CELL` | `__USE_COMPUTE_CELL_ADDRESS` |

Due parti dei file di simboli sono condizionate.

| Parametro | Modulo | Valore nel template | Effetto |
|---|---|---|---|
| `__C128_C64_MODE` | `vic_ii.asm` | `0` | 1 = aggiunge i registri extra del C128 (`XSCAN`, `CLKRATE`) |
| `__C128_DCR` | `vdc.asm` | `0` | 1 = aggiunge il registro extra del C128DCR (`VDCSYN`) |

I parametri si definiscono nella copia di `config.asm` della Soluzione e devono essere definiti prima dell'inclusione del modulo.

Punti di personalizzazione usati dalla libreria, definiti anch'essi in `config.asm`:

| Punto di personalizzazione | Usato da | Valore nel template | Significato |
|---|---|---|---|
| `__DISABLE_KERNAL` | `NMI_HIBASE`, `NMI_RESTORE`, `m_Init_Raster_System`, `m_Start_Raster_IRQ`, `m_Enter_Raster_IRQ`, `m_Next_Raster_IRQ`, `m_Start_Unstable_IRQ`, `m_Enter_Unstable_IRQ`, `m_Next_Unstable_IRQ`, `m_Start_Stable_IRQ`, `m_Enter_Stable_IRQ`, `m_Next_Stable_IRQ` | `0` | Kernal disabilitato (1: tutta RAM; 0: Kernal attivo) |
| `__VIC_MODEL` | `m_Init_Raster_System`, `m_Raster_Grip`, `m_Enter_Stable_IRQ` | `$04` | Cella in ZP: modello di VIC-II rilevato |

<a id="modulo-cia"></a>
## cia.asm

Registri dei due chip CIA (MOS 6526, Commodore 64 e C128). Ogni gruppo ha il simbolo dell'indirizzo di base e i sedici registri, definiti come base più spostamento.

| Gruppo | Base | Contenuto |
|---|---|---|
| CIA #1 | `CIA_1` (`$DC00`) | Da `CIAPRA` a `CIACRB` |
| CIA #2 | `CIA_2` (`$DD00`) | Da `CI2PRA` a `CI2CRB` |

[↑ Torna al contenuto](#contenuto)

<a id="modulo-nmi_tools"></a>
## nmi_tools.asm

Utilità per la gestione delle interruzioni non mascherabili.

<a id="utilita-nmi_hibase"></a>
### NMI_HIBASE

Dopo un RUN/STOP + RESTORE il VIC-II viene riconfigurato con i valori di default, ma la variabile di sistema `HIBASE` non viene reinizializzata. Questa subroutine risolve il problema inserendosi nella subroutine di interrupt NMI.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | Nessuno |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `NMIVEC` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-nmi_restore"></a>
### NMI_RESTORE

Ripristina il vettore NMI originale, annullando le modifiche apportate da `NMI_HIBASE`.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | Nessuno |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `NMIVEC` |

[↑ Torna al contenuto](#contenuto)

<a id="modulo-raster_tools"></a>
## raster_tools.asm

Macro di utilità per la definizione di interruzioni di raster concatenate, sia stabili che instabili. Non adatte per codici iper-ottimizzati. Supportano tutte le versioni del chip VIC-II, sia PAL che NTSC.

Requisiti di pagina zero: `__VIC_MODEL`.

<a id="utilita-m_init_raster_system"></a>
### m_Init_Raster_System

Disabilita tutte le sorgenti di interruzioni legate ai chip CIA ed attiva UNICAMENTE le interruzioni dovute al raster. Dato che tutte le altre interruzioni sono disabilitate, la gestione della tastiera e dell'I/O seriale sono demandate alla responsabilità del programmatore. La macro determina anche il tipo di chip VIC-II installato sul computer sul quale sta girando: un codice identificativo viene conservato nella locazione rappresentata dal punto di configurazione `__VIC_MODEL`. Il significato del codice è il seguente:

```
$00 = PAL       63 cicli per linea
$40 = Old NTSC  64 cicli per linea
$C0 = New NTSC  65 cicli per linea
```

La macro `m_Raster_Grip` fa uso di questa informazione per iniettare nel codice 1 o 2 cicli extra di temporizzazione in base alla versione rilevata del chip VIC-II.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `__VIC_MODEL` (1 byte, ZP): Modello di VIC-II (vedi Descrizione)<br>Interrupt (1 bit, .P): sempre 1 |
| Registri Modificati | `.A`, `.X`, `.Y`, `.P` (Negative, oVerflow, Interrupt, Zero, Carry), `__VIC_MODEL`, `CIAICR`, `CI2ICR`, `VICIRQ`, `IRQMSK`, `R6510` (se `__DISABLE_KERNAL` = 1) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_start_raster_irq"></a>
### m_Start_Raster_IRQ

Chiamata: `+m_Start_Raster_IRQ .stable_, .rasterline_, .irq_handler_`

Questa macro inizia una catena di interruzioni di raster: il primo interrupt della catena può essere sia di tipo stabile che instabile. Questa macro si limita solo a richiamare le macro `m_Start_Stable_IRQ` e `m_Start_Unstable_IRQ` che si occupano dell'effettiva realizzazione dell'interruzione.

| Voce | Contenuto |
|---|---|
| Input | `.stable_` (stringa, Macro): `"STABLE"` = stabile, altro = instabile<br>`.rasterline_` (2 byte, Macro): Linea di raster desiderata<br>`.irq_handler_` (2 byte, Macro): Indirizzo del gestore dell'interruzione |
| Output | Interrupt (1 bit, .P): sempre 0 |
| Registri Modificati | `.A`, `.P` (Negative, Interrupt, Zero), `RASTER`, `SCROLY`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_enter_raster_irq"></a>
### m_Enter_Raster_IRQ

Chiamata: `+m_Enter_Raster_IRQ .stable_, .rasterline_`

La macro va obbligatoriamente invocata come prima istruzione del gestore delle interruzioni di raster. Questa macro si limita solo a richiamare le macro `m_Enter_Stable_IRQ` e `m_Enter_Unstable_IRQ` che si occupano dell'effettiva realizzazione.

| Voce | Contenuto |
|---|---|
| Input | `.stable_` (stringa, Macro): `"STABLE"` = stabile, altro = instabile<br>`.rasterline_` (2 byte, Macro): Linea di raster (solo se stabile) |
| Output | Interrupt (1 bit, .P): 0 = stabile; 1 = instabile |
| Variazione Stack | Decrementato di 3 byte |
| Registri Modificati | `.A`, `.X`, `.Y`, `.P` (Negative, oVerflow, Interrupt, Zero, Carry), `RASTER`, `SCROLY`, `VICIRQ`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_next_raster_irq"></a>
### m_Next_Raster_IRQ

Chiamata: `+m_Next_Raster_IRQ .stable_, .rasterline_, .irq_handler_, .fast_exit_`

La macro va obbligatoriamente invocata come ultima istruzione del gestore delle interruzioni di raster. Questa macro si limita solo a richiamare le macro `m_Next_Stable_IRQ` e `m_Next_Unstable_IRQ` che si occupano dell'effettiva realizzazione. Affinché la catena di interruzioni di raster sia ben formata è responsabilità del programmatore che l'ultimo anello della catena richiami il primo gestore, quello definito dalla macro `m_Start_Raster_IRQ`. Il parametro `.fast_exit_` è ignorato se `__DISABLE_KERNAL` = 1.

| Voce | Contenuto |
|---|---|
| Input | `.stable_` (stringa, Macro): `"STABLE"` = stabile, altro = instabile<br>`.rasterline_` (2 byte, Macro): Linea di raster del prossimo IRQ<br>`.irq_handler_` (2 byte, Macro): Indirizzo del gestore del prossimo IRQ<br>`.fast_exit_` (stringa, Macro): `"FAST"` = `IRQMIN`, altro = `IRQHND` |
| Output | `.PC` (2 byte, CPU): Uscita con rti o salto a `IRQMIN`/`IRQHND` |
| Variazione Stack | Incrementato di 6 byte |
| Registri Modificati | `.A`, `.P` (Negative, Interrupt, Zero), `RASTER`, `SCROLY`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_set_rasterline"></a>
### m_Set_Rasterline

Chiamata: `+m_Set_Rasterline .rasterline_`

Macro di supporto per il settaggio del registro `RASTER` del chip VIC-II. La macro viene eseguita in tempo costante (16 cicli) e gestisce correttamente il settaggio del bit #9.

| Voce | Contenuto |
|---|---|
| Input | `.rasterline_` (2 byte, Macro): Linea di raster (9 bit, costante) |
| Output | Nessuno |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `RASTER`, `SCROLY` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_raster_grip"></a>
### m_Raster_Grip

Macro per la sincronizzazione del raster in maniera indipendente dall'hardware: siccome le 3 versioni esistenti del chip VIC-II (PAL, Old NTSC e New NTSC) producono una linea di raster in 63, 64 e 65 cicli rispettivamente, è necessario che il codice di sincronizzazione consumi 1 o 2 cicli di ritardo in più qualora l'hardware lo imponga. È pertanto obbligatorio che questa macro venga eseguita solo dopo l'esecuzione della macro `m_Init_Raster_System` che si occuperà dell'identificazione del chip VIC-II. La macro consuma 7 cicli su hardware PAL, 8 cicli su hardware Old NTSC e 9 cicli su hardware New NTSC. Nei calcoli di temporizzazione il programmatore dovrà sempre assumere che la linea di raster venga disegnata in 63 cicli (PAL) e che `m_Raster_Grip` duri 7 cicli: l'implementazione interna garantirà la coerenza dei calcoli in caso di hardware NTSC.

| Voce | Contenuto |
|---|---|
| Input | `__VIC_MODEL` (1 byte, ZP): Modello VIC-II (vedi `m_Init_Raster_System`) |
| Output | Nessuno |
| Registri Modificati | `.P` (Negative, oVerflow, Zero) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_start_unstable_irq"></a>
### m_Start_Unstable_IRQ

Chiamata: `+m_Start_Unstable_IRQ .rasterline_, .irq_handler_`

La macro inizializza il vettore IRQ, la cui locazione differisce in dipendenza dallo stato di attivazione del Kernal, con l'indirizzo di partenza del gestore delle interruzioni poi imposta la linea di raster alla quale far scattare l'interruzione e ripristina il flag di Interrupt.

| Voce | Contenuto |
|---|---|
| Input | `.rasterline_` (2 byte, Macro): Linea di raster desiderata<br>`.irq_handler_` (2 byte, Macro): Indirizzo del gestore dell'interruzione |
| Output | Interrupt (1 bit, .P): sempre 0 |
| Registri Modificati | `.A`, `.P` (Negative, Interrupt, Zero), `RASTER`, `SCROLY`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_enter_unstable_irq"></a>
### m_Enter_Unstable_IRQ

La macro implementa le buone pratiche da seguire all'esecuzione di un gestore delle interruzioni: se il Kernal è disabilitato provvede a salvare i registri `.A`, `.X` e `.Y` sullo stack (se il Kernal è abilitato questa operazione viene svolta in automatico) e poi altera il registro `VICIRQ` per segnalare l'avvenuto riconoscimento dell'interruzione.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | Interrupt (1 bit, .P): sempre 1 |
| Variazione Stack | Decrementato di 3 byte |
| Registri Modificati | `.A` (se `__DISABLE_KERNAL` = 1), `.P` (Negative, Zero, Carry), `VICIRQ` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_next_unstable_irq"></a>
### m_Next_Unstable_IRQ

Chiamata: `+m_Next_Unstable_IRQ .rasterline_, .irq_handler_, .fast_exit_`

La macro implementa le buone pratiche da seguire all'uscita di un gestore delle interruzioni: il vettore IRQ (tenendo conto dello stato di attivazione del Kernal) viene impostato all'indirizzo del prossimo anello della catena, idem per la linea di raster alla quale dovrà essere eseguito e poi si provvede a ripristinare lo stack: se il Kernal è abilitato si salta a `IRQMIN` (nel caso si desideri un'uscita "fast") o a `IRQHND` (se si desiderà un'uscita "slow" che scansioni la tastiera, aggiorni i timer, eccetera). Se invece il Kernal è disabilitato non vi sono alternative: l'uscita sarà sempre "fast" ed il ripristino sarà realizzato mediante apposito codice in-line.

| Voce | Contenuto |
|---|---|
| Input | `.rasterline_` (2 byte, Macro): Linea di raster del prossimo IRQ<br>`.irq_handler_` (2 byte, Macro): Indirizzo del gestore del prossimo IRQ<br>`.fast_exit_` (stringa, Macro): `"FAST"` = `IRQMIN`, altro = `IRQHND` |
| Output | `.PC` (2 byte, CPU): Uscita con rti o salto a `IRQMIN`/`IRQHND` |
| Variazione Stack | Incrementato di 6 byte |
| Registri Modificati | `.A`, `.P` (Negative, Interrupt, Zero), `RASTER`, `SCROLY`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_start_stable_irq"></a>
### m_Start_Stable_IRQ

Chiamata: `+m_Start_Stable_IRQ .rasterline_, .irq_handler_`

La macro inizializza il vettore IRQ, la cui locazione differisce in dipendenza dallo stato di attivazione del Kernal, con l'indirizzo di partenza del gestore delle interruzioni poi imposta la linea di raster (vedi sotto) alla quale far scattare l'interruzione e ripristina il flag di Interrupt. Per ottenere la stabilizzazione dell'interruzione di raster si utilizza la tecnica del doppio interrupt: questa macro serve ad impostare con congruo anticipo (3 linee di raster) il primo dei due.

IMPORTANTE: la macro presuppone che (`.rasterline_`-3) non corrisponda ad una "badline". In caso contrario i calcoli di temporizzazione su cui si basa il processo di sincronizzazione non saranno validi, con effetti imprevedibili.

| Voce | Contenuto |
|---|---|
| Input | `.rasterline_` (2 byte, Macro): Linea di raster desiderata<br>`.irq_handler_` (2 byte, Macro): Indirizzo del gestore dell'interruzione |
| Output | Interrupt (1 bit, .P): sempre 0 |
| Registri Modificati | `.A`, `.P` (Negative, Interrupt, Zero), `RASTER`, `SCROLY`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_enter_stable_irq"></a>
### m_Enter_Stable_IRQ

Chiamata: `+m_Enter_Stable_IRQ .rasterline_`

La macro implementa la seconda parte della tecnica di stabilizzazione del raster mediante doppio interrupt. Per prima cosa si effettuano le operazioni di riconoscimento del primo interrupt secondo le buone pratiche descritte in `m_Enter_Unstable_IRQ` impostando il secondo interrupt in modo che scatti a `.rasterline_`-1 (il codice di sincronizzazione parte dall'etichetta @Sync); le operazioni differiscono in base allo stato di attivazione del Kernal. Il tempo rimanente viene impiegato per salvare il valore di `.S`, dopodiché si consumano cicli in attesa che scatti il secondo interrupt mentre si eseguono istruzioni di durata nota. Il secondo interrupt procede a bruciare cicli (il numero dipende dallo stato di attivazione del Kernal) per eseguire un'operazione di comparazione esattamente al ciclo 59 o 60. Un'operazione di salto fittizia brucerà 2 oppure 3 cicli a seconda del risultato della comparazione garantendo che l'istruzione successiva venga eseguita con certezza al ciclo 3 della linea di raster `.rasterline_`, stabilizzando così il raster!

IMPORTANTE: la macro presuppone che (`.rasterline_`-1) non corrisponda ad una "badline". In caso contrario i calcoli di temporizzazione su cui si basa il processo di sincronizzazione non saranno validi, con effetti imprevedibili.

ATTENZIONE: codice automodificante indicato con (!!!)

| Voce | Contenuto |
|---|---|
| Input | `.rasterline_` (2 byte, Macro): Linea di raster desiderata<br>`__VIC_MODEL` (1 byte, ZP): Modello VIC-II (vedi `m_Init_Raster_System`) |
| Output | Interrupt (1 bit, .P): sempre 0 |
| Variazione Stack | Decrementato di 3 byte |
| Registri Modificati | `.A`, `.X`, `.Y`, `.P` (Negative, oVerflow, Interrupt, Zero, Carry), `RASTER`, `SCROLY`, `VICIRQ`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_next_stable_irq"></a>
### m_Next_Stable_IRQ

Chiamata: `+m_Next_Stable_IRQ .rasterline_, .irq_handler_, .fast_exit_`

La macro implementa le buone pratiche da seguire all'uscita di un gestore delle interruzioni: il vettore IRQ (tenendo conto dello stato di attivazione del Kernal) viene impostato all'indirizzo del prossimo anello della catena, idem per la linea di raster alla quale dovrà essere eseguito e poi si provvede a ripristinare lo stack: se il Kernal è abilitato si salta a `IRQMIN` (nel caso si desideri un'uscita "fast") o a `IRQHND` (se si desiderà un'uscita "slow" che scansioni la tastiera, aggiorni i timer, eccetera). Se invece il Kernal è disabilitato non vi sono alternative: l'uscita sarà sempre "fast" ed il ripristino sarà realizzato mediante apposito codice in-line. Siccome la macro presuppone che il prossimo anello della catena sarà ancora un IRQ stabile, la prossima linea di raster sarà impostata a `.rasterline_`-3, coerentemente con quanto fatto da `m_Start_Stable_IRQ`.

| Voce | Contenuto |
|---|---|
| Input | `.rasterline_` (2 byte, Macro): Linea di raster del prossimo IRQ<br>`.irq_handler_` (2 byte, Macro): Indirizzo del gestore del prossimo IRQ<br>`.fast_exit_` (stringa, Macro): `"FAST"` = `IRQMIN`, altro = `IRQHND` |
| Output | `.PC` (2 byte, CPU): Uscita con rti o salto a `IRQMIN`/`IRQHND` |
| Variazione Stack | Incrementato di 6 byte |
| Registri Modificati | `.A`, `.P` (Negative, Interrupt, Zero), `RASTER`, `SCROLY`, `IRBVEC` (se `__DISABLE_KERNAL` = 1), `CINV` (se `__DISABLE_KERNAL` = 0) |

[↑ Torna al contenuto](#contenuto)

<a id="modulo-rec"></a>
## rec.asm

Registri del RAM Expansion Controller (MOS 8726, Commodore 64 e C128): dall'indirizzo di base `REC` (`$DF00`), da `DMAST` a `DMAVER`.

| Gruppo | Simboli | Contenuto |
|---|---|---|
| Registri | 12 | Da `REC` (`$DF00`) a `DMAVER` (`REC+$0A`) |

[↑ Torna al contenuto](#contenuto)

<a id="modulo-sid"></a>
## sid.asm

Registri del Sound Interface Device (MOS 6581/8580, Commodore 64 e C128): dall'indirizzo di base `SID` (`$D400`), da `FRELO1` a `ENV3`. Comprendono i registri delle tre voci (`1`, `2` e `3` in fondo al nome), quelli del filtro e del volume, la posizione dei paddle (`POTX`, `POTY`) e le uscite dell'oscillatore e dell'inviluppo della voce #3 (`RANDOM`, `ENV3`).

| Gruppo | Simboli | Contenuto |
|---|---|---|
| Registri | 30 | Da `SID` (`$D400`) a `ENV3` (`SID+$1C`) |

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

[↑ Torna al contenuto](#contenuto)

<a id="modulo-vic_ii_tools"></a>
## vic_ii_tools.asm

Utilità per la gestione dei modi grafici offerti dal chip VIC-II.

<a id="utilita-m_vic_bitmap_on"></a>
### m_VIC_Bitmap_On

Abilita la modalità grafica bitmap impostando il bit #5 di `SCROLY`.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `SCROLY` (1 byte, I/O): Bit #5 a 1 |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `SCROLY` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_vic_bitmap_off"></a>
### m_VIC_Bitmap_Off

Disabilita la modalità grafica bitmap azzerando il bit #5 di `SCROLY`.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `SCROLY` (1 byte, I/O): Bit #5 a 0 |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `SCROLY` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_vic_ext_color_on"></a>
### m_VIC_Ext_Color_On

Abilita il modo Colore di Sfondo Esteso (ECM) impostando il bit #6 di `SCROLY`.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `SCROLY` (1 byte, I/O): Bit #6 a 1 |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `SCROLY` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_vic_ext_color_off"></a>
### m_VIC_Ext_Color_Off

Disabilita il modo Colore di Sfondo Esteso (ECM) azzerando il bit #6 di `SCROLY`.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `SCROLY` (1 byte, I/O): Bit #6 a 0 |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `SCROLY` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_vic_multicolor_on"></a>
### m_VIC_Multicolor_On

Abilita la modalità grafica multicolore impostando il bit #4 di `SCROLX`.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `SCROLX` (1 byte, I/O): Bit #4 a 1 |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `SCROLX` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-m_vic_multicolor_off"></a>
### m_VIC_Multicolor_Off

Disabilita la modalità grafica multicolore azzerando il bit #4 di `SCROLX`.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `SCROLX` (1 byte, I/O): Bit #4 a 0 |
| Registri Modificati | `.A`, `.P` (Negative, Zero), `SCROLX` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-vic_palette"></a>
### VIC_PALETTE

Imposta i colori di bordo, sfondo, carattere, multicolore/colore esteso e multicolore/sprite in un'unica operazione. L'indirizzo in `.XA` punta ad un blocco di memoria che contiene in successione i valori da assegnare ai registri `EXTCOL`, `BGCOL0`, `BGCOL1`, `BGCOL2`, `BGCOL3`, `SPMC0`, `SPMC1` e `COLOR`. Se il valore è `VIC_TRANSPARENT` il registro resta immutato.

| Voce | Contenuto |
|---|---|
| Input | `.A` (1 byte, CPU): Indirizzo del blocco di memoria (byte basso)<br>`.X` (1 byte, CPU): Indirizzo del blocco di memoria (byte alto)<br>`blocco` (8 byte, RAM): Valori per `EXTCOL`, `BGCOL0`, `BGCOL1`, `BGCOL2`, `BGCOL3`, `SPMC0`, `SPMC1` e `COLOR`, in quest'ordine |
| Output | `EXTCOL` (1 byte, I/O): Colore del bordo (se non è `VIC_TRANSPARENT`)<br>`BGCOL0` (1 byte, I/O): Colore dello sfondo (se non è `VIC_TRANSPARENT`)<br>`BGCOL1` (1 byte, I/O): Colore di sfondo 1 (se non è `VIC_TRANSPARENT`)<br>`BGCOL2` (1 byte, I/O): Colore di sfondo 2 (se non è `VIC_TRANSPARENT`)<br>`BGCOL3` (1 byte, I/O): Colore di sfondo 3 (se non è `VIC_TRANSPARENT`)<br>`SPMC0` (1 byte, I/O): Colore comune degli sprite multicolori 0 (se non è `VIC_TRANSPARENT`)<br>`SPMC1` (1 byte, I/O): Colore comune degli sprite multicolori 1 (se non è `VIC_TRANSPARENT`)<br>`COLOR` (1 byte, RAM): Colore dei caratteri (se non è `VIC_TRANSPARENT`) |
| Registri Modificati | `.A`, `.Y`, `.P` (Negative, Zero), `INDEX2`, `EXTCOL`, `BGCOL0`, `BGCOL1`, `BGCOL2`, `BGCOL3`, `SPMC0`, `SPMC1`, `COLOR` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-vic_bank"></a>
### VIC_BANK

Imposta o recupera l'indirizzo iniziale del banco di memoria da 16 kB visibile dal chip VIC-II.

```
C = 0: .A contiene la pagina iniziale del banco da
       selezionare, che può essere $00, $40, $80 oppure
       $C0. Valori differenti vengono allineati al limite
       inferiore.
C = 1: Il valore della pagina iniziale del banco di memoria
       viene restituito in .A.
```

| Voce | Contenuto |
|---|---|
| Input | `.A` (1 byte, CPU): Pagina iniziale del banco (solo se C = 0)<br>Carry (1 bit, .P): 0 = imposta; 1 = legge |
| Output | `.A` (1 byte, CPU): Pagina iniziale del banco (solo se C = 1)<br>`C2DDRA` (1 byte, I/O): Porte di selezione in uscita (solo se C = 0)<br>`CI2PRA` (1 byte, I/O): Selezione del banco (solo se C = 0) |
| Registri Modificati | `.A`, `.P` (Negative, Zero, Carry), `C2DDRA`, `CI2PRA` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-vic_screen"></a>
### VIC_SCREEN

Imposta o recupera l'indirizzo iniziale della memoria schermo.

```
C = 0: .A contiene la pagina iniziale della memoria schermo,
       che può variare da $00 a $FC ad intervalli di $04.
       Valori differenti vengono allineati al limite
       inferiore.
C = 1: Il valore della pagina iniziale della memoria schermo
       viene restituito in .A.
```

| Voce | Contenuto |
|---|---|
| Input | `.A` (1 byte, CPU): Pagina iniziale della memoria schermo (C = 0)<br>Carry (1 bit, .P): 0 = imposta; 1 = legge |
| Output | `.A` (1 byte, CPU): Pagina iniziale della memoria schermo (C = 1)<br>`HIBASE` (1 byte, RAM): Pagina per l'editor del BASIC (solo se C = 0)<br>`VMCSB` (1 byte, I/O): Posizione della memoria schermo (solo se C = 0) |
| Registri Modificati | `.A`, `.P` (Negative, Zero, Carry), `HIBASE`, `VMCSB` |
| Richiede | `__USE_VIC_BANK = 1` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-vic_chargen"></a>
### VIC_CHARGEN

Imposta o recupera l'indirizzo iniziale del generatore di caratteri.

```
C = 0: .A contiene la pagina iniziale del generatore di
       caratteri, che può variare da $00 a $F8 ad intervalli
       di $08. Valori differenti vengono allineati al limite
       inferiore.
C = 1: Il valore della pagina iniziale del generatore di
       caratteri viene restituito in .A.
```

| Voce | Contenuto |
|---|---|
| Input | `.A` (1 byte, CPU): Pagina iniziale del generatore di caratteri (solo se C = 0)<br>Carry (1 bit, .P): 0 = imposta; 1 = legge |
| Output | `.A` (1 byte, CPU): Pagina iniziale del generatore di caratteri (solo se C = 1)<br>`VMCSB` (1 byte, I/O): Posizione del generatore (solo se C = 0) |
| Registri Modificati | `.A`, `.P` (Negative, Zero, Carry), `VMCSB` |
| Richiede | `__USE_VIC_BANK = 1` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-vic_bitmap"></a>
### VIC_BITMAP

Imposta o recupera l'indirizzo iniziale della memoria ad alta risoluzione.

```
C = 0: .A contiene la pagina iniziale della memoria ad alta
       risoluzione, che può variare da $00 a $E0 ad intervalli
       di $20. Valori differenti vengono allineati al limite
       inferiore.
C = 1: Il valore della pagina iniziale della memoria ad alta
       risoluzione viene restituito in .A.
```

| Voce | Contenuto |
|---|---|
| Input | `.A` (1 byte, CPU): Pagina iniziale della memoria bitmap (C = 0)<br>Carry (1 bit, .P): 0 = imposta; 1 = legge |
| Output | `.A` (1 byte, CPU): Pagina iniziale della memoria bitmap (C = 1)<br>`VMCSB` (1 byte, I/O): Posizione della memoria bitmap (solo se C = 0) |
| Registri Modificati | `.A`, `.P` (Negative, Zero, Carry), `VMCSB` |
| Richiede | `__USE_VIC_BANK = 1` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-vic_copy_chargen"></a>
### VIC_COPY_CHARGEN

Sposta il generatore di caratteri dalla ROM alla RAM, nella posizione definita dalla configurazione del chip VIC-II attualmente in uso.

| Voce | Contenuto |
|---|---|
| Input | Nessuno |
| Output | `generatore` (4096 byte, RAM): Copia del generatore di caratteri della ROM |
| Registri Modificati | `.A`, `.X`, `.Y`, `.P` (Negative, Zero, Carry), `INDEX`, `INDEX2`, `R6510`, `CIAICR` |
| Richiede | `__USE_VIC_CHARGEN = 1` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-compute_cell_address"></a>
### COMPUTE_CELL_ADDRESS

Calcola in modo veloce, mediante tavole, la cella di memoria corrispondente ad una posizione dello schermo espressa in notazione cartesiana: origine in alto a sinistra, asse x verso destra, asse y verso il basso. Se `.A` = 0 restituisce in `INDEX2` l'offset rispetto all'origine (0; 0), altrimenti la posizione assoluta per uno schermo che inizia alla pagina contenuta in `.A`: `.A` = (`HIBASE`) per lo schermo corrente, `.A` = >`COLRAM` per la memoria colore.

| Voce | Contenuto |
|---|---|
| Input | `.A` (1 byte, CPU): Pagina base dello schermo (0 = offset dall'origine)<br>`.X` (1 byte, CPU): Colonna della cella (0-39)<br>`.Y` (1 byte, CPU): Riga della cella (0-24) |
| Output | `INDEX2` (2 byte, ZP): Indirizzo della cella (offset se `.A` = 0) |
| Registri Modificati | `.A`, `.P` (Negative, oVerflow, Zero, Carry), `INDEX2` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-get_screen_cell"></a>
### GET_SCREEN_CELL

Restituisce il codice Schermo del carattere posizionato alla colonna `.X` ed alla riga `.Y` dello schermo corrente.

| Voce | Contenuto |
|---|---|
| Input | `.X` (1 byte, CPU): Colonna della cella (0-39)<br>`.Y` (1 byte, CPU): Riga della cella (0-24) |
| Output | `.A` (1 byte, CPU): Codice Schermo del carattere<br>`INDEX2` (2 byte, ZP): Indirizzo della cella |
| Registri Modificati | `.A`, `.Y`, `.P` (Negative, oVerflow, Zero, Carry), `INDEX2` |
| Richiede | `__USE_COMPUTE_CELL_ADDRESS = 1` |

[↑ Torna al contenuto](#contenuto)

<a id="utilita-get_color_cell"></a>
### GET_COLOR_CELL

Restituisce il codice del colore del carattere posizionato alla colonna `.X` ed alla riga `.Y` dello schermo corrente.

| Voce | Contenuto |
|---|---|
| Input | `.X` (1 byte, CPU): Colonna della cella (0-39)<br>`.Y` (1 byte, CPU): Riga della cella (0-24) |
| Output | `.A` (1 byte, CPU): Codice del colore (0-15)<br>`INDEX2` (2 byte, ZP): Indirizzo della cella |
| Registri Modificati | `.A`, `.Y`, `.P` (Negative, oVerflow, Zero, Carry), `INDEX2` |
| Richiede | `__USE_COMPUTE_CELL_ADDRESS = 1` |

[↑ Torna al contenuto](#contenuto)

<a id="limiti-noti"></a>
## Limiti noti

I riquadri TO-DO dei sorgenti e le note dei file di simboli dichiarano questi limiti.

### Simboli duplicati tra `vic.asm` e `vic_ii.asm`

`vic.asm` e `vic_ii.asm` definiscono gli stessi simboli (`VIC`, `VIC_BLACK`, `VIC_WHITE`, `VIC_TRANSPARENT` e altri), alcuni con valori diversi (per esempio `VIC`): un programma include l'uno o l'altro, non entrambi.

### Gestione dell'NMI: vettore sbagliato (B13)

Valgono per `NMI_HIBASE` e `NMI_RESTORE`, che scrivono in `NMIVEC` (`$FFFA`/`$FFFB`):

- con il Kernal abilitato la scrittura va nella RAM sotto la ROM e il processore continua a leggere il vettore dalla ROM: le subroutine non hanno effetto e `HIBASE` non viene mai reinizializzata;
- con il Kernal disabilitato (tutta RAM) la scrittura funziona, ma il gestore termina con `jmp NMIHND` (`$FE43`), che salta in una ROM che non c'è: serve un gestore proprio;
- `NMIHND` è l'ingresso del vettore del Kernal, non il gestore: a `$FE43` il Kernal esegue `SEI` e `JMP ($0318)`. Il vettore modificabile è `NMINV` (`$0318`), che di norma contiene `$FE47`.

Correzione indicata nel sorgente: scrivere in `NMINV` invece che in `NMIVEC`, chiudere il gestore con un salto a `$FE47` e far scrivere a `NMI_RESTORE` il valore `$FE47` in `NMINV`. Serve un simbolo per `$FE47` in `c64/symbols.asm`.

### Raster: campionamento dell'IRQ in `m_Enter_Stable_IRQ`

La sequenza di `nop` della fase di sincronizzazione del raster potrebbe avere una discrepanza di un ciclo, legata alla temporizzazione esatta del VIC-II. La discrepanza non è dimostrata: non è stata né confermata né esclusa. Da ricontrollare, per ciascun modello di VIC-II (Old NTSC, New NTSC, PAL), con un emulatore a temporizzazione esatta o su macchina reale.

### Raster: manca un esempio d'uso

Le macro di `raster_tools.asm` sono descritte una per una, ma non esiste ancora un esempio completo che le mostri usate insieme (`m_Init_Raster_System`, `m_Start_Raster_IRQ`, `m_Enter_Raster_IRQ`, `m_Next_Raster_IRQ`, nelle versioni instabile e stabile).

[↑ Torna al contenuto](#contenuto)
