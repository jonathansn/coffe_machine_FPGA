library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_BCD is
	generic(
		p_DATA_WIDTH	: INTEGER := 16
    );
end TB_BCD;

architecture Behavior of TB_BCD is

	component BCD is
		generic(
			p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			i_CLK			:	in		STD_LOGIC;
			i_RST			:	in		STD_LOGIC;
			i_BIN			:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_WR			:	in		STD_LOGIC;
			o_DEC			:	out	STD_LOGIC_VECTOR(6 downto 0)
		);
	end component;
	
	-- SIGNALS													-- Clear Flip Flop
	signal w_CLK			:	STD_LOGIC;
	signal w_RST			:	STD_LOGIC;
	signal w_BIN			:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_WR				:	STD_LOGIC;
	signal w_DEC			:	STD_LOGIC_VECTOR(6 downto 0);
	
	begin
	
	UU1 : BCD 
		Port map(
			i_CLK			=> w_CLK,
			i_RST			=> w_RST,
			i_BIN			=> w_BIN,
			i_WR			=> w_WR,
			o_DEC			=> w_DEC
		);
		
			-- CLOCK 50MHz
	PROCESS
	BEGIN
		w_CLK <= '1';
		WAIT FOR 20 NS;
		w_CLK <= '0';
		WAIT FOR 20 NS;
	END PROCESS;
	
	PROCESS
	BEGIN
		
	END PROCESS;
	
end Behavior;