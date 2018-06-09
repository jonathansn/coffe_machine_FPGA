--
--	Title: 	Counter 4 Bit
--	Author:	Jonathan Nascimento
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

------------------------------ ENTITY -------------------------------

entity PREPARE is
	generic (
		p_DATA_WIDTH	: INTEGER := 16;
		p_SECOUND_WIDTH : INTEGER := 4
    );
	port(
		-- GENERAL
		i_CLK			:	in		STD_LOGIC;
		i_RST			:	in		STD_LOGIC;
		-- COUNTER
		i_START		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_TIME		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_ADDR		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);		
		o_DONE		:	out	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		-- CHOICES
		i_D   		: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		o_Q   		: 	out 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_LE  		: 	in 	STD_LOGIC
	);
end PREPARE;

architecture Behavior of PREPARE is

------------------------------ COMPONENTS -------------------------------

	-- COUNTER
	component COUNTER is
		generic (
			p_DATA_WIDTH	: INTEGER := 16;
			p_SECOUND_WIDTH : INTEGER := 4
		 );
		port(
			i_CLK		:	in		STD_LOGIC;
			i_RST		:	in		STD_LOGIC;
			i_START	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_TIME	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_ADDR	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);			
			o_DONE	:	out	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;

	-- CHOICES
	component CHOICES is
		generic (
			p_DATA_WIDTH	: INTEGER := 16
		);
		port(
			i_D   	: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_LE  	: 	in 	STD_LOGIC;
			i_CLR 	: 	in 	STD_LOGIC;
			i_CLK 	: 	in 	STD_LOGIC;
			o_Q   	: 	out 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
------------------------------ SIGNALS -------------------------------
	
	-- GENERAL
	signal w_i_CLK		:	STD_LOGIC;
	signal w_i_RST		:	STD_LOGIC;
	-- COUNTER		
	signal w_i_START	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_i_TIME	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_i_ADDR	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);		
	signal w_o_DONE	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	-- CHOICES
	signal w_i_D   	: 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_i_LE  	:	STD_LOGIC;
	signal w_o_Q   	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	
	begin
	
------------------------------ INSTANCES -------------------------------

	-- COUNTER
	U_COUNTER : COUNTER
	generic map(
		p_DATA_WIDTH 		=>		p_DATA_WIDTH,
		p_SECOUND_WIDTH 	=>		p_SECOUND_WIDTH
	)
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,
		i_START				=>		i_START,
		i_TIME				=>		i_TIME,
		i_ADDR				=>		i_ADDR,
		o_DONE				=>		o_DONE
	);
	
	-- CHOICES
	U_CHOICES : CHOICES
	generic map(
		p_DATA_WIDTH 		=>		p_DATA_WIDTH
	)
	port map(
		i_CLK					=>		i_CLK,
		i_CLR					=>		i_RST,
		i_D					=>		i_D,
		i_LE					=>		i_LE,
		o_Q					=>		o_Q
	);
		
end Behavior;