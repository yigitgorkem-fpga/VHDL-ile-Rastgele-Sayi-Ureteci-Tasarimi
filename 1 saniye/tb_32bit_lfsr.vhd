library ieee;
use ieee.std_logic_1164.all;  -- std_logic ve std_logic_vector'ü kullanbilmek için std_logic_1164 paketini ekleriz

entity tb_32bit_lfsr is 
generic (clk_frequency : integer :=100_000_000);
end tb_32bit_lfsr;

architecture Behavioral of tb_32bit_lfsr is

component design_32bit_lfsr is -- component
generic (clk_frequency : integer :=100_000_000);

port(

clk         : in  std_logic;
output      : out std_logic_vector(31 downto 0)--32 bitlik bir çýktýmýz olacak

);
end component;

signal clk         : std_logic; -- componentin içerisindeki giriþ ve çýkýþlarla ayný isimde sinyaller oluþtururuz
signal output      : std_logic_vector(31 downto 0);


constant clock_period : time :=10ns; -- saatimiz bir  periyodunu 10ns'de tamamlar


begin


clock_process: process begin -- clk 5ns '1' olarak, 5ns '0' olacak þekide ayarlandý

clk<='1';
wait for clock_period/2;

clk<='0';
wait for clock_period/2;


end process;

uut: design_32bit_lfsr port map(

clk   =>clk   ,-- giriþ çýkýþ deðerlerini ayný isimde oluþturduðmuz sinyallere atarýz
output=>output

);




end Behavioral;


