library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity INTERRUPCAO is
    Port ( 
			i_CLK   	: in  STD_LOGIC;
			i_RST   	: in  STD_LOGIC;
			i_INT_ADD	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			i_REG_INT   : in  STD_LOGIC_VECTOR(5 DOWNTO 0);
			i_INT		: in  STD_LOGIC_VECTOR(5 DOWNTO 0);
			o_BUSY      : out STD_LOGIC;
			o_INT		: out STD_LOGIC_VECTOR(5 DOWNTO 0)
	 );
end INTERRUPCAO;

architecture Behavioral of INTERRUPCAO is
	signal w_INT	: STD_LOGIC_VECTOR(5 DOWNTO 0);
	
	
begin

	w_INT <= i_INT;
	
	o_INT(0) <= w_INT(0) and i_REG_INT(0);
	o_INT(1) <= w_INT(1) and (not w_INT(0)) and i_REG_INT(1);
	o_INT(2) <= w_INT(2) and (not w_INT(1)) and (not w_INT(0)) and i_REG_INT(2);
	
	o_INT(3) <= w_INT(3) and (not w_INT(2)) and (not w_INT(1)) and (not w_INT(0)) and i_REG_INT(3);
	o_INT(4) <= w_INT(4) and (not w_INT(3)) and (not w_INT(2)) and (not w_INT(1)) and (not w_INT(0)) and i_REG_INT(4);
	o_INT(5) <= w_INT(5) and (not w_INT(4)) and (not w_INT(3)) and (not w_INT(2)) and (not w_INT(1)) and (not w_INT(0)) and i_REG_INT(5);

	
	process(i_CLK, i_RST)
	begin
		if (i_RST = '1') then
			o_BUSY <= '0';
		elsif rising_edge (i_CLK) then
			if (i_INT_ADD = "00") then
				o_BUSY <= '0';
			else
				o_BUSY <= '1';
			end if;
		end if;
	end process;	

end behavioral;
	