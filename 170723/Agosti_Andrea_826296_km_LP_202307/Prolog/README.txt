# Trattamento del vettore nullo

Il vettore nullo n-dimensionale, per esempio in caso n = 2 [0, 0] nelle operazioni algebriche dei vettori viene equivalentemente usato come [] e viceversa.

La scelta si motiva con una più facile gestione dei calcoli da cui si vorrebbe far conseguire un codice più solido ed espressivo; inoltre sebbene tipograficamente le rappresentazioni siano diverse, risulta utile considerarle concettualmente la stessa cosa.



# Trattamento del numero di cluster in relazione al numero di osservazioni

Il predicato kmeans/3 fallisce quando il K inserito è minore o uguale a 0 o maggiore strettamente del numero di osservazioni.



# Breve descrizione della funzionalità

Il codice è suddiviso tramite brevi commenti in sezioni, ciascuna delle quali assolve un determinato compito. Sono inseriti dei commenti sopra ciascuna funzione che si è ritenuto di dover spiegare meglio.

## Sezione 1
Riguarda la generazione di numeri casuali, e generazione di set casuali al fine di estrarre i centroidi dall'insieme di osservazioni. Si sono scelti i set per evitare che si possano estrarre centroidi uguali cosa che si è riscontrata far malfunzionare il programma.

## Sezione 2
Riguarda la manipolazione algebrica dei vettori.

## Sezione 3
Riguarda l'implementazione dell'algoritmo di clustering. Si è mantenuta quasi totalmente la stessa denominazione delle funzioni/predicati in modo da facilitare la lettura e comprensione del codice oltre che per la stessa scrittura. La logica utilizzata per effettuare il clustering è la seguente, e medesima sia in Commmon Lisp che Prolog:
- si estraggono i centroidi per la prima volta
- si creano delle coppie vettore/centroide utilizzando le liste a vari livelli di profondità
- si raggruppano, sempre usando liste, tutti quei vettori che hanno lo stesso centroide comune
- si ricomputa il centroide di ciascun gruppo
- si riparte con l'operazione di generazione delle coppie e via discorrendo
- quando durante la computazione dei nuovi centroidi si riscontri che questa sia uguale ai centroidi precedenti, il calcolo termina 

In entrambi i linguaggi si è aggiunto un predicato/funzione kmeans0 che se invocato fornisce sia centroidi finali che cluster in una lista. kmeans si appoggia su questo per fornire il risultato richiesto. 

Qualunque input scorretto che non riguardi quanto citato precedentemente dovrebbe sollevare eccezioni "native" nel programma (ad esempio se in un vettore appare qualcosa che non sia un numero) o comunque fallire.



# Altro 
Come suggerito (ed anche riscontrato personalmente) dal prof. Fabio Sartori, si è utilizzato il grafico come riferimento per i centroidi e cluster corretti.
Riferimento alla discussione [https://elearning.unimib.it/mod/forum/discuss.php?d=241822].