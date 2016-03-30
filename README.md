# Unica Thesis Template
Il template Latex per le tesi di laurea triennali/magistrali per gli studenti dell'Università di Cagliari.

Lo scopo del template è:
* fornire un frontespizio adeguato
* fornire una struttura di base funzionante

## Utilizzo
```
make
make frontespizio
```

Il primo make genera il file del frontespizio `main-frn.tex`. Il secondo rigenera il pdf con il frontespizio come prima pagina.

Successivamente è sufficiente un solo make

```
make
```

### TexStudio / TexMaker
Generate il frontespizio da terminale. Successivamente potete usare i comandi dell'editor.

### Others
Il comando `make loop` lancia un loop infinito in cerca di modifiche nei file tex. Se rileva modifiche, il pdf viene rigenerato.

![alt tag](https://raw.githubusercontent.com/atzeinicola/unica-thesis-template/master/main-frn.jpg)
