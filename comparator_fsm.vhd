library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comparator_fsm is port (
	A		: in integer range 0 to 2147483646;
	m		: in integer range 0 to 131071;
	comp	: out std_logic_vector(0 downto 0));
end comparator_fsm;

architecture behavioral of comparator_fsm is
	begin
	process(A, m)
	begin
	if A >= m then
		comp <= "1";
	else
		comp <= "0";
	end if;
	end process;
end behavioral;