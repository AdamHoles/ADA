with ada.text_io; 
use ada.text_io; 
 
procedure faktor is 
 
   function faktor(k : integer) return integer is 
      res : integer := 1; 
   begin 
      for i in 2..k loop 
         res := res * i; 
      end loop; 
      return res; 
   end faktor; 
begin 
   put_line(integer'image(faktor(5))); 
end faktor;