library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD is
	generic(
		p_DATA_WIDTH	: INTEGER := 16
    );
	port(
		i_CLK			:	in		STD_LOGIC;
		i_RST			:	in		STD_LOGIC;
		i_BIN			:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		o_DEC			:	out	STD_LOGIC_VECTOR(6 downto 0)
	);
end BCD;

architecture Behavior of BCD is
	
	begin
	
	process(i_BIN)
	begin
	
		if(i_RST = '1') then
			o_DEC <= "1111111";
		else
			case i_BIN is
				when "0000000000000000" => o_DEC <= "0000001"; -- "0"     
				when "0000000000000001" => o_DEC <= "1001111"; -- "1" 
				when "0000000000000010" => o_DEC <= "0010010"; -- "2" 
				when "0000000000000011" => o_DEC <= "0000110"; -- "3" 
				when "0000000000000100" => o_DEC <= "1001100"; -- "4" 
				when "0000000000000101" => o_DEC <= "0100100"; -- "5" 
				when "0000000000000110" => o_DEC <= "0100000"; -- "6" 
				when "0000000000000111" => o_DEC <= "0001111"; -- "7" 
				when "0000000000001000" => o_DEC <= "0000000"; -- "8"     
				when "0000000000001001" => o_DEC <= "0000100"; -- "9" 
				when "0000000000001010" => o_DEC <= "0000010"; -- A
				when "0000000000001011" => o_DEC <= "1100000"; -- B
				when "0000000000001100" => o_DEC <= "0110001"; -- C
				when "0000000000001101" => o_DEC <= "1000010"; -- D
				when "0000000000001110" => o_DEC <= "0110000"; -- E
				when "0000000000001111" => o_DEC <= "0111000"; -- F		 
				when "0000000000010000" => o_DEC <= "1000001"; -- U
				when "0000000000010001" => o_DEC <= "0001001"; -- N
				when "0000000000010010" => o_DEC <= "0110000"; -- E
				when others => o_DEC <= "0000000";
			end case;
		end if;
	end process;
	
end Behavior;