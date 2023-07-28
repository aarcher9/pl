# Trattamento del vettore nullo

Il vettore nullo n-dimensionale, per esempio in caso n = 2 (0 0) nelle operazioni algebriche dei vettori viene equivalentemente usato come 'nil' e viceversa.

La scelta si motiva con una più facile gestione dei calcoli da cui si vorrebbe far conseguire un codice più solido ed espressivo; inoltre sebbene tipograficamente le rappresentazioni siano diverse, risulta utile considerarle concettualmente la stessa cosa.

Si riportano in calce i relativi codici usati come test per meglio esemplificare.


# Trattamento del numero di cluster in relazione al numero di osservazioni

La funzione kmeans lancia un errore con un messaggio custom, quando il K inserito è minore o uguale a 0 o maggiore strettamente del numero di osservazioni.
