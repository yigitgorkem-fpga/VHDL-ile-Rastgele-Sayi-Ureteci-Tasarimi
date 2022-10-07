library ieee;
use ieee.std_logic_1164.ALL;

entity design_16bit_lfrs is

generic (clk_frequency : integer :=100_000_000);
  port (clk: in std_logic;
        output: out std_logic_vector (15 DOWNTO 0));
end design_16bit_lfrs;

architecture Behavioral OF design_16bit_lfrs  is
  signal mevcut_durum : std_logic_vector (15 DOWNTO 0):= "1001100110001001";
  signal sonraki_durum: std_logic_vector (15 DOWNTO 0):= "0101011001100110";
  signal xorCiktisi: std_logic:='0';
  signal sayac : integer range 0 to clk_frequency:=0;
begin

  process (clk) begin
    if (rising_edge(clk)) then
               
        if(sayac>=clk_frequency) then
              
              output <= mevcut_durum; -- (3) mevcut durumu çıkışa atıyoruz, mevcut durum rising edge olmadıkça sabiittir yani outpu sadece rising edge olan durumlarda değişir.
              sayac<=0;
        else 
        
              sayac<=sayac+1;
       
        end if;
    end if;
  end process;
  
  process(sayac) begin
  if(sayac>=clk_frequency) then 
              mevcut_durum <= sonraki_durum;-- (2)sonraki durumu mevcut duruma atıyoruz
              xorCiktisi <= mevcut_durum(15) XOR mevcut_durum(13) XOR mevcut_durum(12) XOR mevcut_durum(10);  
              sonraki_durum <= mevcut_durum(14 downto 0) & xorCiktisi; -- (1)mevcut durumu concatenate edip sonraki duruma atıyoruz
  end if;
  end process;
  
end Behavioral;