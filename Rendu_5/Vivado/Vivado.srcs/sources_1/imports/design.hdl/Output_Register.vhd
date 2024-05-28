--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 9.3 Revision 2 from HDL Works B.V.
--
-- Ease library  : Work
-- HDL library   : Work
-- Host name     : NB21-B0I-YME
-- User name     : yves.meyer
-- Time stamp    : Tue Jan  2 18:25:44 2024
--
-- Designed by   : M.Meyer/Y.Meyer
-- Company       : Haute Ecole Arc
-- Project info  : nanoProcesseur
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity Work.Output_Register
-- Last modified : Tue Jul  8 11:34:51 2014
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity Output_Register is
  port (
    clk_i   : in     std_logic;
    reset_i : in     std_logic;
    cs_i    : in     std_logic;
    load_i  : in     std_logic;
    data_i  : in     std_logic_vector(7 downto 0);
    data_o  : out    std_logic_vector(7 downto 0));
end entity Output_Register;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.Output_Register.Behavioral
-- Last modified : Tue Jul  8 11:34:51 2014
--------------------------------------------------------------------------------

architecture Behavioral of Output_Register is
  
begin

process(clk_i,reset_i)
begin
  if reset_i = '0' then
    data_o <= (others => '0');
  elsif rising_edge(clk_i) then
    if cs_i = '1' and load_i = '1' then
      data_o <= data_i;
    end if;
  end if;
end process;

end architecture Behavioral ; -- of Output_Register