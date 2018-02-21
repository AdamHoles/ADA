4\. gyakorlat 
Segédanyag a 4. gyakorlathoz
============================

Tartalom:
---------

*   [Csomag](#csomag)
*   [Specifikációs rész](#specifikációs_rész)
*   [Törzsrész](#törzsrész)
*   [Főprogram](#főprogram)
*   [Példa Komplex számok csomagja](#példa_komplex_számok_csomagja)
*   [Példaprogramok](#példaprogramok)

Csomag
----------------

Logikailag összetartozó alprogramok, típusdefiniációk, változók stb. halmaza. A csomag nem objektum orientált támogatása az Adának a különböző adattípusok elkészítésére, valamint egy lehetőség, a programunk kisebb, önálló részekre bontására.  
A csomag önnálló fordítási egység. Két részből áll: specifikációs rész (ads), törzsrész (adb)  

### Specifikációs rész

Ebben a részben deklaráljuk a csomagban szereplő alprogramokat és definiáljuk a típusokat.  
Szintakszisa az alábbi: (a kód a csomagnév.ads-be kerül)  

PACKAGE <csomagnév> IS   
    <alprogram és típus definíciók> (1)   
PRIVATE   
    <átlátszatlan rész> (2)   
END <csomagnév>;   
   
Az (1) részbe kerülnek a publikus definíciók / deklarációk. Ezeket lehet kívülről erérni, tehát ez a rész biztosít egy interfészt a csomagunkhoz. A csomagot akkor terveztük meg helyesen, ha az itt szerepló definíciókból / deklarációkból egy másik személy egyértelműem meg tudja állapítani, hogy mit csinál a csomagunk. Ha az nem így van, akkor a csomag rossz, ugyanis az Ada (és számos más nyelv) szemléletmódja az, hogy a csomag (objektum) implementációja csak a csomag írójára tartozik, a külvilággal (más objektumokkal) csak a publkus részben definiált interfészen keresztül kommunikálhat. A PRIVATE részben definiált / deklarált dolgokat csak a csomagon belül tudjuk elérni (ez nemcsak szemléletmód, hanem szintaktikailak lehetetlen). (Az Ada egyik erőssége, hogy nem OOP környezetben is biztosítja ezt).  
   
Az (1) részben szerepelhet ilyen típusdefiníció is:  

```ada
TYPE <típusnév> IS PRIVATE;   
```

Ha ilyen van, akkor ezt a típust a (2)-es részben konrétan definiálni kell. Ez azert jó így, mert a típusra utalunk az interfész részben, így jelezzük kifelé, hogy létezik ez a típus, de az implementációt el tudjuk rejteni a külvilág elől. (pl. sor típust szeretnénk megvalósítani, de azt nem akarjuk a külső felhasználónak tudomására hozni, hogy ezt tömbbel vagy láncolt listábal valósítjuk meg)

### Törzsrész

Itt implementáljuk a specifikációs részben deklarált alprogramokat, az alábbi módon: (a kód a csomagnév.adb-be kerül)  

```ada
PACKAGE BODY <csomagnév> IS   
    PROCEDURE ... IS   
        ...   
    BEGIN   
        ...   
    END ;   
   
    FUNCTION ... IS   
        ...   
    BEGIN   
        ...   
    END ;   
   
    ...   
   
END <csomagnév>;   
```  

### Főprogram

A főprogramban már csak meg kell mondani a fordítónak, hogy szeretnénk haszálni a csomagunkat:  

```ada
WITH <csomagnév>;   
\[USE <csomagnév>\];   
```

### Példa Komplex számok csomagja

Ez külön a komplex_csomag.ads-be:  

```ada
PACKAGE komplex_csomag IS   
    TYPE komplex IS PRIVATE;    --A komplex típus implementációját eltakarjuk   
       
    FUNCTION "+"(x : komplex; y : komplex) RETURN komplex;   
    FUNCTION "*"(x : komplex; y : komplex) RETURN komplex;   
    FUNCTION set(re : float; im : float) RETURN komplex;   
   
PRIVATE   
    TYPE komplex IS RECORD     --Itt definiáljuk a komplex típusunkat.   
        re : float;   
        im : float;   
    END RECORD;   
END komplex_csomag;   
```
   
A fenti három függvényt a törzsérszben kell definiálnunk. Ez a komplex_csomag.adb-be kerül  

```ada
PACKAGE BODY komplex_csomag IS   
    FUNCTION "+"(x : komplex; y : komplex) RETURN komplex IS   
    BEGIN   
        RETURN ((x.re + y.re),(x.im + y.im));   
    END "+";   
   
    FUNCTION "*"(x : komplex; y : komplex) RETURN komplex IS   
    BEGIN   
        RETURN ((x.re\*y.re-x.im\*y.im),(x.re\*y.im+x.im\*y.re));   
    END "*";   
   
    FUNCTION set(re : float; im : float) RETURN komplex IS   
    BEGIN   
        RETURN (re,im);   
    END set;   
END komplex_csomag;   
```
   
Ekkor a főprogram:  

```ada
WITH komplex_csomag;   
USE komplex_csomag;   
   
PROCEDURE main IS   
    z1 : komplex;   
    z2 : komplex;   
    z3 : komplex;   
BEGIN   
    z1 := set(1.0,2.0);   
    z2 := set(2.1,3.2);   
    z3.re := 3.5;    --EZ HIBÁS!!! mert a komplex típus implementációja rejtett, így itt nem tudhatjuk hogy rekordként implementálták. (Lehetne akár egy két elemű tömb is)   
    z3 := z1 * (z1 + z2);   
END main;   
```

Példarogramok
-------------