library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD is
	port(
		i_CLK			:	in		STD_LOGIC;
		i_RST			:	in		STD_LOGIC;
		i_BIN			:	in		STD_LOGIC_VECTOR(4 downto 0);
		o_DEC			:	out	STD_LOGIC_VECTOR(6 downto 0)
	);
end BCD;

architecture Behavior of BCD is
	
	begin
	
	process(i_BIN)
	begin
		 case i_BIN is
		 when "00000" => o_DEC <= "0000001"; -- "0"     
		 when "00001" => o_DEC <= "1001111"; -- "1" 
		 when "00010" => o_DEC <= "0010010"; -- "2" 
		 when "00011" => o_DEC <= "0000110"; -- "3" 
		 when "00100" => o_DEC <= "1001100"; -- "4" 
		 when "00101" => o_DEC <= "0100100"; -- "5" 
		 when "00110" => o_DEC <= "0100000"; -- "6" 
		 when "00111" => o_DEC <= "0001111"; -- "7" 
		 when "01000" => o_DEC <= "0000000"; -- "8"     
		 when "01001" => o_DEC <= "0000100"; -- "9" 
		 when "01010" => o_DEC <= "0000010"; -- A
		 when "01011" => o_DEC <= "1100000"; -- B
		 when "01100" => o_DEC <= "0110001"; -- C
		 when "01101" => o_DEC <= "1000010"; -- D
		 when "01110" => o_DEC <= "0110000"; -- E
		 when "01111" => o_DEC <= "0111000"; -- F		 
		 when "10000" => o_DEC <= "1000001"; -- U
		 when "10001" => o_DEC <= "0001001"; -- N
		 when "10010" => o_DEC <= "0110000"; -- E
		 when others => o_DEC <= "0000000";
		 end case;
	end process;
	
end Behavior;