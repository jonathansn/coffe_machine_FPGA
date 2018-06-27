library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD is
	generic(
		p_DATA_WIDTH	: INTEGER := 16
    );
	port(
		i_BIN			:	in		STD_LOGIC_VECTOR(15 downto 0);
		o_DEC			:	out	STD_LOGIC_VECTOR(6 downto 0)
	);
end BCD;

architecture Behavior of BCD is
	
	begin
	
	CONVERTER : process(i_BIN)
	begin
	  
    case i_BIN is
			when "0000000000000000" => o_DEC <= "1000000"; -- "0"     
			when "0000000000000001" => o_DEC <= "1111001"; -- "1" 
			when "0000000000000010" => o_DEC <= "0100100"; -- "2" 
			when "0000000000000011" => o_DEC <= "0000110"; -- "3" 
			when "0000000000000100" => o_DEC <= "0011001"; -- "4" 
			when "0000000000000101" => o_DEC <= "0010010"; -- "5" 
			when "0000000000000110" => o_DEC <= "0000010"; -- "6" 
			when "0000000000000111" => o_DEC <= "1111000"; -- "7" 
			when "0000000000001000" => o_DEC <= "0000000"; -- "8"     
			when "0000000000001001" => o_DEC <= "0010000"; -- "9" 
			when "0000000000001010" => o_DEC <= "0001000"; -- A
			when "0000000000001011" => o_DEC <= "0000011"; -- B
			when "0000000000001100" => o_DEC <= "1000110"; -- C
			when "0000000000001101" => o_DEC <= "0100001"; -- D
			when "0000000000001110" => o_DEC <= "0000110"; -- E
			when "0000000000001111" => o_DEC <= "0001110"; -- F		 
			when "0000000000010000" => o_DEC <= "1000001"; -- U
			when "0000000000010001" => o_DEC <= "0001001"; -- N
			when "0000000000010010" => o_DEC <= "0000110"; -- E
			when "0000000000010011" => o_DEC <= "0000111"; -- t
			when "0000000000010100" => o_DEC <= "1000111"; -- L
			when "0000000000010101" => o_DEC <= "0001001"; -- H
			when others => o_DEC <= "1111111";
		end case;
				
	end process CONVERTER;
	
end Behavior;