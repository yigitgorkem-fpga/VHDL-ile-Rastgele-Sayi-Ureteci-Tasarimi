LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_16bit_lfrs IS
END tb_16bit_lfrs;

ARCHITECTURE Behavioral OF tb_16bit_lfrs IS
  COMPONENT design_16bit_lfrs IS
    PORT (Clk, Rst: IN std_logic;
          output: OUT std_logic_vector (15 DOWNTO 0));
  END COMPONENT;

  SIGNAL Clk, Rst: std_logic;
  SIGNAL output: std_logic_vector(15 DOWNTO 0);

  constant clk_period : time:=10ns;

BEGIN

 Clk_proc: PROCESS
  BEGIN
    Clk <= '1';
    WAIT FOR clk_period/2;
    Clk <= '0';
    WAIT FOR clk_period/2;
  END PROCESS Clk_proc;
  
  uut: design_16bit_lfrs PORT MAP (
  
  clk=>clk,
  rst=>rst,
  output=>output
  
  );
                 
  stim_process: PROCESS
  BEGIN
    Rst<= '1';
    WAIT FOR clk_period;
    Rst <= '0';
    WAIT FOR clk_period;
    WAIT;
  END PROCESS stim_process;

END Behavioral;