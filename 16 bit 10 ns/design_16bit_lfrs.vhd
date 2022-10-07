library ieee;
use ieee.std_logic_1164.ALL;

entity design_16bit_lfrs IS
  port (
 
        clk, rst: in std_logic;
        output: out std_logic_vector (15 downto 0));
end design_16bit_lfrs;

architecture Behavioral OF design_16bit_lfrs IS
  signal mevcut_durum, sonraki_durum: std_logic_vector (15 downto 0);
  signal xorCiktisi: std_logic;
  signal sayac     : integer;
  
begin

process (Clk,Rst)
  begin
    if (Rst = '1') then
      mevcut_durum <= "1011100111011001";
    elsif (rising_edge(clk)) then
      mevcut_durum <= sonraki_durum;-- (2)sonraki durumu mevcut duruma at�yoruz
    end if;
  end process;
  
  xorCiktisi <= mevcut_durum(15) XOR mevcut_durum(13) XOR mevcut_durum(12) XOR mevcut_durum(10); 
  sonraki_durum <= mevcut_durum(14 downto 0) & xorCiktisi; -- (1)mevcut durumu concatenate edip sonraki duruma at�yoruz
  
  process(clk) begin
  
  
  output <= mevcut_durum; -- (3) mevcut durumu ��k��a at�yoruz, mevcut durum rising edge olmad�k�a sabiittir yani outpu sadece rising edge olan durumlarda de�i�ir.


  end process;
end Behavioral;