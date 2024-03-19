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
-- Object        : Entity Work.Status_Register
-- Last modified : Tue Jul  8 10:48:57 2014
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity Status_Register is
  port (
    clk_i      : in     std_logic;
    reset_i    : in     std_logic;
    CCR_load_i : in     std_logic;
    CCR_i      : in     std_logic_vector(3 downto 0);
    CCR_o      : out    std_logic_vector(3 downto 0));
end entity Status_Register;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.Status_Register.Behavioral
-- Last modified : Tue Jul  8 10:48:57 2014
--------------------------------------------------------------------------------

architecture Behavioral of Status_Register is
  
begin

process(clk_i,reset_i)
begin
  if reset_i = '0' then
    CCR_o <= (others => '0');
  elsif rising_edge(clk_i) then
    if CCR_load_i = '1' then
      CCR_o <= CCR_i;
    end if;
  end if;
end process;

end architecture Behavioral ; -- of Status_Register