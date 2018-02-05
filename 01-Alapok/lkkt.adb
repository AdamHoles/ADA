with ada.text_io; 
use ada.text_io; 
 
procedure lkkt is 
   a : integer := 12; 
   b : integer := 10; 
   x : integer := a; 
   y : integer := b; 
begin 
   while x /= y loop 
      if x < y then 
         x := x + a; 
      else 
         y := y + b; 
      end if; 
   end loop; 
   put_line(integer'image(x)); 
end lkkt; 