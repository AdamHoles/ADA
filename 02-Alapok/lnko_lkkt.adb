with ada.text_io; 
use ada.text_io; 
 
procedure lnko_lkkt is 
    
    function lnko1(p1 : in integer; p2 : in integer) return integer is 
        a : integer := p1; 
        b : integer := p2; 
    begin 
        while a /= b loop 
            if a > b then  
                a := a - b; 
            else  
                b := b - a; 
            end if; 
        end loop; 
        return a; 
    end lnko1; 
    
   function lnko2(p1 : in integer; p2 : in integer) return integer is 
      a : integer := p1; 
      b : integer := p2; 
      r : integer; 
   begin 
      while b /= 0 loop 
         r := a mod b; 
         a := b; 
         b := r; 
      end loop; 
      return a; 
   end lnko2; 
    
   function lkkt(p1 : in integer; p2 : in integer) return integer is 
      x : integer := p1; 
      y : integer := p2; 
   begin 
      while x /= y loop 
         if x < y then 
            x := x + p1; 
         else 
            y := y + p2; 
         end if; 
      end loop; 
      return x; 
   end lkkt; 
begin 
   put_line("lnko(24,21) = " & integer'image(lnko1(24,21))); 
   put_line("lnko(32,31) = " & integer'image(lnko2(32,31))); 
   put_line("lkkt(24,16) = " & integer'image(lkkt(24,16))); 
end lnko_lkkt;