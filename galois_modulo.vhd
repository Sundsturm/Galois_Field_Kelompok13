LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
use work.all;

entity galois_modulo is port ( 
	A : in integer range 0 to 2147483647;
    P : in integer range 0 to 131072;
    res : out integer range 0 to 65536);
end galois_modulo;

architecture Behavioral of galois_modulo is
	type states is (s1, s2, s3);
    signal temp_A					: std_logic_vector(31 downto 0);
	signal temp_P					: std_logic_vector(31 downto 0);
	signal temp_result, temp_shift	: std_logic_vector(31 downto 0);
	signal difference, msb_A, msb_P	: integer;
	--signal k						: integer := 0;
begin
temp_A <= std_logic_vector(to_unsigned(A,32));
temp_P <= std_logic_vector(to_unsigned(P,32));

--Mencari selisih MSB
process(temp_A, temp_P)
begin
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
end process;
difference <= (msb_A - msb_P);

--Left Shift Modulo and Modulo
process(temp_A, temp_P, difference, temp_result, temp_shift)
	variable	k		: integer := 0;
	variable counter	: integer := 0; 
begin
	if difference > 0 then
		for j in 0 to 16 loop
			exit when j = difference;
			temp_shift <= temp_P(30 downto 0) & '0';
		end loop;
		temp_result <= temp_A xor temp_shift;
	elsif (difference <= 0) then
		temp_result <= temp_A xor temp_P;
	end if;
end process;
res <= to_integer(unsigned(temp_result));
end Behavioral;
