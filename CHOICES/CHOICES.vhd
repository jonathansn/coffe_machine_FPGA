library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CHOICES is
	generic (
				p_DATA_WIDTH	: INTEGER := 16
    );
	port(
		 i_CLK : IN STD_LOGIC; 													-- Clock
		 i_CLR : IN STD_LOGIC; 													-- Async. clear
		 i_D   : IN STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Input
		 i_LE  : IN STD_LOGIC; 													-- Load enable
		 o_Q   : OUT STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0) 	-- Output
	);
end CHOICES;

architecture Behavior of CHOICES is

begin

    process(i_CLK, i_CLR)	 
    begin
	 
        if(i_CLR = '1') then
            o_Q <= (OTHERS => '0');
        elsif rising_edge(i_CLK) then
            if(i_LE = '1') then
                o_Q <= i_D;
            end if;
        end if;
		  
    end process;
	 
end Behavior;