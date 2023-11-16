LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all;
use IEEE.MATH_REAL.ALL;
use work.all;

entity cek_prima is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           input_number : in integer range 0 to 65536;
           is_prime : out STD_LOGIC);
end cek_prima;

architecture Behavioral of cek_prima is
    signal n : integer:=2;
    signal remainder : integer;
	signal prime : std_logic := '1';
	
begin
    process(clk, rst)
    begin
        if rst = '1' then
            n <= 2;
            prime <= '1';
        elsif rising_edge(clk) then
			if n < input_number and prime = '1' then
				remainder <= (input_number) mod n;
                    if remainder = 0 then
                        prime <= '0'; -- Input is not prime
                    else
                        prime <= '1'; -- Input is prime
                    end if;
	if n = 2 then
        	n <= n+1;
	else
		n <= n+2;
	end if;
        end if;
    
    if input_number = 1 or input_number = 0 then
		is_prime <= '0';
	else
		is_prime <= prime;
	end if;
    end process;
end Behavioral;
