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
-- Object        : Entity Work.Address_Decode
-- Last modified : Tue Jan  2 10:51:32 2024
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity Address_Decode is
  port (
    addr_i      : in     std_logic_vector(7 downto 0);
    cs_port_a_o : out    std_logic;
    cs_port_b_o : out    std_logic;
    cs_ram_o    : out    std_logic);
end entity Address_Decode;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.Address_Decode.behavioral
-- Last modified : Tue Jan  2 10:51:32 2024
--------------------------------------------------------------------------------


architecture behavioral of Address_Decode is

begin

cs_ram_o    <= '1' when addr_i(7 DOWNTO 5) = "111" else '0'; 

cs_port_a_o	<= '1' when addr_i = X"10" else '0';
cs_port_b_o	<= '1' when addr_i = X"11" else '0'; 


end architecture behavioral ; -- of Address_Decode
