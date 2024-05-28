----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2024 17:11:59
-- Design Name: 
-- Module Name: Registers - Behavioral
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

entity Registers is
    Port ( clk_i : in STD_LOGIC;
           reset_i : in STD_LOGIC;
           interupt : in STD_LOGIC;
           CCR_i : in STD_LOGIC_VECTOR (3 downto 0);
           Accu_i : in STD_LOGIC_VECTOR (7 downto 0);
           CCR_o : out STD_LOGIC_VECTOR (3 downto 0);
           Accu_o : out STD_LOGIC_VECTOR (7 downto 0));
end Registers;

architecture Behavioral of Registers is

begin

process(clk_i,reset_i)
begin
  if reset_i = '0' then
    CCR_o <= (others => '0');
    Accu_o <= (others => '0');
  elsif interupt = '0' then
    CCR_o <= (others => '0');
    Accu_o <= (others => '0');
  elsif rising_edge(clk_i) then
    CCR_o <= CCR_i;
    Accu_o <= Accu_i;
  end if;
end process;


end Behavioral;
