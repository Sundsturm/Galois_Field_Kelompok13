library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mux3216 is
	port( rst, selektor: in std_logic;
		  input1: in integer range 0 to 131071;
		  input2: in integer range 0 to 65535;
		  output: out integer range 0 to 131072
	);
end mux3216;

architecture mux_arc of mux3216 is
begin
	process(rst, selektor, input1, input2)
	begin
	if(rst = '1') then
		output <= 0; 
	elsif selektor = '0' then
		output <= input1; 
	else
		output <= input2;
	end if;
	end process;
end mux_arc;