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
-- Object        : Entity Work.nanoControleur
-- Last modified : Tue Jan  2 18:23:59 2024
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity nanoControleur is
  port (
    clk_i    : in     std_logic;
    reset_i  : in     std_logic;
    port_a_i : in     std_logic_vector(7 downto 0);
    port_a_o : out    std_logic_vector(7 downto 0);
    port_b_i : in     std_logic_vector(7 downto 0);
    port_b_o : out    std_logic_vector(7 downto 0);
    
    interupt: in      std_logic);
end entity nanoControleur;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.nanoControleur.Structural
-- Last modified : Tue Jan  2 18:23:59 2024
--------------------------------------------------------------------------------

architecture Structural of nanoControleur is

  signal loc_port_a_i : std_logic_vector(7 downto 0);
  signal loc_port_b_i : std_logic_vector(7 downto 0);
  signal loc_wr       : std_logic;
  signal loc_data_i   : std_logic_vector(7 downto 0);
  signal loc_PC       : std_logic_vector(7  downto 0);
  signal loc_ir       : std_logic_vector(13 downto 0);
  signal loc_data_o   : std_logic_vector(7  downto 0);
  signal loc_data_ram : std_logic_vector(7  downto 0);
  signal loc_addr_o   : std_logic_vector(7  downto 0);
  signal loc_cs_a     : std_logic;
  signal loc_cs_b     : std_logic;
  signal loc_cs_ram   : std_logic;
  
  signal loc_push_pop : std_logic_vector(1 downto 0);
  signal loc_addr_restore : std_logic_vector(7 downto 0);
  
  component Stack
     Port (
       addr_i : in STD_LOGIC_VECTOR (0 to 7);
       push_pop_i : in STD_LOGIC_VECTOR (0 to 1);
       clk_i : in STD_LOGIC;
       reset_i : in STD_LOGIC;
       interupt : in STD_LOGIC;
       addr_o : out STD_LOGIC_VECTOR (0 to 7));
    end component Stack;

  component nanoProcesseur
    port (
      clk_i     : in     std_logic;
      reset_i   : in     std_logic;
      PC_o      : out    std_logic_vector(7  downto 0);
      IR_i      : in     std_logic_vector(13 downto 0);
      addr_o    : out    std_logic_vector(7  downto 0);
      data_i    : in     std_logic_vector(7  downto 0);
      data_o    : out    std_logic_vector(7  downto 0);
      data_wr_o : out    std_logic;
      
      PushPop   : out    std_logic_vector(1 downto 0);
      restore_i : in     std_logic_vector(7 downto 0));
  end component nanoProcesseur;

  component ROM
    port (
      pc_i : in     std_logic_vector(7 downto 0);
      ir_o : out    std_logic_vector(13 downto 0));
  end component ROM;

  component Data_Multiplexer
    port (
      RAM_data_i    : in     std_logic_vector(7 downto 0);
      port_a_data_i : in     std_logic_vector(7 downto 0);
      port_b_data_i : in     std_logic_vector(7 downto 0);
      data_o        : out    std_logic_vector(7 downto 0);
      cs_ram_i      : in     std_logic;
      cs_port_a_i   : in     std_logic;
      cs_port_b_i   : in     std_logic);
  end component Data_Multiplexer;

  component RAM
    port (
      clk_i  : in     std_logic;
      cs_i   : in     std_logic;
      wr_i   : in     std_logic;
      addr_i : in     std_logic_vector(7  downto 0);
      data_i : in     std_logic_vector(7  downto 0);
      data_o : out    std_logic_vector(7  downto 0));
  end component RAM;

  component Output_Register
    port (
      clk_i   : in     std_logic;
      reset_i : in     std_logic;
      cs_i    : in     std_logic;
      load_i  : in     std_logic;
      data_i  : in     std_logic_vector(7 downto 0);
      data_o  : out    std_logic_vector(7 downto 0));
  end component Output_Register;

  component Address_Decode
    port (
      addr_i      : in     std_logic_vector(7 downto 0);
      cs_port_a_o : out    std_logic;
      cs_port_b_o : out    std_logic;
      cs_ram_o    : out    std_logic);
  end component Address_Decode;

begin
  loc_port_a_i <= port_a_i;
  loc_port_b_i <= port_b_i;
  
  stack1: Stack
    port map(
      addr_i => loc_PC,
      push_pop_i => loc_push_pop,
      clk_i => clk_i,
      reset_i => reset_i,
      interupt => interupt,
      addr_o => loc_addr_restore);

  nPr_inst: nanoProcesseur
    port map(
      clk_i     => clk_i,
      reset_i   => reset_i,
      PC_o      => loc_PC,
      IR_i      => loc_ir,
      addr_o    => loc_addr_o,
      data_i    => loc_data_i,
      data_o    => loc_data_o,
      data_wr_o => loc_wr,
      PushPop   => loc_push_pop,
      restore_i =>  loc_addr_restore);

  ROM_inst: ROM
    port map(
      pc_i => loc_PC,
      ir_o => loc_ir);

  Data_Mux_inst: Data_Multiplexer
    port map(
      RAM_data_i    => loc_data_ram,
      port_a_data_i => loc_port_a_i,
      port_b_data_i => loc_port_b_i,
      data_o        => loc_data_i,
      cs_ram_i      => loc_cs_ram,
      cs_port_a_i   => loc_cs_a,
      cs_port_b_i   => loc_cs_b);

  RAM_inst: RAM
    port map(
      clk_i  => clk_i,
      cs_i   => loc_cs_ram,
      wr_i   => loc_wr,
      addr_i => loc_addr_o,
      data_i => loc_data_o,
      data_o => loc_data_ram);

  Port_a_Out_inst: Output_Register
    port map(
      clk_i   => clk_i,
      reset_i => reset_i,
      cs_i    => loc_cs_a,
      load_i  => loc_wr,
      data_i  => loc_data_o,
      data_o  => port_a_o);

  Port_b_Out_inst: Output_Register
    port map(
      clk_i   => clk_i,
      reset_i => reset_i,
      cs_i    => loc_cs_b,
      load_i  => loc_wr,
      data_i  => loc_data_o,
      data_o  => port_b_o);

  Add_Dec_inst: Address_Decode
    port map(
      addr_i      => loc_addr_o,
      cs_port_a_o => loc_cs_a,
      cs_port_b_o => loc_cs_b,
      cs_ram_o    => loc_cs_ram);

end architecture Structural ; -- of nanoControleur

