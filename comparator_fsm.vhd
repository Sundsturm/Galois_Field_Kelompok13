library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comparator_fsm is port (
	A		: in integer range 0 to 2147483646;
	m		: in integer range 0 to 16;
	comp	: out std_logic_vector(0 downto 0));
end comparator_fsm;

architecture behavioral of comparator_fsm is
	signal m_num : integer;
	begin
	process(A, m_num)
	--Function to count 2^m
	impure function powerOf (number : integer := 0) return integer is
		variable output : integer := 0;
	begin
		for i in 1 to m loop
			if i = 1 then
				output := 2;
			else
				output := output * 2;
			end if;
		end loop;
		return output;
	end function;

	begin
	m_num <= powerOf(number => m);
	if A >= m_num then
		comp <= "1";
	else
		comp <= "0";
	end if;
	end process;
end behavioral;
