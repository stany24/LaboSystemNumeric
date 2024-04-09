LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY testbench IS
END testbench;

ARCHITECTURE structure OF testbench IS

--Declaration du composant UUT (Unit Under Test)
COMPONENT nanoControleur
  port (
    clk_i    : in     std_logic;
    reset_i  : in     std_logic;
    port_a_i : in     std_logic_vector(7 downto 0);
    port_a_o : out    std_logic_vector(7 downto 0);
    port_b_i : in     std_logic_vector(7 downto 0);
    port_b_o : out    std_logic_vector(7 downto 0));
END COMPONENT;

--Signaux locaux pour instanciation composant UUT
--Inputs

SIGNAL clk_i : std_logic;
SIGNAL reset_i : std_logic;
SIGNAL port_a_i : std_logic_vector(7 downto 0);
SIGNAL port_b_i : std_logic_vector(7 downto 0);
--Outputs
SIGNAL port_a_o : std_logic_vector(7 downto 0);
SIGNAL port_b_o : std_logic_vector(7 downto 0);

--signaux propres au testbench
SIGNAL sim_end      : BOOLEAN   := FALSE;
SIGNAL mark_error   : std_logic := '0';
SIGNAL error_number : INTEGER   := 0;
SIGNAL clk_gen      : std_logic := '0';

BEGIN

--Intanciation du composant UUT
uut: nanoControleur
    PORT MAP(
    clk_i => clk_i, 
    reset_i => reset_i,
    port_a_i => port_a_i,
    port_b_i => port_b_i,
    port_a_o => port_a_o,
    port_b_o => port_b_o
    );
--********** PROCESS "clk_gengen" **********
clk_gengen: PROCESS
  BEGIN
  IF sim_end = FALSE THEN
    clk_gen <= '1', '0' AFTER 1 ns;
    clk_i     <= '1', '0' AFTER 5 ns, '1' AFTER 17 ns; --commenter si  on teste une fonction combinatoire (pas de clock)
    wait for 25 ns;
  ELSE
    wait;
  END IF;
END PROCESS;

--********** PROCESS "run" **********
run: PROCESS

  PROCEDURE sim_cycle(num : IN integer) IS
  BEGIN
    FOR index IN 1 TO num LOOP
      wait until clk_gen'EVENT AND clk_gen = '1';
    END LOOP;
  END sim_cycle;

  --********** PROCEDURE "init" **********
  --fixer toutes les entrees du module ? tester (DUT) sauf clk
  PROCEDURE init IS
  BEGIN
    port_a_i <= "00000000";
    port_b_i <= "00000000";
    reset_i <= '0';
  				
  END init;

  --********** PROCEDURE "test_signal" **********
  PROCEDURE test_signal(signal_test, value: IN std_logic; erreur : IN integer) IS 
	BEGIN
	   IF signal_test/= value THEN
         	mark_error <= '1', '0' AFTER 1 ns;
         	error_number <= erreur;
         	ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
	   END IF;
  END test_signal;

 --********** PROCEDURE "test_vecteur" **********
  PROCEDURE test_vecteur(signal_test, value: IN std_logic_vector(7 DOWNTO 0); erreur : IN integer) IS 
	BEGIN
	   IF signal_test/= value THEN
         	mark_error <= '1', '0' AFTER 1 ns;
         	error_number <= erreur;
         	ASSERT FALSE REPORT "Etat du signal non correct" SEVERITY WARNING;
	   END IF;
  END test_vecteur;


BEGIN --debut de la simulation temps t=0ns

        init;  --appel procdure init
        ASSERT FALSE REPORT "la simulation est en cours" SEVERITY NOTE;
        --debut des tests
        
        sim_cycle(200);
        reset_i <= '1';
        sim_cycle(200);
        test_vecteur(port_a_o,"00000000",1);
        sim_cycle(200);
        port_a_i <= "10101010";
        sim_cycle(200);
        test_vecteur(port_a_o,"10101010",2);
        sim_cycle(200);
        port_b_i <= "01010101";
        sim_cycle(200);
        test_vecteur(port_a_o,"11111111",3);
        sim_cycle(200);
        test_vecteur(port_b_o,"01001110",4);
        sim_cycle(200);
        sim_end <= TRUE;
        wait;

END PROCESS;

END;

