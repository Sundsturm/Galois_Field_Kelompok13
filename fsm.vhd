library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
    port(
        clk, rst: in std_logic;
        operation : in std_logic_vector(0 downto 0);
        res	:	in integer range 0 to 131071;
        comp : in std_logic_vector(0 downto 0);
        enable, sel : out std_logic
    );
end fsm;

architecture Behavioral of fsm is
    type state is (A, B, C, D);
    signal current_state, next_state : state;
begin
    process(rst, clk)
    begin
        if rst = '1' then
            current_state <= A;
        elsif (clk'event and clk = '1') then
			current_state <= next_state;
        end if;
    end process;

    process(current_state, comp, operation, res)
    begin
		case current_state is
            when A =>
				enable <= '0';
				sel <= '0';
                if (operation = "1") then 
                    if res > 0 then
						next_state <= B;
					else
						next_state <= A;
					end if; 
                else 
					next_state <= C;
                end if;
                
            when B =>
				enable <= '0';
				sel <= '0';         
				next_state <= D;

            when D =>
				enable <= '0';
				sel <= '1';
                if (comp = "1") then 
                    next_state <= D; 
                else 
					next_state <= C;
                end if;

            when C =>
				enable <= '1';
				sel <= '1';         
				next_state <= C;
		end case;
    end process;
end Behavioral;
