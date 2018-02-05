with ada.text_io, ada.numerics.elementary_functions; 
use ada.text_io, ada.numerics.elementary_functions; 
 
procedure masod is 
   procedure zero(a : in float; b : in float; c : in float; x1 : out float; x2 : out float) is 
   begin 
      x1 := (-b + sqrt(b**2 - (4.0*a*c))) / (2.0*a); 
      x2 := (-b - sqrt(b**2 - (4.0*a*c))) / (2.0*a); 
   end zero; 
    
   x1, x2 : float; 
    
begin 
   zero(1.0,-4.0,4.0,x1,x2); 
   put_line("x1 = " & float'image(x1)); 
   put_line("x2 = " & float'image(x2)); 
end masod;