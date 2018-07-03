--
--	Title: 	Counter
--	Author:	Jonathan Nascimento
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COUNTER is
	generic (
				p_DATA_WIDTH	: INTEGER := 16;
				p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000";
				p_SECOUND_WIDTH : INTEGER := 4
    );
	port(
		i_CLK			:	in		STD_LOGIC;
		i_RST			:	in		STD_LOGIC;
		i_START		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		i_TIME		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
		o_DONE		:	out	STD_LOGIC
	);
end COUNTER;

architecture Behavior of COUNTER is

	-- STATE MACHINE
	type ST is (st_IDLE, st_COUNT, st_TIMER);
	attribute syn_encoding	:	string;
	attribute syn_encoding	of	ST	:	type is "safe";
	
	-- SIGNALS	
	signal w_STATE		: 	ST;
	signal w_START		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_TIME		:	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
	signal w_COUNT		:	STD_LOGIC_VECTOR(25 downto 0);						--	count 0 to 10111110101111000010000000 (1 secound in 50 MHz)
	signal w_SECOUND	:	STD_LOGIC_VECTOR((p_SECOUND_WIDTH-1) downto 0);	-- 0 to 1111 (0 to 15 secounds)
	signal w_DONE		:	STD_LOGIC;
	
	begin
	
		COUNTING : process(i_CLK, i_RST)
		
		begin
		
			-- RESET ASYNC
			if(i_RST = '1') then			  
				w_COUNT		<= (OTHERS => '0');						--	Reser signal count
				w_SECOUND	<= (OTHERS => '0');						-- Reset signal secound
				o_DONE		<=	'0'; 										-- 0 in output
				w_DONE		<= '0';
				w_STATE		<= st_IDLE; 								-- Initial state
				
			-- CLOCK IN HIGH
			elsif(rising_edge(i_CLK)) then
			
				case w_STATE is
				
					--	BEGIN IDLE
					when st_IDLE =>
						if(i_START = "0000000000000001") then							
								w_COUNT  	<=	(OTHERS => '0');
								w_SECOUND 	<= (OTHERS => '0');
								w_STATE 		<= st_COUNT;
						elsif(i_START = "0000000000000000")	then
							w_DONE <= '0';
							o_DONE <= '0';
						else
							w_STATE	<= st_IDLE;
						end if;
					--	END IDLE
					
					--	BEGIN COUNT
					when st_COUNT =>
						if(w_COUNT = p_SECOUND) then
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
						if(w_SECOUND = i_TIME) then
							w_DONE <= '1';
							o_DONE 	<= '1';								-- Notify done
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
	
end Behavior;