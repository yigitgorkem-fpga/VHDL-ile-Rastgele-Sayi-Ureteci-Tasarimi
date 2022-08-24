library ieee;
use ieee.std_logic_1164.all; -- std_logic ve std_logic_vector'� kullanbilmek i�in std_logic_1164 paketini ekleriz

entity design_32bit_lfsr is --saatin y�kselen kenar�nda mevcut durumu ��k��a atayarak sonucu g�rece�iz
generic (clk_frequency : integer :=100_000_000);

port(

clk         : in  std_logic;
output      : out std_logic_vector(31 downto 0)--32 bitlik bir ��kt�m�z olacak

);

end design_32bit_lfsr;


architecture Behavioral of design_32bit_lfsr is

signal mevcut_durum  : std_logic_vector(31 downto 0):="00101100011010101000111110101100"; -- Shift etmeden �nceki durum
signal sonraki_durum : std_logic_vector(31 downto 0):="00110100100100011011000110110001"; -- Shift edilip xor kap�s��n ��kt�s� 1. bite yaz�l�nca ortaya ��kan durum

signal xorCiktisi    : std_logic:='1'; -- 1.,2.,22.ve 32. regisiterdan gelen 1 ve 0 de�erlerinin xor kap�s�ndan ge�irilmesiyle ortaya ��kan de�er( undefined almamak i�in xorCiktisi(0 xor 0 xor 1 xor 0 ) '1' olarak ilklendirildi)
signal sayac         : integer range 0 to clk_frequency:=0;--Her 1 saniyede bir defa ��kt� almak i�in saya� kullanaca��z, 100_000_000 saat darbesinden sonra yani sayac 100_000_000 de�erini al�nca mevcut durum de�eri output de�erine atanacak

begin

 process (clk) begin
    if (rising_edge(clk)) then
               
        if(sayac>=clk_frequency-1) then
              
              output <= mevcut_durum; --  mevcut durumu ��k��a at�yoruz, mevcut durum clk rising edge olmad�k�a sabitir yani output sadece rising edge olan durumlarda de�i�ebilir
              sayac<=0;
        else 
        
              sayac<=sayac+1;
       
        end if;
    end if;
  end process;
  
     
     
 process(sayac) begin           
  if(sayac>=clk_frequency-1) then  
              mevcut_durum <= sonraki_durum;-- sonraki durumu mevcut duruma at�yoruz
              xorCiktisi <= mevcut_durum(0) XOR mevcut_durum(1) XOR mevcut_durum(21) XOR mevcut_durum(31);  
              sonraki_durum <= mevcut_durum(30 downto 0) & xorCiktisi; -- mevcut durumu concatenate edip sonraki duruma at�yoruz
  end if;
  end process;
  
 --sayac'a ba�l� processteki atamalar mevcut_durum'un output'a atanmas�ndan 1 saat darbesi �nce ger�ekle�ir ��nk� bu process sayac'�n de�i�imine ba�l�d�r ve sayac clk'a ba�l� olan processte de�i�ir clk'a ba�l� olan process sayac=99_999_999'a g�re i�lem yaparken sayac'a ba�l� olan process 100_000_000'a g�re i�lem yapar                                                                                                                                                                                              
 --Bir ba�ka diyi�le clk'a ba�l� olan process if(99_999_999=100_000_000) de�erinin yanl�� oldu�unu g�r�p else k�sm�nda 99_999_999+1=100_000_000 i�lemini yapar. Bu de�i�im �zerine sayac'a ba�l� olan process mevcut 100_000_000 de�eriyle �al���p  if(100_000_000=100_000_000) ifadesinin do�ru oldu�unu g�r�nce atamalar� yapar. Bir sonraki saat darbesinde y�kselen kenarda clk'a ba�l� olan process sayac i�in 100_000_000 de�eriyle i�em yapar ve mevcut_durum'u output'a atar.                                  
  
end Behavioral;