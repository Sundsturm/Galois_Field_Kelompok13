library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use work.all; 
entity top is 
	port( 
		A, B: in integer range 0 to 65535;
		rst, clk: in std_logic; 
		Op: in std_logic_vector(0 downto 0);
		P: in integer range 0 to 131072;
		m: in integer range 0 to 131071;
		res : out integer range 0 to 65536 
	); 
end top;

architecture behavioral of top is 
-- blok komparator
component comparator_fsm is 
	port( 
		A		: in integer range 0 to 2147483646;
		m		: in integer range 0 to 131071;
		comp	: out std_logic_vector(0 downto 0)
	);
end component; 
-- blok fsm
component fsm is 
	port( 
        clk, rst: in std_logic;
        operation : in std_logic_vector(0 downto 0);
        comp : in std_logic_vector(0 downto 0);
        enable, sel : out std_logic
    );
end component; 
-- blok modulo
component galois_modulo is 
	port( 
		A 		: in integer range 0 to 2147483647;
		P 		: in integer range 0 to 131072;
		comp	: in std_logic_vector(0 downto 0);
		res 	: out integer range 0 to 65536
    );
end component; 
-- blok perkalian dan pertambahan
component galois_multiplus is 
	port( 
		clk					: in std_logic;
		A, B				: in integer range 0 to 65535;
		mode				: in std_logic_vector(0 downto 0);
		res_addition		: out integer range 0 to 65535;
		res_multiply		: out integer range 0 to 131071
	);
end component; 
-- blok mux bagian atas
component mux3216 is 
	port( 
		rst, selektor: in std_logic;
		input1: in integer range 0 to 131071;
		input2: in integer range 0 to 65535;
		output: out integer range 0 to 131072
	);
end component;
-- blok mux bawah
component mux is 
	port( 
		rst: in std_logic;
		selektor: in std_logic_vector(0 downto 0);
		input1: in integer range 0 to 65536;
		input2: in integer range 0 to 65536;
		output: out integer range 0 to 65536
	);
end component;
-- blok demux
component demux is 
	port( 
		rst, selektor: in std_logic;
		input1: in integer range 0 to 65536;
		output1: out integer range 0 to 65536;
		output2: out integer range 0 to 65536
	);
end component;

signal r_mux3216: integer range 0 to 131072;
signal r_com: std_logic_vector(0 downto 0);
signal r_add: integer range 0 to 65535;
signal r_mult: integer range 0 to 131071;
signal r_sel: std_logic;
signal r_demux1: integer range 0 to 65536;
signal r_muxatas: integer range 0 to 131072;
signal r_enable: std_logic;
signal r_mod: integer range 0 to 65536;
signal r_demux2: integer range 0 to 65536;
signal r_mux: integer range 0 to 65536; 
begin 
	-- alur data 
	X_COM: comparator_fsm port map(r_muxatas, m, r_com); 
	X_MULT: galois_multiplus port map(clk, A, B, Op, r_add, r_mult); 
	X_MUX3216: mux3216 port map(rst, r_sel, r_mult, r_demux1, r_muxatas);
	X_FSM: fsm port map(clk, rst, Op, r_com, r_enable, r_sel); 
	X_MOD: galois_modulo port map (r_muxatas, P, r_com, r_mod);
	X_DEMUX: demux port map (rst, r_enable, r_mod, r_demux1, r_demux2); 
	X_MUX: mux port map(rst, Op, r_add, r_demux2, r_mux);
	-- hasil 
	res <= r_mux; 
end behavioral;
