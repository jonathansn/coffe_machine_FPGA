--
--	Title: 	Component with 1 register per input and an address control
--	Author:	Jonathan Nascimento
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_COUPLER is
	generic (
				p_DATA_WIDTH	: INTEGER := 16
    );
end TB_COUPLER;

architecture Behavior of TB_COUPLER is

	component COUPLER is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			-- GENERAL
			i_CLK 	: in 	STD_LOGIC;
			i_RST 	: in 	STD_LOGIC;		
			-- FF_SR
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			--i_PRE 	: in 	STD_LOGIC;
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	signal 	w_CLK			:	STD_LOGIC;
	signal 	w_RST			:	STD_LOGIC;
	signal 	w_D			:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal 	w_WR			:	STD_LOGIC;
	signal 	w_ADDR		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
	signal 	w_Q			:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	
	begin
		
	U_COUPLER : COUPLER
		generic map(
					p_DATA_WIDTH	=> p_DATA_WIDTH
		 )
		port map(
			i_CLK 			=>	w_CLK,
			i_RST 			=>	w_RST,
			i_D 				=>	w_D,
			i_WR 				=>	w_WR,
			i_ADDR 			=>	w_ADDR,
			o_Q 				=>	w_Q
		);
		
		w_ADDR(8 downto 3) <= (OTHERS => '0');
		
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
		WAIT FOR 100 NS;
		w_RST <= '1';
		w_ADDR <= (OTHERS => '0');
		WAIT FOR 50 NS;
		w_RST  <= '0';
		WAIT FOR 60 NS;		
		w_ADDR(0) <= not '0';
		w_ADDR(1) <= not '0';
		w_ADDR(2) <= '1';
		w_D		<= "0000000000000001";
		WAIT FOR 60 NS;
		w_WR  <= '1';
		WAIT FOR 100 NS;
		w_WR  <= '0';
		WAIT;
	END PROCESS;
	
end Behavior;