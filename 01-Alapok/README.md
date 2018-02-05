FORRAS 

[Vissza a főoldalra](./../index.html)  

Segédanyag az 1. gyakorlathoz
=============================

Tartalom:
---------

*   [Alap adattípusok](#adat)
*   [Attribútumok](#attrib)
*   [Műveletek precedenciája](#muv)
*   [Vezérlési szerkezetek](#vezszerk)
*   [Hello World program](#hw)
*   [Példaprogramok](#pelda)

Alap adattípusok:
-----------------

### Előjeles egész:

| név | méret (Windowsban) |
| --- | ------------------ |
| SHORT\_SHORT\_INTEGER | 1 byte |
| SHORT\_INTEGER | 2 byte |
| INTEGER | 4 byte |
| LONG\_INTEGER | 4 byte |
| LONG\_LONG\_INTEGER | 8 byte |
| NATURAL | 0..INTEGER'LAST |
| POSITIVE | 1..INTEGER'LAST |

A méret architektúránként és operációs rendszerenként változhat. A kikötés csak annyi, hogy pl. az INTEGER mérete leglább akkora kell hogy legyen mint a SHORT_INTEGER, és így tovább. Az INTEGER mérete általában akkora, hogy azt az adott rendszeren kényelmesen lehessen kezelni. (pl. egy 32 bites rendszeren 4 byte)  

### Karakter típus:

CHARACTER   
   

### Logikai típus:

BOOLEAN   
   

### Lebegőpontos típus:

FLOAT   
   

Felhasználó által elkészített adattípusok:
------------------------------------------

### Felsorolásos típus:
```ada
TYPE <azonosító> IS (<érték1>,<érték2>,<érték3>,...,<értékn>);   
```

### Megszorításos típus:
```ada
TYPE <azonosító> IS NEW <alaptípus> \[RANGE <n..m>\];   
```
Örökli a szülő típus típusmüveleteit, struktúráját stb.  
pl.:
```ada  
TYPE napok IS NEW integer RANGE 1..31;   
```

### Altípus:
```ada
SUBTYPE <azonosító> IS <alaptípus> \[RANGE <n..m>\];   
```
pl.:
```ada
TYPE napok2 IS integer RANGE 1..31;   
```

A két típus között lényeges különbség van. A napok új típus, így egy napok típusú változónak nem lehet értékül adni egy integer típusút (még akkor sem, ha annak az értéke 1 és 31 között lenne), ezzel szemben a napok2-nek már lehet, hiszen az nem új típus, hanem csak az integer típusnak egy altípusa.  
Az eddig ismertetett típusokat **DISZKRÉT** típusoknak nevezzük  

### Saját lebegőpontos típusok
```ada
TYPE <azonosító> IS \[NEW FLOAT\] DIGITS <n>   
```
A n tizedesjegyig pontos lebegőpontos típus  
```ada
TYPE <azonosító> IS DELTA <lépésköz> RANGE <intervallum>   
```
Olyan lebegőpontos típus, ami az intervallumban megadott tartományon van értelmezve, és a lépésközben megadott pontosséggal követik egymást a számok.  

Attribútumok:
-------------

Az attribútumok az adott típusokhoz tartozó típusműveletek. Ezek segítségével információkat tudunk kérni a típusról, valamint típusspecifikus műveleteket hajthatunk végre. A diszkrét típusok attribútumai a következők: (T egy tetszőleges diszkrét típus)  
| Attributum | Jelentese |
| ---------- | --------- |
| T'First | típusértékhalmaz alsó határa |
| T'Last | típusértékhalmaz felső határa |
| T'Range | First..Last intervallumot adja vissza | 
| T'Min(a,b) | a és b közül a kiesbbiket adja vissza |
| T'Max(a,b) | a és b közül a nagyobbikat adja vissza |
| T'Succ(a) | az a érték rákövetkezője |
| T'Pred(a) | az a érték megelőzője |
| T'Image(a) | az a-t stringgé konvertálja |
| T'Value(s) | az s stringből T típusú értéket konvertál |
| T'Width(a) | a T'Image által visszaadott string maximális hossza. |
   
példák az attribútumok használatára:  

```ada
TYPE hetnap IS (hetfo, kedd, szerda, csutortok, pentek, szombat, vasarnap);   
   
s1, s2 : STRING;   
h1 : NATURAL; --tegyük fel, hogy h az s1 string hosszát tárolja   
i : INTEGER := 42;   
nap : hetnap := hetfo;   
nap2 : hatnap;   
   
s2 := INTEGER'IMAGE(i);         --az i számot stringgé konvertálja, majd értékül adja s2-nek   
i := INTEGER'SUCC(i);           --az i változó értékét növeli 1-el   
i := INTEGER'MAX(13,54);        --az i-nek értékül adja 13 és 54 maximumát   
i := INTEGER'VALUE(s1(1..h1));  --az s1 stringet megpróbálja integerré konvertálni, majd értékül adja i-nek   
nap2 := hetnap'SUCC(nap);       --veszi a nap változó értékének rákövetkezőjét, és értékül adja a nap2-nek   
nap2 := hetnap'SUCC(kedd);      --veszi a kedd rákövetkezőjét, és értékül adja a nap2-nek   
nap2 := hetnap'PRED(hetfo);     --hiba, hetfonek nincs megelőzője   
```

Műveletek precedenciája
-----------------------

A legnagyobb precedenciájú van legfelül  

* **; abs; not
* *; /; mod; rem
* /+; /- (egyoperandusú)
* +; -; & (kétoperandusú)
* =; /=; <; <=; >; >=; in; not in
* and; or; xor; and then; or else;

   
Operátorok jelentése:  
| Operator | Megnevezes |
| ------- | ---------- |
| ** | hatványozás pl.: 2**5 = 32 |
| abs | abszolút érték pl. abs(-2) = 2 |
| not | logikai tagadás |
| * | szorzás |
| / | osztás, egész operandusok esetében egészrészes osztás |
| mod | moduló képzés (mint a matekban) |
| rem | maradék képzés példa a táblázat után |
| - | ellentett vagy kivonás |
| + | összeadás |
| & | string konkatenáció |
| = | egyenlőség vizsgálat |
| /= | nem egyenlő |
| < | kisebb |
| <= | kisebb egyenlő |
| > | nagyobb |
| >= | nagyob egyenlő |
| in | bal operandus egy érték, ajobb pedig egy intervallum, igaz, ha az érték benne van az intervallumban |
| not in | az in tagadása |
| and | logikai és (mindig kiértékali a két operandusát) |
| or | logikai vagy (mindig kiértékali a két operandusát) |
| xor | logikai kizáró vagy |
| and then | logikai és (csak akkor értékeli ki a második operandusát, ha az első igaz) | 
| or else | logikai vagy (csak akkor értékeli ki a második operandusát, ha az első hamis) |

| | mod | rem |
|-| --- | --- |
| 12/5 | 2 | 2 |
| -12/5 | 3 | -2 |
| 15/-5 | -3 | 2 |
   
ezek már nem operátorok  

| -- | --------- |
| := | értékadás |

--

magyarázó szöveg, a sor végéig hat

Vezérlési szerkezetek
---------------------

### Elágazás:
If
```ada
IF <feltétel 1> THEN   
    <utasítások>   
\[ELSIF <feltétel 2> THEN   
    <utasítások>   
\[ELSIF <feltétel 3> THEN   
    <utasítások>   
    .   
    .   
    .   
\[ELSIF <feltétel n> THEN   
    <utasítások>   
\]\]...\]   
\[ELSE   
    <utasítások>   
\]   
END IF;   
```
Switch:
```ada
CASE <diszkrét kifejezés> IS   
    WHEN <érték 1> =>   
        <utasítások>   
    \[WHEN <érték 2> =>   
        <utasítások>\]       
    .   
    .   
    .   
    \[WHEN <érték n> =>   
        <utasítások>\]       
    \[WHEN OTHERS =>   
        <utasítások>\]   
END CASE;   
```
érték lehet pl. 1 vagy 1|2|8 vagy 1|3..8;  
de fontos, hogy vagy others ágat kell használni, vagy az értékekkel az egész típusértékhalmazt le kell fedni  

### Ciklus:

### Előltesztelő:
```ada
WHILE <feltétel> LOOP   
    <utasítások>   
END LOOP;   
```
### Növekményes
```ada
FOR <változó> \[REVERSE\] IN <intervallum> LOOP   
    <utasítások>   
END LOOP;   
```
A változót nem kell előre deklarálni, REVERSE beírásával visszafele halad az intervallumon  

### Végtelen
```ada
LOOP   
    <utasítások>   
END LOOP;   
```

### Trükkös hátultesztelős

Az adában nincs valódi hátultesztelős ciklus. Ha mégis szeretnénk ilyet használni, az alábbi trükköt alkalmazzuk  
```ada   
LOOP   
    <utasítások>   
    EXIT WHEN <feltétel>;   
END LOOP;   
```
Az EXIT utasítás hatására a vezérlés a ciklus után folytatódik, ha a WHEN utáni kifejezés igaz. Az EXIT-et bármelyik fajta ciklusmagban is használhatjuk. A WHEN kulcsszó elhagyható, hatása a WHEN TRUE-val ekvivalens.  

### Blokkok
```ada
DECLARE   
    <deklarációs rész>   
BEGIN   
    <utasítások>   
END;   
```
A Blokkok egymásba ágyazhatóak.

Hello World program
-------------------
```ada   
with ada.text_io;   
use ada.text_io;    --ezek kellenek a kiiratáshoz   
   
procedure main is    --az eljárás neve meg kell, hogy egyezzen a forrást tartalmazó file nevével   
    \-\- itt van a deklarációs rész   
    \-\- most üresen marad   
begin   
    put_line("HELLO WORLD");   
end main;   
```

Példaprogramok
--------------

