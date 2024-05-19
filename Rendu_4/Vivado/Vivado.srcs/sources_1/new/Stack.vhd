----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2024 16:12:29
-- Design Name: 
-- Module Name: Stack - Behavioral
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

entity Stack is
    Port ( addr_i : in STD_LOGIC_VECTOR (0 to 7);
           push_pop_i : in STD_LOGIC_VECTOR (0 to 1);
           clk_i : in STD_LOGIC;
           reset_i : in STD_LOGIC;
           interupt : in STD_LOGIC;
           addr_o : out STD_LOGIC_VECTOR (0 to 7));
end Stack;

architecture Behavioral of Stack is

begin


end Behavioral;
