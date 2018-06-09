--
--	Title: 	Test Bench Counter 4 Bit
--	Author:	Jonathan Nascimento
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TB_CHOICES is
	generic (
		p_DATA_WIDTH	: INTEGER := 16
	);
end TB_CHOICES;

architecture Behavior of TB_CHOICES is

	component CHOICES is		
		port(
			 i_D   : IN STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Input
			 i_LE  : IN STD_LOGIC; 													-- Load enable
			 i_CLR : IN STD_LOGIC; 													-- Async. clear
			 i_CLK : IN STD_LOGIC; 													-- Clock
			 o_Q   : OUT STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0) 	-- Output
		);
	end component;
	
	signal w_D			:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_Q			:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_CLK		:	STD_LOGIC;
	signal w_CLR		:	STD_LOGIC;
	signal w_LE			:	STD_LOGIC;
	
	begin
	
	UU1 : CHOICES
		port map(
			i_D   =>	w_D,
			i_LE  => w_LE,
			i_CLR => w_CLR,
			i_CLK =>	w_CLK,
			o_Q   => w_Q
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
		w_CLR <= '1';
		WAIT FOR 100 NS;
		w_CLR <= '0';
		WAIT FOR 100 NS;
		w_LE <= '1';
		w_D <= 	"0000000000011001";
		WAIT FOR 100 NS;
		w_LE <= '0';
		w_CLR <= '1';
	END PROCESS;
	
end Behavior;