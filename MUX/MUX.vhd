-- ADDR 10 => i_X0
-- ADDR 11 => i_X1
-- DEFAULT => i_X0
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX is
	generic (
		p_DATA_WIDTH	: INTEGER := 16
	);
	port (
		i_SEL : in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-8) downto 0);
      i_X0 	: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
      i_X1 	: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
      o_Y 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
	);
end MUX;

architecture Behavioral of MUX is

	begin

	MUX : process(i_SEL, i_X0, i_X1)
		begin
		
			if (i_SEL = "0000000000001010") then
				o_Y <= i_X0;
			elsif (i_SEL = "0000000000001010") then
				o_Y <= i_X1;
			else
				o_Y <= i_X0;
			end if;
		end process;
	
end Behavioral;