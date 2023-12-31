LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
use work.all;

entity galois_multiplus is port (
	clk,rst				: in std_logic;
	A, B				: in integer range 0 to 65535;
	mode				: in std_logic_vector(0 downto 0);
	res_addition		: out integer range 0 to 65535;
	res_multiply		: out integer range 0 to 131071
	);
end galois_multiplus;

architecture behavioral of galois_multiplus is
	signal num_B	: std_logic_vector(31 downto 0);
	signal op		: integer;
	signal result_add	: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal result_mult	: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal num_A_mult	: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal num_A_add	: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
begin
num_B <= std_logic_vector(to_unsigned(B,32));
op <= to_integer(unsigned(mode));
process (num_B, op, result_add, result_mult, clk, A, rst)
variable num_1 	: std_logic_vector(31 downto 0);
variable temp	: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";
variable i		: integer:= 0;
begin
if rst = '1' then
	result_add <= "00000000000000000000000000000000";
	result_mult <= "00000000000000000000000000000000";
else
	num_1 := std_logic_vector(to_unsigned(A,32));
	if op = 1 then
		--Operasi Perkalian
		if rising_edge(clk) and i < 16 then
			for j in 0 to 15 loop
				if num_B(j) = '1' then
					temp(j+i) := temp(j+i) XOR num_1(i);
				end if;
			end loop;
			i := i + 1;
		elsif rising_edge(clk) and i = 16 then
			result_mult <= temp;
		end if;
		result_add <= "00000000000000000000000000000000";
	else
		result_mult <= "00000000000000000000000000000000";
		result_add <= num_1 XOR num_B;
	end if;
end if;
end process;
num_A_mult <= result_mult;
num_A_add <= result_add;
res_addition <= to_integer(unsigned(num_A_add));
res_multiply <= to_integer(unsigned(num_A_mult));
end behavioral;		