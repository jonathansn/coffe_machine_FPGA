library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CHOICES is
	generic (
				p_DATA_WIDTH	: INTEGER := 16
    );
	port(
		 i_CLK 		:	in 	STD_LOGIC; 													-- Clock
		 i_CLR 		:	in 	STD_LOGIC; 													-- Async. clear
		 i_PREPARE 	:	in		STD_LOGIC;													-- Button Prepare
		 i_LOAD		:	in		STD_LOGIC;													-- Button Load
		 i_D   		: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Input Switches
		 i_LE  		: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Load enable
		 o_Q   		: 	out 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Output Switches
		 o_PREPARE	:	out	STD_LOGIC;													-- Interrupt Prepare
		 o_LOAD		:	out	STD_LOGIC;													-- Interrupt Load
		 i_RD			:	in		STD_LOGIC
	);
end CHOICES;

architecture Behavior of CHOICES is

	signal w_PREPARE	:	STD_LOGIC;

begin

    process(i_CLK, i_CLR)	 
    begin
	 
		if(i_CLR = '1') then
            o_Q <= (OTHERS => '0');
				o_LOAD <= '0';
				o_PREPARE <= '0';
		elsif rising_edge(i_CLK) then
		
		if(i_LOAD = '0') then
			o_LOAD <= '1';
		else
			o_LOAD <= '0';
		end if;
		
		if(i_PREPARE = '0') then
			o_PREPARE <= '1';
		else
			o_PREPARE <= '0';
		end if;
		
			if(i_LE = "0000000000000001") then				
               o_Q <= i_D;					
         end if;
			
      end if;
		  
    end process;
	 
end Behavior;