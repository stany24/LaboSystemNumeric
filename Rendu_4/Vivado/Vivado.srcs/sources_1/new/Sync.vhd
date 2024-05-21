----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2024 16:33:13
-- Design Name: 
-- Module Name: Sync - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sync is
    Port ( clk_i : in STD_LOGIC;
           reset_i : in STD_LOGIC;
           interupt : in STD_LOGIC;
           sInterupt : out STD_LOGIC);
end Sync;

architecture Behavioral of Sync is

begin

process(clk_i)
begin
  if reset_i = '0' then
    sInterupt <= '1';
  elsif rising_edge(clk_i) then
    sInterupt <= interupt;
  end if;
end process;


end Behavioral;
