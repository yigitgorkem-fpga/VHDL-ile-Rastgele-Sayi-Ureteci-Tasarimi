library ieee;
use ieee.std_logic_1164.ALL;

entity tb_16bit_lfrs is 
generic (clk_frequency : integer :=100_000_000);
end tb_16bit_lfrs;

architecture Behavioral of tb_16bit_lfrs is
  component design_8bit_lfrs is
    port (Clk: in std_logic;
          output: out std_logic_vector (15 downto 0));
  end component;

  signal Clk: std_logic;
  signal output: std_logic_vector(15 downto 0);

  constant clk_period : time:=10ns;

BEGIN

 Clk_proc: PROCESS
  BEGIN
    Clk <= '1';
    WAIT FOR clk_period/2;
    Clk <= '0';
    WAIT FOR clk_period/2;
  END PROCESS Clk_proc;
  
  uut: design_8bit_lfrs PORT MAP (
  
  clk=>clk,
  output=>output
  
  );
                 
  
END Behavioral;