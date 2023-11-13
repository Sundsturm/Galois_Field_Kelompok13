library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mux3216 is
	port( rst, selektor: in std_logic;
		  input1: in std_logic_vector(31 downto 0);
		  input2: in std_logic_vector(15 downto 0);
		  output: out std_logic_vector(31 downto 0)
	);
end mux3216;

architecture mux_arc of mux3216 is
begin
	process(rst, selektor, input1, input2)
	begin
	if(rst = '1') then
		output <= "00000000000000000000000000000000"; 
	elsif selektor = '0' then
		output <= input1; 
	else
		output <= "0000000000000000" & input2;
	end if;
	end process;
end mux_arc;