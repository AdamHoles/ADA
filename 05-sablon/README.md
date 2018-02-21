Tartalom:
---------

*   [Sablon (generic)](#sabl)
*   [Sablon paraméterek](#param)
*   [Példányosítás](#peld)
*   [Példa: Másodfokú polinomok sablon csomagja](#pl)
*   [Példaprogramok](#pelda)

  

Sablon (generic)
----------------

Az előző gyakorlaton írtunk egy verem adattípust, amellyel integereket kezeltünk. Szükségünk lehet azonban olyan veremre, amellyel más adattípust szeretnénk kezelni. A két verem kódja csak annyiban különbözik, a hogy a megfelelő helyeken az integer kerektersorozatot lecseréljük egy másikra, a kód lényegi része, az algoritmusok változatlanok maradnak. Felmerül a kérdés, hogy meg lehetne-e azt csinálni, hogy megírunk egy áltlános verem típust, és azt, hogy milyen adattípussal működjön, csak később, a verem használata előtt mondjuk meg. A válasz igen, az Ada ezt a sablon nyelvi eszközzel biztosítja. (Sőt mint később kiderül a sablon ennél egy kicsivel többet is tud.)  
   
Sablon lehet eljárás, függvény és csomag is, de ez NEM önálló fordítási egység. Használat előtt példányosítani kell, azaz meg kell adni a konkrét dolgokat. (pl. a verem esetén, hogy milyen adattípussal szeretnénk használni)  
   
A sablon szerkezete:  

sablonnév.ads  
```ada
GENERIC   
    <sablonparaméterek>   
PACKAGE vagy   
FUNCTION vagy   
PROCEDURE ...   
```   
sablonnév.adb  

Ide kerül a sablon törzse. (felépítése megegyezik a sima csomag- vagy alprograméval)  
   
főprogram.adb  
```ada
WITH <sablonnév>;   
USE        --Ez még tilos!!   
   
PROCEDURE <főprogram> IS   
    --példányosítjuk   
    PACKAGE vagy   
    FUNCTION vagy   
    PROCEDURE <név> IS NEW <sablonnév>(<konkrét\_sablonparaméter\_1>, \[<konkrét\_sablonparaméter\_2>,\[...,\[<konkrét\_sablonparaméter\_n,\]\]\])   
    --ezután, ha csomagot példányosítottunk lehet USE is   
    USE <név>;   
```

### Sablon paraméterek

Sablon paraméter lehet változó, típus és alprogram. Először nézzük a típusokat.  
Típusok esetében azt kell meghatározni, hogy az egyes típusoknak milyen speciális tulajdonságait szeretnénk kihasználni, (ha egyáltalán akarjuk). Ezeket a kikötéseket példányosításkor figyelembe kell venni. (Ha nem tesszül a fordító hibaüzenettel leáll.) A verem esetében, csak annyi kell, hogy érvényes legyen rajta az értékadás, de más esetben megkövetelhetjük pl. azt is, hogy csak diszkrét típussal lehessen példányosítani, vagy csak olyan diszkréttel, amin értelmezve van az + és * múvelet, stb.  
```ada
TYPE <név> IS PRIVATE;   
```
Tetszőleges típussal lehet példányosítani, ami nem LIMITED, azaz értelmezve van rajta az értékadás és az egyenlőség vizsgálat.  

```ada
TYPE <név> IS LIMITED PRIVATE;   
```
Tetszőleges típussal lehet példányosítani, az értékadás és az egyenlőségvizsgálatnak sem kell értelmezve lennie rajta. Ez a legáltalánosabb típus sablon paraméter.  

```ada
TYPE <név>(<diszkrimináns 1> : <típus 1>, \[<diszkrimináns 2> : <típus 2>, \[...,\[<diszkrimináns n> : <típus n>\]\]\]) IS \[LIMITED\] PRIVATE;   
```
Mint az előzőek, de diszkriminánsos típusnak lell lennie  
   
TYPE <név>(<>) IS PRIVATE;   
Indefinit típus, azaz olyan tömb típus, aminek nincs konkrétan meghatározva a mérete  
   
TYPE <név> IS (<>);   
Diszktrét típus. Az ilyen típusoknak biztosan léteznek attribútumai.  
   
TYPE <név> IS RANGE <>;   
Előjeles egész. Attribútumokon kívül vannak aritmetikai műveletek is.  
   
TYPE <név> IS ARRAY(<INDEX>) OF <ELEM>;   
   
TYPE <név> IS ARRAY(<INDEX> RANGE <>) OF <ELEM>;   
Tömb típusok, ilyenkor az INDEX és az ELEM vagy szintén sablon paraméter, vagy pedig olyan típus amely elérhatő onnan, ahol a sablont példányosítottuk. A felső egy definit tömbtípus, méghozzá a teljes INDEX'RANGE-en van értelmezve, az alsó pedig egy indefinit tömtípus.  
   
   
Sablon paramétert mint változót, az alábbi módon adhatunk meg  
   
<változónév> : IN  <létező_típus> \[:= <kezdőérték>\];   
Ez a paraméter egy konstans értékként szerepel a csomagban.  
   
Az alprogram paraméter az alábbi  
   
WITH FUNCTION <név>(<paraméterlista>) RETURN <típus>;   
WITH PROCEDURE <név>(<paraméterlista>);   
WITH FUNCTION "<operátor>"(<paraméterlista>) RETURN <típus> \[IS <>\];   
   
Példányosításkor olyan alprogramot kell megadni, amelyek paraméterei illeszkediknek az itt megadottakra, ill függvény esetében a visszatérési érték típusának is meg kell egyezni. Az operátor túlterhelés esetén az IS <> azt jelenti, hogy ha a paraméterben megadott típusra már létezik művelet, akkor a példányosításkor nem kötelező megadni semmit, ilyenkor a meglevőt fogja használni. (Ettől még megadhatunk másikat is, felüldefiniálva a meglévő jelentését).  

### Példányosítás

Itt kell megadni a konkrét értékeket. A köv példában látni fogjuk hogyan.  

### Példa: Másodfokú polinomok sablon csomagja

A tpolin.ads  
```ada
GENERIC   
    TYPE egyutthato IS PRIVATE;   
    WITH FUNCTION "+"(a, b : egyutthato) RETURN egyutthato IS <>;    
    --A fenti két sor helyett íthattuk volna azt is, hogy   
    --TYPE egyutthato IS RANGE <>   
    --de ekkor nagyobb megkötést tettünk volna az egyutthato típusra, ugyanis a mostani esetben olyan típus is lehet együttható amire nincs alapértelmezett összeadás, csak általunk megírt összeadófüggvény.   
PACKAGE tpolin IS   
    TYPE polinom IS PRIVATE;   
    FUNCTION "+"(a, b : polinom) RETURN polinom;    
    --Figyeljük meg, a Generic-ben a PRIVATE azt jelenti, hogy egy tetszőleges típus lehet, és azt majd példányosításkor adjuk meg, a Package PRIVATE-je pedig azt jelenti, hogy a csomagunk felhasználójának semmi köze, hogy mi hogyan implementáltuk a típusunkat. Hasonlóan a sablon paraméter összeadás függvény az együtthatókra vonatkozik és a sablonunk felhaszálójának kell megírni példányosítás előtt (ha van alapértelmezett, akkor használhatja azt is), a csomag összeadás függvénye, meg a polinomokra, és azt nekünk kell implementálni a csomag törzsrészében.   
PRIVATE   
    TYPE polinom IS RECORD   
        x0, x1, x2 : egyutthato;   
    END RECORD;   
END tpolin;   
```
   
A tpolin.adb  

```ada
PACKAGE BODY tpolin IS   
   
FUNCTION "+"(a, b : polinom) RETURN polinom IS   
    temp : polinom;   
BEGIN   
    temp.x0 := a.x0 + b.x0;   
    temp.x1 := a.x1 + b.x1;   
    temp.x2 := a.x2 + b.x2;   
    return temp;   
END "+";   
   
END tpolin;   
```

A main.adb  

```ada   
WITH tpolin   
   
PROCEDURE main IS   
    --a polinom sablon karakter együtthatós polinomoknak példányosítjuk   
    FUNCTION osszead(a,b : character) RETURN character IS   
    BEGIN   
        RETURN character'val((character'pos(a) + character'pos(b)) mod 256);   
    END;   
   
    PACKAGE cpolin IS NEW TPolin(character, osszead);   
    USE cpolin;   
       
    --létrehozunk egy integer együtthatő polinomtípus is az alapértelmezett összeadással   
    PACKAGE ipolin IS NEW TPolin(integer); --itt nem kell megadni a fv-t mert van alapértelmezett   
    USE ipolin;   
   
    p1, p2 : cpolin.polinom;   
    q1, q2 : ipolin.polinom;   
   
BEGIN   
    p1 := p1 + p2;   
    q1 := q1 + q2;   
END;   
```

### Példaprogramok