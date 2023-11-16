library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
    port(
        clk, rst, op, comp : in std_logic;
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

    process(current_state, comp, op)
    begin
        case current_state is
            when A =>
		enable <= '0';
		sel <= '0';
                if (op = '1') then 
                    next_state <= B; 
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
                if (comp = '1') then 
                    next_state <= D; 
                else 
		    next_state <= C;
                end if;

            when C =>
		enable <= '1';
		sel <= '1';         
		next_state <= A;
        end case;
    end process;
end Behavioral;
