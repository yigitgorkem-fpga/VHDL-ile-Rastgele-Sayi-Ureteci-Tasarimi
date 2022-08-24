library ieee;
use ieee.std_logic_1164.all; -- std_logic ve std_logic_vector'ü kullanbilmek için std_logic_1164 paketini ekleriz

entity design_32bit_lfsr is --saatin yükselen kenarýnda mevcut durumu çýkýþa atayarak sonucu göreceðiz

port(

clk         : in  std_logic;
rst         : in  std_logic;
output      : out std_logic_vector(31 downto 0)--32 bitlik bir çýktýmýz olacak

);

end design_32bit_lfsr;


architecture Behavioral of design_32bit_lfsr is

signal mevcut_durum  : std_logic_vector(31 downto 0); -- Shift etmeden önceki durum
signal sonraki_durum : std_logic_vector(31 downto 0); -- Shift edilip xor kapýsýýn çýktýsý 1. bite yazýlýnca ortaya çýkan durum

signal xorCiktisi    : std_logic; -- 1.,2.,22.ve 32. regisiterdan gelen 1 ve 0 deðerlerinin xor kapýsýndan geçirilmesiyle ortaya çýkan deðer

begin

process(clk,rst) begin
    
    if(rst='1') then 
        
        mevcut_durum<="11001100011010111011000111101001";-- ilk duruma rastgele bir sayý girdik
        
    elsif(rising_edge(clk)) then  -- eðer rst '0' ise ve saatin yükselen kenarýna gelinmiþse bu blok çalýþacaktýr
        
        mevcut_durum<=sonraki_durum; --her yükselen kenarda mevcut deðer güncellenir
    
    end if;

end process;

xorCiktisi<= mevcut_durum(0) xor mevcut_durum(1) xor mevcut_durum(21) xor mevcut_durum(31);-- en fazla sayýda xorCýktýsý elde etmek için 1.,2.,22.ve32.registerdan gelen deðerler kullanýlmalýdýr 

sonraki_durum<= mevcut_durum(30 downto 0) & xorCiktisi; -- 1 bit sola kaydýracaðýmýz için xorCiktisi'ni en saða koyup mevcut durumda 32.bite bulunan deðeri yok ederiz 

output<=mevcut_durum; --mevcut durumu çýkýþ deðeri olan outputta görmek için atama yaparýz

end Behavioral;