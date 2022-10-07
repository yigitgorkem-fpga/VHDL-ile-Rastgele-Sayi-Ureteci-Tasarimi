library ieee;
use ieee.std_logic_1164.all;  -- std_logic ve std_logic_vector'� kullanbilmek i�in std_logic_1164 paketini ekleriz

entity tb_32bit_lfsr is 
generic (clk_frequency : integer :=100_000_000);
end tb_32bit_lfsr;

architecture Behavioral of tb_32bit_lfsr is

component design_32bit_lfsr is -- component
generic (clk_frequency : integer :=100_000_000);

port(

clk         : in  std_logic;
output      : out std_logic_vector(31 downto 0)--32 bitlik bir ��kt�m�z olacak

);
end component;

signal clk         : std_logic; -- componentin i�erisindeki giri� ve ��k��larla ayn� isimde sinyaller olu�tururuz
signal output      : std_logic_vector(31 downto 0);


constant clock_period : time :=10ns; -- saatimiz bir  periyodunu 10ns'de tamamlar


begin


clock_process: process begin -- clk 5ns '1' olarak, 5ns '0' olacak �ekide ayarland�

clk<='1';
wait for clock_period/2;

clk<='0';
wait for clock_period/2;


end process;

uut: design_32bit_lfsr port map(

clk   =>clk   ,-- giri� ��k�� de�erlerini ayn� isimde olu�turdu�muz sinyallere atar�z
output=>output

);




end Behavioral;


