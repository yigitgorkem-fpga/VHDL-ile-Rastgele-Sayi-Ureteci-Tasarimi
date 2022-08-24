library ieee;
use ieee.std_logic_1164.all; -- std_logic ve std_logic_vector'� kullanbilmek i�in std_logic_1164 paketini ekleriz

entity design_32bit_lfsr is --saatin y�kselen kenar�nda mevcut durumu ��k��a atayarak sonucu g�rece�iz

port(

clk         : in  std_logic;
rst         : in  std_logic;
output      : out std_logic_vector(31 downto 0)--32 bitlik bir ��kt�m�z olacak

);

end design_32bit_lfsr;


architecture Behavioral of design_32bit_lfsr is

signal mevcut_durum  : std_logic_vector(31 downto 0); -- Shift etmeden �nceki durum
signal sonraki_durum : std_logic_vector(31 downto 0); -- Shift edilip xor kap�s��n ��kt�s� 1. bite yaz�l�nca ortaya ��kan durum

signal xorCiktisi    : std_logic; -- 1.,2.,22.ve 32. regisiterdan gelen 1 ve 0 de�erlerinin xor kap�s�ndan ge�irilmesiyle ortaya ��kan de�er

begin

process(clk,rst) begin
    
    if(rst='1') then 
        
        mevcut_durum<="11001100011010111011000111101001";-- ilk duruma rastgele bir say� girdik
        
    elsif(rising_edge(clk)) then  -- e�er rst '0' ise ve saatin y�kselen kenar�na gelinmi�se bu blok �al��acakt�r
        
        mevcut_durum<=sonraki_durum; --her y�kselen kenarda mevcut de�er g�ncellenir
    
    end if;

end process;

xorCiktisi<= mevcut_durum(0) xor mevcut_durum(1) xor mevcut_durum(21) xor mevcut_durum(31);-- en fazla say�da xorC�kt�s� elde etmek i�in 1.,2.,22.ve32.registerdan gelen de�erler kullan�lmal�d�r 

sonraki_durum<= mevcut_durum(30 downto 0) & xorCiktisi; -- 1 bit sola kayd�raca��m�z i�in xorCiktisi'ni en sa�a koyup mevcut durumda 32.bite bulunan de�eri yok ederiz 

output<=mevcut_durum; --mevcut durumu ��k�� de�eri olan outputta g�rmek i�in atama yapar�z

end Behavioral;