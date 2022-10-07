library ieee;
use ieee.std_logic_1164.all; -- std_logic ve std_logic_vector'ü kullanbilmek için std_logic_1164 paketini ekleriz

entity design_32bit_lfsr is --saatin yükselen kenarýnda mevcut durumu çýkýþa atayarak sonucu göreceðiz
generic (clk_frequency : integer :=100_000_000);

port(

clk         : in  std_logic;
output      : out std_logic_vector(31 downto 0)--32 bitlik bir çýktýmýz olacak

);

end design_32bit_lfsr;


architecture Behavioral of design_32bit_lfsr is

signal mevcut_durum  : std_logic_vector(31 downto 0):="00101100011010101000111110101100"; -- Shift etmeden önceki durum
signal sonraki_durum : std_logic_vector(31 downto 0):="00110100100100011011000110110001"; -- Shift edilip xor kapýsýýn çýktýsý 1. bite yazýlýnca ortaya çýkan durum

signal xorCiktisi    : std_logic:='1'; -- 1.,2.,22.ve 32. regisiterdan gelen 1 ve 0 deðerlerinin xor kapýsýndan geçirilmesiyle ortaya çýkan deðer( undefined almamak için xorCiktisi(0 xor 0 xor 1 xor 0 ) '1' olarak ilklendirildi)
signal sayac         : integer range 0 to clk_frequency:=0;--Her 1 saniyede bir defa çýktý almak için sayaç kullanacaðýz, 100_000_000 saat darbesinden sonra yani sayac 100_000_000 deðerini alýnca mevcut durum deðeri output deðerine atanacak

begin

 process (clk) begin
    if (rising_edge(clk)) then
               
        if(sayac>=clk_frequency-1) then
              
              output <= mevcut_durum; --  mevcut durumu çýkýþa atýyoruz, mevcut durum clk rising edge olmadýkça sabitir yani output sadece rising edge olan durumlarda deðiþebilir
              sayac<=0;
        else 
        
              sayac<=sayac+1;
       
        end if;
    end if;
  end process;
  
     
     
 process(sayac) begin           
  if(sayac>=clk_frequency-1) then  
              mevcut_durum <= sonraki_durum;-- sonraki durumu mevcut duruma atýyoruz
              xorCiktisi <= mevcut_durum(0) XOR mevcut_durum(1) XOR mevcut_durum(21) XOR mevcut_durum(31);  
              sonraki_durum <= mevcut_durum(30 downto 0) & xorCiktisi; -- mevcut durumu concatenate edip sonraki duruma atýyoruz
  end if;
  end process;
  
 --sayac'a baðlý processteki atamalar mevcut_durum'un output'a atanmasýndan 1 saat darbesi önce gerçekleþir çünkü bu process sayac'ýn deðiþimine baðlýdýr ve sayac clk'a baðlý olan processte deðiþir clk'a baðlý olan process sayac=99_999_999'a göre iþlem yaparken sayac'a baðlý olan process 100_000_000'a göre iþlem yapar                                                                                                                                                                                              
 --Bir baþka diyiþle clk'a baðlý olan process if(99_999_999=100_000_000) deðerinin yanlýþ olduðunu görüp else kýsmýnda 99_999_999+1=100_000_000 iþlemini yapar. Bu deðiþim üzerine sayac'a baðlý olan process mevcut 100_000_000 deðeriyle çalýþýp  if(100_000_000=100_000_000) ifadesinin doðru olduðunu görünce atamalarý yapar. Bir sonraki saat darbesinde yükselen kenarda clk'a baðlý olan process sayac için 100_000_000 deðeriyle iþem yapar ve mevcut_durum'u output'a atar.                                  
  
end Behavioral;