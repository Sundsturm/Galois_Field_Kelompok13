LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
use work.all;

entity galois_modulo is port (
	CLK		: IN STD_LOGIC;
	A 		: in integer range 0 to 2147483647;
    P 		: in integer range 0 to 131072;
	comp	: in std_logic_vector(0 downto 0);
    res 	: out integer range 0 to 65536
    );
end galois_modulo;

architecture Behavioral of galois_modulo is
    signal temp_A					: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal temp_P					: std_logic_vector(31 downto 0)	:= "00000000000000000000000000000000";
	signal temp_result				: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal difference, msb_A, msb_P	: integer := 31;
begin
temp_A <= std_logic_vector(to_unsigned(A,32));
temp_P <= std_logic_vector(to_unsigned(P,32));

--Mencari selisih MSB
process(temp_A,temp_P,comp)
begin
--if rising_edge(clk) then
	if comp = "1" then
		for i in 31 downto 0 loop
			msb_A <= i;
			if temp_A(i) = '1' then
				exit;
			end if;
		end loop;
		for j in 31 downto 0 loop
			msb_P <= j;
			if temp_P(j) = '1' then
				exit;
			end if;
		end loop;
	else
		msb_A <= 0;
		msb_P <= 0;
	end if;
--end if;
end process;
difference <= (msb_A - msb_P);

--Left Shift Modulo and Modulo
process(difference, comp, temp_P, temp_A, clk)
	variable	k		: integer := 0;
	variable counter	: integer := 0;
	variable temp_shift : std_logic_vector(31 downto 0) := "00000000000000000000000000000000"; 
begin
temp_shift := temp_P(31 downto 0);
	if comp = "1" then
		if difference > 0  then
			for j in 0 to 16 loop
				exit when j = difference;
				temp_shift := temp_shift(30 downto 0) & "0";
			end loop;
			temp_result <= temp_A xor temp_shift;
		elsif (difference <= 0) then
			temp_result <= temp_A xor temp_P;
		end if;
	else
		temp_result <= temp_A;
	end if;
end process;

process (clk)
begin
if rising_edge(clk) then
	res <= to_integer(unsigned(temp_result));
end if;
end process;

end Behavioral;