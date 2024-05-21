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
-- Object        : Entity Work.Sequenceur
-- Last modified : Tue Dec  2 09:53:27 2014
--------------------------------------------------------------------------------

library ieee;
use Work.nanoProcesseur_package.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity Sequenceur is
  port (
    clk_i       : in     std_logic;
    reset_i     : in     std_logic;
    PC_inc_o    : out    std_logic;
    PC_load_o   : out    std_logic;
    IR_load_o   : out    std_logic;
    opcode_i    : in     std_logic_vector(5 downto 0);
    CCR_i       : in     std_logic_vector(3 downto 0);
    oper_sel_o  : out    std_logic_vector(2 downto 0);
    oper_load_o : out    std_logic;
    Accu_load_o : out    std_logic;
    CCR_load_o  : out    std_logic;
    data_wr_o   : out    std_logic);
end entity Sequenceur;

--------------------------------------------------------------------------------
-- Object        : Architecture Work.Sequenceur.Behavioral
-- Last modified : Tue Dec  2 09:53:27 2014
--------------------------------------------------------------------------------

architecture Behavioral of Sequenceur is

  type STATE_TYPE is (sRESET, sIR_LOAD, sIR_DECODE, sOPCODE_DECODE);
  signal state : STATE_TYPE;
  
begin


p1:process(clk_i,reset_i)
begin

  if reset_i = '0' then
	state <= sRESET;
  elsif rising_edge(clk_i) then
    
    case state is
    
      when sRESET =>
     	state <= sIR_LOAD;
        
      when sIR_LOAD =>
		state <= sIR_DECODE;
      
      when sIR_DECODE =>
        state <= sOPCODE_DECODE;
        
      when sOPCODE_DECODE =>
        state <= sIR_LOAD;

      when others =>
        -- Erreur, �tat non pr�vus. Reset du s�quenceur
       	state       <= sRESET;
      
    end case;

  end if;
  
end process;

--ASSIGNATION COMBINATOIRE DES SORTIE EN FONCTION DE L'ETAT (STATE) et pour certaines sorties des entr�es

PC_load_o <= '1' WHEN state = sOPCODE_DECODE ELSE '0';

IR_load_o <= '1' WHEN state = sIR_LOAD ELSE '0';

oper_load_o <= '1' WHEN state = sIR_DECODE ELSE '0';

data_wr_o <= '1' WHEN state = sOPCODE_DECODE AND opcode_i = STOREaddr ELSE '0'; 

-- PC_inc_o
P2:process(state,opcode_i,CCR_i)
begin
	if state = sOPCODE_DECODE then
		
		PC_inc_o <= '1';
		
        case opcode_i is          
          when BRA =>
            PC_inc_o <= '0';
          when BZ0 =>
            if CCR_i(Zidx) = '0' then
              PC_inc_o <= '0';
            end if;            
	        when BZ1 =>
            if CCR_i(Zidx) = '1' then
              PC_inc_o <= '0';
            end if;
          when BC0 =>
            if CCR_i(Cidx) = '0' then
              PC_inc_o <= '0';
            end if;
	        when BC1 =>
            if CCR_i(Cidx) = '1' then
              PC_inc_o <= '0';
            end if;
          when BV0 =>
            if CCR_i(Vidx) = '0' then
              PC_inc_o <= '0';
            end if;
	        when BV1 =>
            if CCR_i(Vidx) = '1' then
              PC_inc_o <= '0';
            end if;
          when BN0 =>
            if CCR_i(Nidx) = '0' then
              PC_inc_o <= '0';
            end if;
	        when BN1 =>
            if CCR_i(Nidx) = '1' then
              PC_inc_o <= '0';
            end if;	        
          when others =>
            null;
        end case;

	else       
	   PC_inc_o <= '0';
	end if;
end process; 

-- oper_sel_o
P3:process(state,opcode_i)
begin
	if state = sIR_DECODE then	
       -- s�lection des op�randes en fonction de l'opcode
        case opcode_i is
          -- 1 op�rande
          when ROLaccu   | RORaccu |
               INCaccu   | 
               DECaccu   | 
               NEGaccu     =>
            oper_sel_o <= MUX_ACCU;

       	  when LOADconst |
               NEGconst    =>
            oper_sel_o <= MUX_CONST;

          when LOADaddr |
               INCaddr  |
               DECaddr  |
               NEGaddr    =>
            oper_sel_o <= MUX_DATA;
            
          -- 2 op�randes
       	  when ANDconst | ORconst   | XORconst |
               ADDconst | ADCconst  =>
            oper_sel_o <= MUX_ACCU_CONST;

       	  when ANDaddr | ORaddr   | XORaddr |
               ADDaddr | ADCaddr  =>
            oper_sel_o <= MUX_ACCU_DATA;
              
          when others =>
            oper_sel_o <= (others => '0');  
        end case;

	else       
	   oper_sel_o <= (others => '0'); 
	end if;
end process;

-- Accu_load_o
P4:process(state,opcode_i)
begin
	if state = sOPCODE_DECODE then
		case opcode_i is
          when LOADaddr | LOADconst |
               ANDconst | ANDaddr   | 
               ORconst  | ORaddr    |
               XORconst | XORaddr   |
               RORaccu  | ROLaccu   |
               ADDconst | ADDaddr   | ADCaddr | ADCconst |
               INCaccu  | INCaddr   |
               DECaccu  | DECaddr   |
               NEGaccu  | NEGaddr   | NEGconst =>
          	Accu_load_o <= '1'; 
            
          when others =>
          	Accu_load_o <= '0'; 
          	
          end case;
	else
	   Accu_load_o <= '0';
	end if;
end process;

--CCR_load_o
P5:process(state,opcode_i)
begin
	if state = sOPCODE_DECODE then
		case opcode_i is
          when LOADaddr | LOADconst |
               ANDconst | ANDaddr   | 
               ORconst  | ORaddr    |
               XORconst | XORaddr   |
               RORaccu  | ROLaccu   |
               ADDconst | ADDaddr   | ADCaddr | ADCconst |
               INCaccu  | INCaddr   |
               DECaccu  | DECaddr   |
               NEGaccu  | NEGaddr   | NEGconst =>
          	CCR_load_o <= '1';
          	
          when SETC | CLRC | TRFNC =>
          	CCR_load_o <= '1'; 
            
          when others =>
          	CCR_load_o <= '0';
          		
          end case;
	else
	   CCR_load_o <= '0';
	end if;
end process;

end architecture Behavioral ; -- of Sequenceur
