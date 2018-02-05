with ada.text_io; 
use ada.text_io; 
 
procedure lnko1 is 
   a : integer := 78; 
   b : integer := 24; 
begin 
   while a /= b loop 
      if a > b then  
         a := a - b; 
      else  
         b := b - a; 
      end if; 
   end loop; 
   put_line(integer'image(a)); 
end lnko1;