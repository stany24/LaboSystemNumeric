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
    ir_o <=
         
         -- Allumer 4 leds bicolores rouges
         LOADconst & X"0F" when X"00",
         STOREaddr & X"12" when X"01",

         -- �crire l'�tat des dilswitch sur le barre graphe 1 et en RAM
         LOADaddr & X"10" when X"02",
         STOREaddr & X"E0" when X"03",
         STOREaddr & X"10" when X"04",

         -- Appel de la premi�re fonction de temporisatio
         LOADaddr & X"E0" when X"05",
         CallFunc & X"10" when X"06",

         -- Inverser l'�tat des 4 leds bicolores rouges/vertes
         LOADaddr & X"10" when X"07",
         XORconst & X"FF" when X"08",
         STOREaddr & X"10" when X"09",
         BRA & X"02" when X"0A",

         -- Premi�re fonction de temporisation
         DECaddr & X"E0" when X"10",
         BZ0 & X"14" when X"11", 
         CallFunc & X"18" when X"12",
         BRA & X"10" when X"13", 
         ReturnFunc & X"00" when X"14",

         -- Deuxi�me Sous-routine
         DECaddr & X"E0" when X"18",
         BZ0 & X"1C" when X"19",
         CallFunc & X"20" when X"1A", 
         BRA & X"18" when X"1B",
         ReturnFunc & X"00" when X"1C",

         -- Troisi�me fonction
         DECaddr & X"E0" when X"20",
         BZ0 & X"23" when X"21",
         BRA & X"20" when X"22",
         ReturnFunc & X"00" when X"23",

         -- Fonction d'interruption
         LOADaddr & X"12" when X"30",
         STOREaddr & X"11" when X"31",
         ReturnFunc & X"00" when X"32",
        
         BRA & X"00" when others;
          
end architecture Behavioral ; -- of ROM
