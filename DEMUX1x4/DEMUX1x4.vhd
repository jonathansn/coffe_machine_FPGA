-- ADDR 20 => o_Y0
-- ADDR 21 => o_Y1
-- ADDR 22 => o_Y2
-- ADDR 23 => o_Y3
-- ADDR 24 => o_Y4
-- ADDR 25 => o_Y5
-- ADDR 26 => o_Y6
-- ADDR 27 => o_Y7
-- DEFAULT o_Y0

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEMUX1x4 is
	generic (
		p_DATA_WIDTH	: INTEGER := 16
	);
	port (
		i_SEL : in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-8) downto 0);
      i_X 	: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
      o_Y0 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		o_Y1 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		o_Y2 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		o_Y3 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		o_Y4 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		o_Y5 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		o_Y6 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
		o_Y7 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
	);
end DEMUX1x4;

architecture Behavioral of DEMUX1x4 is

	begin

	process(i_SEL, i_X)
		begin
		
			if(i_SEL = "000010100") then
				o_Y0 <= i_X;
			elsif(i_SEL = "000010101") then
				o_Y1 <= i_X;
			elsif(i_SEL = "000010110") then
				o_Y2 <= i_X;
			elsif(i_SEL = "000010111") then
				o_Y3 <= i_X;
			elsif(i_SEL = "000011000") then
				o_Y4 <= i_X;
			elsif(i_SEL = "000011001") then
				o_Y5 <= i_X;
			elsif(i_SEL = "000011010") then
				o_Y6 <= i_X;
			elsif(i_SEL = "000011011") then
				o_Y7 <= i_X;
			else
				o_Y0 <= i_X;
			end if;
			
	end process;
	
end Behavioral;