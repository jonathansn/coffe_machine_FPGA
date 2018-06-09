--
--	Title: 	Counter 4 Bit
--	Author:	Jonathan Nascimento
--
-- i_ADDR = "00011001" or 25 => i_TIME
-- i_ADDR = "00011010" or 26 => i_START

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COUNTER is
	generic (
				p_DATA_WIDTH	: INTEGER := 16;
				p_SECOUND_WIDTH : INTEGER := 4
    );
	port(
		i_CLK			:	in		STD_LOGIC;
		i_RST			:	in		STD_LOGIC;
		i_START		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_TIME		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_ADDR		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		
		o_DONE		:	out	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
	);
end COUNTER;

architecture Behavior of COUNTER is

	component FF_SR is
		Port (
			o_Q 	: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);		-- Data output
			i_CLK : in 	STD_LOGIC;      											-- Clock input
			i_CE 	: in	STD_LOGIC;   												-- Clock enable input
			i_CLR : in 	STD_LOGIC;  												-- Asyn clear input
			i_D 	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);    -- Data input
			i_PRE : in 	STD_LOGIC   	 											-- Asyn set input
		);
	end component;

	-- STATE MACHINE
	type ST is (st_IDLE, st_COUNT, st_TIMER);
	attribute syn_encoding	:	string;
	attribute syn_encoding	of	ST	:	type is "safe";
	
	-- SIGNALS
	signal w_CLR		:	STD_LOGIC;	-- Clear Flip Flop
	signal w_Q			:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);	-- Data output Flip Flop
	signal w_CE			:	STD_LOGIC;	-- Enable Flip Flop
	signal w_PRE		:	STD_LOGIC;	--	Preset Flip Flop
	
	signal w_STATE		: 	ST;
	signal w_TIME		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);			--	Time input data
	signal w_COUNT		:	STD_LOGIC_VECTOR(25 downto 0);							--	count 0 to 10111110101111000010000000 (1 secound in 50 MHz)
	signal w_SECOUND	:	STD_LOGIC_VECTOR((p_SECOUND_WIDTH-1) downto 0);		-- 0 to 1111 (0 to 15 secounds)
	
	begin
	
		TIMER : process(i_CLK)
		
		begin
		
		if(rising_edge(i_CLK)) then
		
			if(i_ADDR = "0000000000011001") then
				w_TIME <= i_TIME;
			end if;
			
		end if;
		
		end process TIMER;
	
	
		COUNTING : process(i_CLK, i_RST)
		
		begin
		
			-- RESET ASYNC
			if(i_RST = '1') then			  
				w_COUNT		<= (OTHERS => '0');						--	Reser signal count
				w_SECOUND	<= (OTHERS => '0');						-- Reset signal secound
				o_DONE		<=	"0000000000000000"; 					-- 0 in output
				w_CLR			<=	'1'; 										-- Reset FF
				w_STATE		<= st_IDLE; 								-- Initial state
				
			-- CLOCK IN HIGH
			elsif(rising_edge(i_CLK)) then
			
				case w_STATE is
				
					--	BEGIN IDLE
					when st_IDLE =>
					
					  if(i_ADDR = "0000000000011010") then					
						  if(w_Q = "0000000000000001")	then
							 w_COUNT  	<=	(OTHERS => '0');
							 w_SECOUND 	<= (OTHERS => '0');
							 w_CE			<=	'0';					--	FF Clock Enanle
							 w_STATE 		<= st_COUNT;
							 end if;					
						else
							w_CLR		<=	'0';						-- FF input 0 to R
							w_CE		<=	'1';						-- FF Clock Enable
							w_STATE	<= st_IDLE;
						end if;
					--	END IDLE
					
					--	BEGIN COUNT
					when st_COUNT =>
						if(w_COUNT = "111") then
							w_SECOUND 	<= w_SECOUND + 1;
							w_COUNT 		<= (OTHERS => '0');
							w_STATE	<= st_TIMER;
						else
							w_COUNT <= w_COUNT + 1;
							w_STATE	<= st_COUNT;
						end if;				
					--	END COUNT
					
					--	BEGIN TIMER
					when st_TIMER =>
						if(w_SECOUND = w_TIME) then
							o_DONE 	<= "0000000000000001";						-- Notify done
							w_CLR 	<= '1';											--	Reset FF
							w_COUNT 		<= (OTHERS => '0');
							w_SECOUND 	<= (OTHERS => '0');
							w_STATE <= st_IDLE;
						else
							w_STATE <= st_COUNT;
						end if;
					--	END TIMER
		
				end case;
				
			end if;
			
		end process COUNTING;
		
		UU1 : FF_SR 
		Port map(
			o_Q 		=>	w_Q,
			i_CLK 	=>	i_CLK,
			i_CE 		=>	w_CE,
			i_CLR 	=>	w_CLR,
			i_D 		=>	i_START,
			i_PRE 	=>	w_PRE
		);
	
end Behavior;