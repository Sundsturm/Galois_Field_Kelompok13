library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mux is
	port( rst: in std_logic;
		  selektor: in std_logic_vector(0 downto 0);
		  input1: in integer range 0 to 65536;
		  input2: in integer range 0 to 65536;
		  output: out integer range 0 to 65536
	);
end mux;

architecture mux_arc of mux is
begin
	process(rst, selektor, input1, input2)
	begin
	if(rst = '1') then
		output <= 0; 
	elsif selektor = "0" then
		output <= input1; 
	else
		output <= input2;
	end if;
	end process;
end mux_arc;