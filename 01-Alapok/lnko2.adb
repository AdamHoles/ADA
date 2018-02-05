with ada.text_io; 
use ada.text_io; 
 
procedure lnko2 is 
   a : integer := 78; 
   b : integer := 24; 
   r : integer; 
begin 
   while b /= 0 loop 
      r := a mod b; 
      a := b; 
      b := r; 
   end loop; 
   put_line(integer'image(a)); 
end lnko2;