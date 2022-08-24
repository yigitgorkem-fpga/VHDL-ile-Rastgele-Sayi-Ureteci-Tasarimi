library ieee;
use ieee.std_logic_1164.all;  -- std_logic ve std_logic_vector'ü kullanbilmek için std_logic_1164 paketini ekleriz

entity tb_32bit_lfsr is -- boþ entity
end tb_32bit_lfsr;

architecture Behavioral of tb_32bit_lfsr is

component design_32bit_lfsr is -- component

port(

clk         : in  std_logic;
rst         : in  std_logic;
output      : out std_logic_vector(31 downto 0)

);

end component;

signal clk         : std_logic; -- componentin içerisindeki giriþ ve çýkýþlarla ayný isimde sinyaller oluþtururuz
signal rst         : std_logic;
signal output      : std_logic_vector(31 downto 0);


constant clock_period : time :=2ps; -- saatimiz bir  periyodunu 2ps'de tamamlar


begin


clock_process: process begin -- clk 1ps '1' olarak, 1ps '0' olacak þekide ayarlandý

clk<='1';
wait for clock_period/2;

clk<='0';
wait for clock_period/2;


end process;

uut: design_32bit_lfsr port map(

clk   =>clk   ,-- giriþ çýkýþ deðerlerini ayný isimde oluþturduðmuz sinyallere atarýz
rst   =>rst   ,
output=>output

);


reset_process : process begin -- rst 1ps '1' olduktan sonra devamlý olarak '0' deðerini alýr 

rst<='1';   -- rst'in 1'e eþit olamasý sayesinde mevcut_durum "10101100011010111010000111101001" olarak ilklendirilebilidi
wait for clock_period/2;


rst<='0';
wait;

end process;

end Behavioral;


