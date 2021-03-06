--
--	Title: 	Component with 1 register per input and an address control
--	Author:	Jonathan Nascimento
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COUPLER4 is
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
end COUPLER4;

architecture Behavior of COUPLER4 is

	-- FF_SR
	component FF_SR is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(			
			i_CLK 	: in 	STD_LOGIC;
			i_CLR 	: in 	STD_LOGIC;
			i_D 		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_PRE 	: in 	STD_LOGIC;
			i_WR		: in  STD_LOGIC;
			i_ADDR	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			o_Q 		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
		);
	end component;
	
	-- PORT_AND
	component PORT_AND is
		generic (
					p_DATA_WIDTH	: INTEGER := 16
		 );
		port(
			i_ADDR		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) downto 0);
			i_WR			:	in		STD_LOGIC;
			o_WR			:	out	STD_LOGIC
		);
	end component;
	
	signal 	w_WR		:	STD_LOGIC;
	
	begin
	
	w_WR <= (not i_ADDR(0)) AND (not i_ADDR(1)) AND i_ADDR(2) AND i_WR;
		
	U_FF_SR : FF_SR
		generic map(
				p_DATA_WIDTH	=> p_DATA_WIDTH
		 )
		port map(
			i_CLK 	=> i_CLK,
			i_CLR 	=> i_RST,
			i_D 		=> i_D,
			i_PRE 	=> '0',
			i_WR		=> w_WR,
			i_ADDR	=> i_ADDR,
			o_Q 		=> o_Q
		);
	
end Behavior;