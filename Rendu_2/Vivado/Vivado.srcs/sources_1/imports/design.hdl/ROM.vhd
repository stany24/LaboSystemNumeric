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
-- Object        : Entity Work.ROM
-- Last modified : Tue Jan  2 10:51:32 2024
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity ROM is
  port (
    pc_i : in     std_logic_vector(7 downto 0);
    ir_o : out    std_logic_vector(13 downto 0));
end entity ROM;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.ROM.Behavioral
-- Last modified : Tue Jan  2 10:51:32 2024
--------------------------------------------------------------------------------

architecture Behavioral of ROM is


begin


with pc_i select
  ir_o <= --d�but du programme en adresse 0      
          --mn�monique op�rande  adresse    
         LOADaddr 	& X"10" when	X"00",  -- Accu = port a
         STOREaddr 	& X"11" when	X"01",  -- port b = Accu
         BRA       	& X"00" when	X"02",  -- saut � 00                    
         BRA		& X"FF" when 	others;  
          

end architecture Behavioral ; -- of ROM
