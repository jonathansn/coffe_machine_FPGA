library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PORT_AND is
	generic (
				p_DATA_WIDTH	: INTEGER := 16
    );
   port(
      i_ADDR		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
		i_WR			:	in		STD_LOGIC;
		o_WR			:	out	STD_LOGIC
   );
end PORT_AND;

architecture Behavioral of PORT_AND is

	begin

	o_WR <= i_ADDR(0) AND i_ADDR(1) AND i_ADDR(2) AND i_WR;
			 
end Behavioral; 