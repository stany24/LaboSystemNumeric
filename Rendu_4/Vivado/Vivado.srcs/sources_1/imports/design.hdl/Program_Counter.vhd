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
-- Object        : Entity Work.Program_Counter
-- Last modified : Tue Aug 16 09:25:40 2016
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity Program_Counter is
  port (
    clk_i     : in     std_logic;
    reset_i   : in     std_logic;
    PC_load_i : in     std_logic;
    PC_o      : out    std_logic_vector(7 downto 0);
    PC_inc_i  : in     std_logic;
    addr_i    : in     std_logic_vector(7 downto 0);
    restore_i : in     std_logic;
    addr_restor_i : in std_logic_vector(7 downto 0));
end entity Program_Counter;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.Program_Counter.Behavioral
-- Last modified : Tue Aug 16 09:25:40 2016
--------------------------------------------------------------------------------

architecture Behavioral of Program_Counter is
    
 SIGNAL PC_counter : std_logic_vector(7 DOWNTO 0);
  
begin

process(clk_i,reset_i)
begin
  if reset_i = '0' then
    PC_counter <= (others => '0');
  elsif rising_edge(clk_i) then
    if PC_inc_i = '1' THEN
    	PC_counter <= STD_LOGIC_VECTOR(UNSIGNED(PC_counter) + 1);
    elsif PC_load_i = '1' then
    	PC_counter <= addr_i;	  
    end if;
  end if;
end process;

PC_o <= PC_counter;

end architecture Behavioral ; -- of Program_Counter
