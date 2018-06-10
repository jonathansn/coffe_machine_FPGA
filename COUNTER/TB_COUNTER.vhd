--
--	Title: 	Test Bench Counter 4 Bit
--	Author:	Jonathan Nascimento
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_COUNTER is
	generic (
		p_DATA_WIDTH	: INTEGER := 16;
		p_SECOUND		: STD_LOGIC_VECTOR := "111";
		p_SECOUND_WIDTH : INTEGER := 4
	);
end TB_COUNTER;

architecture Behavior of TB_COUNTER is

	component COUNTER is		
		port(
			i_CLK			:	in	STD_LOGIC;
			i_RST			:	in	STD_LOGIC;
			i_START		:	in	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_TIME		:	in	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_ADDR		:	in	STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			
			o_DONE		:	out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	signal w_CLK		:	STD_LOGIC;
	signal w_RST		:	STD_LOGIC;
	signal w_START		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_TIME		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_ADDR		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_DONE		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_SECOUND	:	STD_LOGIC_VECTOR((p_SECOUND_WIDTH-1) downto 0);
	
	begin
	
	UU1 : COUNTER
		port map(
			i_CLK			=>	w_CLK,
			i_RST			=>	w_RST,
			i_START		=>	w_START,
			i_TIME		=>	w_TIME,
			i_ADDR		=>	w_ADDR,
			o_DONE		=>	w_DONE
		);	

	-- CLOCK 50MHz
	PROCESS
	BEGIN
		w_CLK <= '1';
		WAIT FOR 20 NS;
		w_CLK <= '0';
		WAIT FOR 20 NS;
	END PROCESS;
	
	-- RESET and START
	PROCESS
	BEGIN
		WAIT FOR 100 NS;
		w_RST <= '1';
		WAIT FOR 100 NS;
		w_RST <= '0';
		WAIT FOR 100 NS;
		w_ADDR <= "000011001"; -- Endere�o pra escrever em i_TIME
		w_TIME  <= "0000000000000111";
		WAIT FOR 50 NS;
		w_ADDR <= "000011010"; -- Endere�o pra escrever em i_START
		w_START <= "0000000000000001";
		WAIT FOR 50 NS;
		w_START <= (OTHERS => 'U');	
		WAIT;
	END PROCESS;
	
end Behavior;