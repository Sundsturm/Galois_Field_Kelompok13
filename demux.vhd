library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity demux is
	port( rst, selektor: in std_logic;
		  input1: in integer range 0 to 65536;
		  output1: out integer range 0 to 65536;
		  output2: out integer range 0 to 65536
	);
end demux;

architecture demux_arc of demux is
begin
	process(rst, selektor, input1)
	begin
	if(rst = '1') then
		output1 <= 0;  
		output2 <= 0; 
	elsif selektor = '0' then
		output1 <= input1; 
	else
		output2 <= input1;
	end if;
	end process;
end demux_arc;