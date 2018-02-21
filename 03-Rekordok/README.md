Segédanyag a 3. gyakorlathoz
============================

Tartalom:
---------

*   [Rekord](#rekord)
*   [Diszkriminánsos rekord](#diszkriminánsos_rekord)
*   [Variáns rekord](#variáns_rekord)
*   [Példaprogramok](#példaprogramok)

Rekord
------

A rekord inhomogén összetett adatszerkezet, a direktszorzat és az unió típus megvalósítására szolgál.  
Szintakszisa az alábbi: 
 
```ada
TYPE <rekordnév> IS RECORD   
    <adattag 1> : <típus 1>   
    <adattag 2> : <típus 2>   
    .   
    .   
    .   
    <adattag n> : <típus n>   
END RECORD;   
```

Nézzük az alábbi példát  

```ada
TYPE komplex IS RECORD   
    re : FLOAT;   
    im : FLOAT;   
END RECORD;   
   
a, b : komplex;
```
   
ekkor az alábbi értékadások érvényesek  

```ada   
a.re := 3.1;   
a.im := 3.2;   
   
b := (1.6,3.8);   
   
a := b;   
a.re := b.re;   
a.im := b.im;   
```

Tehát ebben az esetben, mint a tömböknél, az egész rekordot értékül lehet adni egy lépésben, de lehet tagonként is.  
A komplex típusunkhoz megírhatjuk az aritmetikai műveleteket is. Erre jó módszer az operátor túlterhelés. Nézzük példának a szorzást:  

```ada
FUNCTION "*"(a : komplex; b : komplex) return komplex is   
    c : komplex;   
BEGIN   
    c := ((a.re * b.re - a.im * b.im),(a.re * b.im + a.im * b.re));   
    RETURN c;   
END;   
```


Ha akarjuk meg tudjuk tiltani a saját rekordtípusunk egy lépésbeli értékadását és egyenlőságvizsgálatát. Erre majd a csomagoknál lesz szükség.  
Ezt a következő módon tehetjük meg:  

```ada
TYPE <rekordnév> IS LIMITED RECORD   
    <adattag 1> : <típus 1>   
    <adattag 2> : <típus 2>   
    .   
    .   
    .   
    <adattag n> : <típus n>   
END RECORD;   
```

A tagonkénti értékadás és egyenlőségvizsgálat használható marad.

Diszkriminánsos rekord
----------------------

Lehetőség van "paramétert" is adni a rekordnak, ekkor beszélünk diszkriminánsos rekordról. A diszkrimináns (paraméter) csak diszkrét típus lehet.  
A szinkakszis a következő:  

```ada
TYPE <rekordnév>(<diszkrimináns_név 1> : <típus 1>\[:= <kezdőérték 1>\]\[, ... ,<diszkrimináns_név n> : <típus n>\[:= <kezdőérték n>\]\]) IS \[LIMITED\] RECORD   
    <adattag 1> : <típus 1>   
    <adattag 2> : <típus 2>   
    .   
    .   
    .   
    <adattag n> : <típus n>   
END RECORD;
```
   
A diszkrimináns értékét a deklarációkor kell megadni. Ha nincs kezdőértéka akkor kötelező, ha van akkor meg felül lehet vele definiálni.  
A diszkrimináns változóit is lehet belső adatként használni. Írni nem ajánlott!!!!  
Példa:  
```ada
TYPE adat(h : INTEGER := 10) IS RECORD   
    nev : STRING(1..h);       
    szev : INTEGER;   
END RECORD;   
   
x : adat(15);    --ekkor 15 hosszú lesz a string   
x : adat;        --akkor 10 hosszú lesz   
```

Variáns rekord
--------------

Ez az adatszerkezet az absztrakt unió típus megvalósítására szolgál. Használatát egy példán keresztül mutatom be:  
```ada
TYPE nem IS (no, ferfi);   
TYPE adatok(neme : nem) IS RECORD   
    nev : STRING(1..15);   
    anya_neve : STRING(1..15);   
    CASE neme IS   
        WHEN no => leanykori_neve : STRING(1..15);   
        WHEN ferfi => volt\_e\_katona : BOOLEAN;   
    END CASE;   
    szul_ev : POSITIVE;   
END RECORD;   
```
Amint láthatjuk, a diszkrimináns értékétől függően más, más tagok szerepelnek a rekordban.  

Példarogramok
-------------