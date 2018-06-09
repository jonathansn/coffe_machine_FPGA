library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FF_SR is
	generic (
				p_DATA_WIDTH	: INTEGER := 16
    );
   port(
      o_Q 	: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);      -- Data output
      i_CLK : in 	STD_LOGIC;      -- Clock input
      i_CE 	: in	STD_LOGIC;   	 -- Clock enable input
      i_CLR : in 	STD_LOGIC;  	 -- Asyn clear input
      i_D 	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);      -- Data input
      i_PRE : in 	STD_LOGIC   	 -- Asyn set input
   );
end FF_SR;

architecture Behavioral of FF_SR is

	begin

		process(i_CLR,i_PRE,i_CLK)
		begin

			 if (i_CLR = '1') then
					  o_Q <= (OTHERS => '0');
			 else 
					  if(i_PRE = '1') then
							o_Q <= "0000000000000001";
					  else 
							if (i_CE = '1' and falling_edge(i_CLK)) then 
								o_Q <= i_D;       
						  end if;
					 end if;
			end if;

		end process;

end Behavioral; 