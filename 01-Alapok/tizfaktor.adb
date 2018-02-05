with ada.text_io; 
use ada.text_io; 
 
procedure tizfaktor is 
   f : integer := 1; 
begin 
   for i in 1..10 loop 
      f := f * i; 
   end loop; 
   put_line(integer'image(f)); 
end tizfaktor;