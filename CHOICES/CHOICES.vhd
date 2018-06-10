-- i_ADDR = "00011011" or 27 => i_D
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CHOICES is
	generic (
				p_DATA_WIDTH	: INTEGER := 16
    );
	port(
		 i_CLK 	:	in 	STD_LOGIC; 													-- Clock
		 i_CLR 	:	in 	STD_LOGIC; 													-- Async. clear
		 i_D   	: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Input
		 i_ADDR	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);		-- Addres
		 i_LE  	: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Load enable
		 o_Q   	: 	out 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0) 		-- Output
	);
end CHOICES;

architecture Behavior of CHOICES is

begin

    process(i_CLK, i_CLR)	 
    begin
	 
		if(i_CLR = '1') then
            o_Q <= (OTHERS => '0');
		elsif rising_edge(i_CLK) then
			
			if(i_ADDR = "000011011") then
				if(i_LE = '1') then
                o_Q <= i_D;
            end if;
			end if;
			
      end if;
		  
    end process;
	 
end Behavior;