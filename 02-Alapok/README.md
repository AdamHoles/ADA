Segédanyag a 2. gyakorlathoz
============================

Tartalom:
---------

*   [Tömbök](#tömbök)
*   [String](#string)
*   [Tömbök attribútumai](#tömbök-attribútumai)
*   [Alprogramok](#alprogramok)
*   [Példaprogramok](#példaprogramok)

# Tömbök
--------

### Definit tömbtípus
```ada
TYPE <tömbtípusnév> IS ARRAY (<intervallum>) OF  <tömbváltozó> : <tömbtípusnév>;   
```
   
A definit tömbtípusnak az a tulajdonsága, hogy már a típusdefinicíókor meg kell adni a tömb méretét  
Létezik még a névnélküli definit tömbtípus is:  
```ada  
<tömbváltozó> : ARRAY(<intervallum>) OF  
```
A két megadás között lényeges különbség van. Ha nevesített típust hozunk létre (TYPE-os mód), akkor deklarálhatunk több ugyanolyan típusú tömbváltozót is, ellenben a névtelen típusoknál mindig különböző típusú tömbváltozók jönnek létre, annak ellenére, hogy esetleg formailag ugyanúgy néz ki több deklaráció is. Ennek hátránya, hogy pl. nem tudunk két tömbváltozót direktben összeadni, vagy a névtelen tömbtípusú változó nem lehet alprogram paramétere.  
   
   
példák:  
```ada
TYPE TTomb IS ARRAY(1..12) OF INTEGER;   
   
T1 : TTomb;   
T2 : TTomb;   
T3 : ARRAY(1..12) OF INTEGER;   
T4 : ARRAY(1..12) OF INTEGER;   
```
ekkor lássuk az alábbi utasításokat  
```ada  
T1 := T2;    --Helyes, mert mindkét változó ugyanolyan típusú. Ilyenkor T1 tömb minden eleme felveszi T2 tömb megfelelő elemeinek értékét

--Ezek hibásak mert különböző tipusúak.
T1 := T3;   
T3 := T4;
```
--Természetesen az alábbi helyes   
```ada
FOR I IN 1..12 LOOP   
    T3(I) := T4(I);   
END LOOP;   
```
### Indefinit tömbtípus

Indefinit tömbtípus esetén nem kell a típusdefiníciókor megadni a könkrét méretét a tömbnek, hanem csak egy diszkrét típust amivel majd indexeljük. A konkrét méretet a deklarációkor adjuk meg.  
```ada
TYPE <tömbtípusnév> IS ARRAY (<indextípus> RANGE <>) OF  <tömbváltozó> : <tömbtípusnév>(<intervallum>);   
```   
példák:  
```ada
TYPE HONAP IS (JAN, FEB, MAR, APR, MAJ, JUN, JUL, AUG, SEP, OKT, NOV, DEC);   
TYPE TFIZETES IS ARRAY(HONAP RANGE <>) OF INTEGER;            --indexek lehetnek tetszőleges diszkét típuspk is   
   
FIZETES : TFIZETES(SEP..DEC) := (90000,120000,110000,250000);    --így lehet kezdőértéket adni egy tömbnek   
   
FIZETES(SEP) := 95000;    --így adunk értéket a tömb egy elemének !!FONTOS!! Az adában a gömbölyű zárójelet használjuk a tömb elemének elérésére   
```   

### Több dimenziós tömb

```ada   
matrix : ARRAY(1..10, 1..5) OF NATURAL;   
```
Természetesen a több dimenziós tömbökre is vonatkoznak az előzőek. Mindent ugyanúgy kell csinálni, csak vesszővel elválasztva a többi dimenzióra is meg kell adni az adatokat.  

# String
--------

A string egy karakterekből álló tömb. A definíciója: (Előredefiniált típus)  
```ada
TYPE STRING IS ARRAY(POSITIVE RANGE <>) OF CHARACTER;   
<változónév> : STRING(<intervallum>);   
```
példák:
```ada
SUBTYPE INTV IS POSITIVE RANGE 1..12;   

s1 : STRING(1..10);   
s2 : STRING(3..8);   
s3 : STRING(3..INTV'LAST);   
s4 : STRING(INTV'RANGE);   

s2 := "ABCDEF";    --Helyes   
s2 := "AB";        --Hibás mert, 6 hosszú string adható értékül s2-nek, ui. s2 egy tömb, és így az Ada nem tudja, hogy mi kerüljön a 3. helyre   
```
példák kezdőérték megadására: 
 
```ada
s5 : STRING(1..5) := "ABCDE";   
s6 : STRING := "ABCDE";   --Mindkettő helyes, mert ha adunk kezdőértéket, akkor abból az Ada ki tudja számolji a string hosszát. Ilyenkor 1-től indexelődik.   
s6 : STRING := (1..7 => 'A');   -- Itt az értéke "AAAAAAA"-lesz   
s7 : STRING := "AB" & (3..5 => 'A');  -- Itt az értéke "ABAAAAA"-lesz   
s8 : STRING(1..7) := (3 => 'C', 6 => 'E', OTHERS => 'A');  -- Itt az értéke "AACAAACA"-lesz. Ha van others, akkor a méretet is meg kell adni   
s9 : STRING := ('A','B','C','D');  --Az értéke "ABCD" lesz   
```

# Tömbök attribútumai
-------------------

Tömbök esetében a változó és nem a típus nevét kell az attribútum elé írni.  
Legy a következő példa tömbünk:

```ada 
A : ARRAY(1..10, 3..7) OF INTEGER;   
```

| Attríbutom | Leírása |
| ---------- | ------- |
| A'FIRST(n) | A n. dimenziójának tömb alsó indexe, itt n=1 esetén 1, n=2 esetén 3 |
| A'FIRST | ekvivalens a A'FIRST(1)-el |
| A'LAST(n) | A n. dimenziójának tömb felső indexe, itt n=1 esetén 10, n=2 esetén 7 |
| A'LAST | ekvivalens a A'LAST(1)-el |
| A'RANGE(n) | A n. dimenziójának az index intervalluma, itt n=1 esetén 1..10, n=2 esetén 3..7 |
| A'RANGE | ekvivalens a A'RANGE(1)-el |
| A'LENGTH(n) | A n. dimenziójának elemeinek száma, itt n=1 esetén 10, n=2 esetén 5 |
| A'LENGTH | ekvivalens a A'LENGTH(1)-el |

# Alprogramok
-------------

Az Ada támogatja a függvény- és az eljárás írását is, sőt lényegesen megkülönbözteti a kettőt. Függvényt akkor kell használni, ha valamely paraméterek segítségével szeretnénk meghatározni egy újabb értéket. (ilyenek pl. a matematikai függvények) Tehát egy függvénynek azonos paraméterezés mellent, mindig ugyanazt az eredményt kell visszaadni. Pl. egy verem pop művelete nem lehet függvény, mert mindig a verem tetején levő értékkel tér vissza, amelyek különbözőek is lehetnek. (A pop-ot eljárással kell megvalósítani, ahol a verem tetején levő értéket egy kimenő (cím szerinti) paraméterben adjuk át. A C-ben ismert út sem alkalmazható Adában, miszerint egy függvény (pl. beolvas a billentyűzetről egy számot) a visszatérési értékében azt adja vissza, hogy sikerült-e a művelet. Azért nem jó, mert ugyanazon paraméterezés esetén vagy sikerül vagy nem, azaz nem mindig ugyanaz a visszatérési érték. Ezt a kivételkezeléssel oldhatjuk meg az Adában. Tehát összefoglalva függvény akkor írunk, ha az alprogram nem változtat a programunk állapotán, azaz nem módosít semmilyen adatot a saját lokális változóin kívül, minden más esetben eljárást kell írni.  
   
Eljárás:
 
```ada
PROCEDURE <eljárás név>(paraméterlista) IS   
    <deklarációs rész>   
BEGIN   
    <utasítások>   
END <eljárás név>;   
```

Függvény:
 
```ada   
FUNCTION <függvény név>(paraméterlista) RETURN <visszatérési típus> IS  
    <deklarációs rész>  
BEGIN   
    <utasítások>   
    RETURN <visszatérési típus érték>;   
END <függvény név>;   
```

### Paraméterek:

Eljárásnak az alábbi típusú paraméterei lehetnek:  

| Paraméter típusa | Paraméter leírása |
| ---------------- | ----------------- |
| IN | Bemenő, csak olvasni lehet azaz értékadásnál csak a jobb oldalon állhat. Aktuális paraméter lehet olyan objektum is aminek nincs címe (pl. konstans, fv. visszatérési értéke stb) |
| OUT | kimenő, amíg nem adtunk neki értéket csak írni lehet, tehát amíg nincs értéke ertékadásnal csak a bal oldalon állhat, utána mehet a jobb oldalra is. Aktuális paraméter csak olyan objektum lehet, aminek van címe pl. változó. |
| IN OUT | bemenő kimenő, lehet írni is és olvasni is, van kezdőértéke tehát az értéadás mindkét oldalán állhat. Aktuális paraméter csak olyan objektum lehet, aminek van címe. |

Függvénynek csak IN típusú paramétereik lehetnek. Ha nem mondjuk meg explicit, hogy egy paraméter milyen, akkor az mindig IN típusú.
   
Példák:

```ada
PROCEDURE CSERE(a : IN OUT INTEGER, b : IN OUT INTEGER) IS   
    tmp : INTEGER;   
BEGIN   
    tmp := a;   
    a := b;   
    b := tmp;   
END CSERE;   
```

```ada
FUNCTION FAKTOR(a : IN INTEGER) IS   
    tmp : INTEGER := 1;   
BEGIN   
    FOR i IN 2..a LOOP   
        tmp := tmp * i;   
    END LOOP;   
   
    RETURN tmp;   
END FAKTOR;   
```

### Operátor túlterhelés:

Például az összeadás:  

```ada
FUNCTION "+"(<baloldali paraméter> : IN <típusa>, <jobboldali paraméter> : IN <típusa>) RETURN <visszatérési érték típusa> IS   
    <deklarációs rész>   
BEGIN   
    ...   
    RETURN <valamilyen kifejezés>;   
END "+";   
```
Adában az mint az operátorok esetében is egy eljárást vagy függvényt nemcsak a neve, hanem a paraméterezése is azonosít. Így írhatunk több azonos nevű alprogramot is amiknek különböző paramétereik vannak.  

# Példaprogramok
----------------
