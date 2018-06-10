--
--	Title: 	Counter 4 Bit
--	Author:	Jonathan Nascimento
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

------------------------------ ENTITY -------------------------------

entity PREPARE is
	generic(
		p_DATA_WIDTH	: INTEGER := 16;
		p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000";
		p_SECOUND_WIDTH : INTEGER := 4
    );
	port(
		-- GENERAL
		i_CLK			:	in		STD_LOGIC;
		i_RST			:	in		STD_LOGIC;
		i_ADDR		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
		i_DATA		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		o_DATA		:	out		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
	);
end PREPARE;

architecture Behavior of PREPARE is

------------------------------ COMPONENTS -------------------------------

	-- COUNTER
	component COUNTER is
		generic (
			p_DATA_WIDTH	: 	INTEGER := 16;
			p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000";
			p_SECOUND_WIDTH : INTEGER := 4
		 );
		port(
			i_CLK		:	in		STD_LOGIC;
			i_RST		:	in		STD_LOGIC;
			i_START	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_TIME	:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		
			o_DONE	:	out	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;

	-- CHOICES
	component CHOICES is
		generic (
			p_DATA_WIDTH	: 	INTEGER := 16
		);
		port(
			i_D   	: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_LE  	: 	in 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_CLR 	: 	in 	STD_LOGIC;
			i_CLK 	: 	in 	STD_LOGIC;
			o_Q   	: 	out 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	-- MUX2x1
	component MUX2x1 is
		generic(
			p_DATA_WIDTH	: 	INTEGER := 16
		);
		port (
			i_SEL 	: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-8) downto 0);
			i_X0 		: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			i_X1 		: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y 		: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	-- DEMUX1x4
	component DEMUX1x4 is
		generic(
			p_DATA_WIDTH	: INTEGER := 16
		);
		port (
			i_SEL : in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-8) downto 0);
			i_X 	: in  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y0 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y1 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y2 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_Y3 	: out  	STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
------------------------------ SIGNALS -------------------------------
	
	-- COUNTER		
	signal w_i_START	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_i_TIME	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		
	signal w_o_DONE	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	-- CHOICES
	signal w_i_D   	: 	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_i_LE  	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_o_Q   	:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	
	begin
	
------------------------------ INSTANCES -------------------------------

	-- COUNTER
	U_COUNTER : COUNTER
	generic map(
		p_DATA_WIDTH 		=>		p_DATA_WIDTH,
		p_SECOUND 			=>		p_SECOUND,
		p_SECOUND_WIDTH 	=>		p_SECOUND_WIDTH
	)
	port map(
		i_CLK					=>		i_CLK,
		i_RST					=>		i_RST,
		i_START				=>		w_i_START,
		i_TIME				=>		w_i_TIME,
		o_DONE				=>		w_o_DONE
	);
	
	-- CHOICES
	U_CHOICES : CHOICES
	generic map(
		p_DATA_WIDTH 		=>		p_DATA_WIDTH
	)
	port map(
		i_CLK					=>		i_CLK,
		i_CLR					=>		i_RST,
		i_D					=>		w_i_D,
		i_LE					=>		w_i_LE,
		o_Q					=>		w_o_Q
	);

	-- MUX2x1
	U_MUX2x1 : MUX2x1
	generic map(
		p_DATA_WIDTH 		=>		p_DATA_WIDTH
	)
	port map(
		i_SEL					=>		i_ADDR,
		i_X0					=>		w_o_DONE,
		i_X1					=>		w_o_Q,
		o_Y					=>		o_DATA
	);
	
	-- DEMUX1x4
	U_DEMUX1x4 : DEMUX1x4
		generic map(
			p_DATA_WIDTH 	=>		p_DATA_WIDTH
		)
		port map(
			i_SEL				=>		i_ADDR,
			i_X				=>		i_DATA,
			o_Y0				=>		w_i_START,	-- i_START
			o_Y1				=>		w_i_TIME,	--	i_TIME
			o_Y2				=>		w_i_D,		--	i_D
			o_Y3				=>		w_i_LE		--	i_LE
		);
		
end Behavior;