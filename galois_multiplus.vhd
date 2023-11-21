LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
use work.all;

entity galois_multiplus is port (
	A, B	: in integer range 0 to 65536;
	mode	: in std_logic_vector(0 downto 0);
	res		: out integer range 0 to 131072);
end galois_multiplus;

architecture behavioral of galois_multiplus is
	signal num_A	: std_logic_vector(31 downto 0);
	signal num_B	: std_logic_vector(31 downto 0);
	signal op		: integer;
	signal result	: std_logic_vector(31 downto 0);
begin
num_B <= std_logic_vector(to_unsigned(B,32));
op <= to_integer(unsigned(mode));
process (num_B, op)
variable num_1 : std_logic_vector(31 downto 0);
variable temp	: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
begin
	num_1 := std_logic_vector(to_unsigned(A,32));
	if op = 1 then
		--Operasi Perkalian
		for i in 0 to 15 loop
			for j in 0 to 15 loop
				if num_B(j) = '1' then
					temp(j+i) := temp(j+i) XOR num_1(i);
				end if;
			end loop;
		end loop;
		result <= temp;
	else
		result <= num_1 XOR num_B;
	end if;
end process;
num_A <= result;
res <= to_integer(unsigned(num_A));
end behavioral;		