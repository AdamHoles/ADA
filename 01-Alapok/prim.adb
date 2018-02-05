with ada.text_io; 
use ada.text_io; 
 
procedure prim is 
   p : integer := 43; 
   i : integer := 2; 
   b : boolean := true; 
begin 
   while b and i <= (p/2) loop 
      b := (p mod i) /= 0; 
      i := i + 1; 
   end loop; 
   put_line(boolean'image(b)); 
end prim; 