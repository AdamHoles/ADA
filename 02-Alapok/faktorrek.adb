with ada.text_io; 
use ada.text_io; 
 
procedure faktorrek is 
 
   function faktor(k : integer) return integer is 
   begin 
      if k = 1 then 
         return 1; 
      else 
         return k * faktor(k-1); 
      end if; 
   end faktor; 
      
begin 
   put_line(integer'image(faktor(5))); 
end faktorrek;