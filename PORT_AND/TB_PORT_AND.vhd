library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_PORT_AND is
	generic (
				p_DATA_WIDTH	: INTEGER := 16
    );
end TB_PORT_AND;

architecture Behavioral of TB_PORT_AND is

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
	
	signal	w_ADDR0	:	STD_LOGIC;
	signal	w_ADDR1	:	STD_LOGIC;
	signal	w_ADDR2	:	STD_LOGIC;
	signal	w_WR		:	STD_LOGIC;
	signal	w_o_WR	:	STD_LOGIC;

	begin
	
	U_PORT_AND : PORT_AND
		generic map(
					p_DATA_WIDTH	=> p_DATA_WIDTH
		 )
		port map(
			i_ADDR(0)		=> w_ADDR0,
			i_ADDR(1)		=> w_ADDR1,
			i_ADDR(2)		=> w_ADDR2,
			i_WR			=> w_WR,
			o_WR			=> w_o_WR
		);
	
	PROCESS
	BEGIN
		WAIT FOR 60 NS;
		w_WR	  <= '1';
		w_ADDR0 <= '0';
		w_ADDR1 <= '0';
		w_ADDR2 <= '0';
		WAIT FOR 40 NS;
		w_WR	  <= '1';
		w_ADDR0 <= '1';
		w_ADDR1 <= '1';
		w_ADDR2 <= '1';
		WAIT;
	END PROCESS;
			 
end Behavioral; 