Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity uPD is
    Generic (
				p_ADD_WIDTH		: INTEGER := 11;
				p_DATA_WIDTH	: INTEGER := 16;
				p_SECOUND		: STD_LOGIC_VECTOR := "10111110101111000010000000"; -- add
				p_SECOUND_WIDTH : INTEGER := 4 -- add
    );
    Port ( 
				i_CLK		: in  STD_LOGIC;
				i_RST		: in  STD_LOGIC;
				
				--o_WR_IO    	: out STD_LOGIC;
				--o_RD_IO		: out STD_LOGIC;				
				--i_DATA_IO	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				--o_DATA_IO	: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				--o_ADDR_IO   : out STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);

				--i_INT		: in  STD_LOGIC_VECTOR(5 DOWNTO 0);
				o_BUSY      : out STD_LOGIC;
			-- BUTTONS and SWITCHES
			i_PREPARE 	: 	in  STD_LOGIC;
			i_LOAD		:	in	 STD_LOGIC;
			i_CHOICE		: 	in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
			-- DISPLAY OUTPUT
			o_DIS0		:	out		STD_LOGIC_VECTOR(6 downto 0);
			o_DIS1		:	out		STD_LOGIC_VECTOR(6 downto 0);
			o_DIS2		:	out		STD_LOGIC_VECTOR(6 downto 0);
			o_DIS3		:	out		STD_LOGIC_VECTOR(6 downto 0);
			o_LED			:	out 		STD_LOGIC_VECTOR(8 downto 0)
    );
end uPD;

architecture Behavioral of uPD is
-----------------------------------------------------------------

	COMPONENT PROCESSADOR is
	  Generic(
	 		p_DATA_WIDTH   : INTEGER := 16;        -- Número de bits dos dados. 
	 		p_ADD_WIDTH    : INTEGER := 9          -- Número de bits dos endereços. 
	  );
      Port ( 
				i_CLK		: in  STD_LOGIC;
				i_RST		: in  STD_LOGIC;
				
				o_EN_CLK	: out STD_LOGIC;
				o_EN_ROM	: out STD_LOGIC;
				i_DATA_ROM	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);	  
				o_ADD_ROM	: out STD_LOGIC_VECTOR(10 DOWNTO 0);
				
				o_WR_IO    	: out STD_LOGIC;
				o_RD_IO		: out STD_LOGIC;				
				i_DATA_IO	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				o_DATA_IO	: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				o_ADDR_IO   : out STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);

				i_INT		: in  STD_LOGIC_VECTOR(5 DOWNTO 0);
				o_BUSY      : out STD_LOGIC							
	 );
	end COMPONENT;
	
	
	COMPONENT ROM is
		Generic (
				--
				-- Size of the address bus.
				--
				p_ADD_WIDTH		: INTEGER := 11;
				p_DATA_WIDTH	: INTEGER := 16
	    );
		 Port ( 
				i_CLK	    : in STD_LOGIC;
				i_RST	    : in STD_LOGIC;
				i_EN_CLK	: in STD_LOGIC;
				i_EN 	    : in STD_LOGIC;
				i_ADDRESS   : in STD_LOGIC_VECTOR ((p_ADD_WIDTH-1) downto 0);
				o_DOUT      : out STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
		);
	end COMPONENT;

	
	component pll
	PORT
	(
		areset		: IN STD_LOGIC  := '0';
		inclk0		: IN STD_LOGIC  := '0';
		c0			: OUT STD_LOGIC ;
		locked		: OUT STD_LOGIC 
	);
	end component;
	
------------------------------ COMPONENT -------------------------------

	component PREPARE is
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
			o_DATA		:	out	STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_CHOICE		:	in		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
			i_PREPARE	:	in		STD_LOGIC;
			i_LOAD		:	in		STD_LOGIC;
			o_LOAD		:	out	STD_LOGIC;
			o_DONE		:	out	STD_LOGIC;
			o_PREPARE	:	out	STD_LOGIC;
			-- DISPLAY
			o_DIS0		:	out	STD_LOGIC_VECTOR(6 downto 0);
			o_DIS1		:	out	STD_LOGIC_VECTOR(6 downto 0);
			o_DIS2		:	out	STD_LOGIC_VECTOR(6 downto 0);
			o_DIS3		:	out	STD_LOGIC_VECTOR(6 downto 0);
			-- WR and RD Control
			i_WR			:	in		STD_LOGIC;
			i_RD			:	in		STD_LOGIC
		);
	end component;

---------------------------- END COMPONENT -----------------------------

	
	signal 		w_ADD_ROM			: STD_LOGIC_VECTOR((p_ADD_WIDTH-1) DOWNTO 0);
	signal		w_DATA_ROM			: STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
	signal 		w_RST				: STD_LOGIC;
	signal 		w_RST_PLL			: STD_LOGIC;
	signal 		w_LOCKED			: STD_LOGIC;
	signal 		w_CLK				: STD_LOGIC;
	signal 		w_EN_CLK			: STD_LOGIC;
	signal 		w_EN_ROM			: STD_LOGIC;
	signal      w_ADD_PROCESSOR		: STD_LOGIC_VECTOR((p_ADD_WIDTH-1) DOWNTO 0);

---------------------------- SIGNALS -----------------------------

	signal	w_i_DATA_IO		: 		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
	signal	w_o_DATA_IO		: 		STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
	signal	w_o_ADDR_IO   	: 		STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);
	signal	w_i_INT  	 	: 		STD_LOGIC_VECTOR(5 DOWNTO 0);
	signal	w_o_WR_IO		:		STD_LOGIC;
	signal	w_o_RD_IO		:		STD_LOGIC;

-------------------------- END SIGNALS ---------------------------
	
-----------------------------------------------------------------	
begin

	U_PLL : pll PORT MAP (
		areset	 => w_RST_PLL,
		inclk0	 => i_CLK,
		c0	 	 => w_CLK,
		locked	 => w_LOCKED
	);
	
	--
	-- Sinal de RESET externo é invertido para uso no kit DE0.
	--
	w_RST_PLL <= not i_RST;
--	w_RST_PLL <= i_RST;
	w_RST     <= w_RST_PLL OR (NOT w_LOCKED);
	
	w_ADD_ROM <= w_ADD_PROCESSOR;
	
	--
	-- Instancialização do processador.
	--
	U_PROC: PROCESSADOR 
	 Generic Map(
					p_DATA_WIDTH   	=> p_DATA_WIDTH,
					p_ADD_WIDTH     => p_ADD_WIDTH
	 )
      Port Map ( 
					i_CLK			=> w_CLK,
					i_RST			=> w_RST,
					
					o_EN_CLK		=> w_EN_CLK,
					o_EN_ROM		=> w_EN_ROM,
					i_DATA_ROM		=> w_DATA_ROM,
					o_ADD_ROM		=> w_ADD_PROCESSOR,
					
					o_WR_IO    		=> w_o_WR_IO,
					o_RD_IO			=> w_o_RD_IO,				
					i_DATA_IO		=> w_i_DATA_IO,
					o_DATA_IO		=> w_o_DATA_IO,
					o_ADDR_IO		=> w_o_ADDR_IO,
				
					i_INT			=> w_i_INT,
					o_BUSY      	=> o_BUSY
	 );
	 
	 w_i_INT(5 downto 3) <= (OTHERS => '0');

	 --
	 -- Instancialização da memória de programa.
	 --
	 U_MEM: ROM 
		Generic Map (
					p_ADD_WIDTH		=> p_ADD_WIDTH,
					p_DATA_WIDTH	=> p_DATA_WIDTH
	    )
		 Port Map ( 
					i_CLK			=> w_CLK,
					i_RST			=> w_RST,
					i_EN_CLK	   	=> w_EN_CLK,
					i_EN			=> w_EN_ROM,
					i_ADDRESS    	=> w_ADD_ROM,
					o_DOUT       	=> w_DATA_ROM
		);

------------------------------ INSTANCE -------------------------------

	o_LED(4 downto 0) 	<= w_i_DATA_IO(4 downto 0);
	o_LED(8 downto 5)		<=	w_I_INT(3 downto 0);

	U_PREPARE : PREPARE
		generic map(
			p_DATA_WIDTH		=> 	p_DATA_WIDTH,
			p_SECOUND 			=>		p_SECOUND,
			p_SECOUND_WIDTH 	=> 	p_SECOUND_WIDTH
		 )
		port map(
			-- GENERAL
			i_CLK       	=> 	w_CLK,
			i_RST       	=> 	w_RST,
			i_ADDR       	=> 	w_o_ADDR_IO,
			i_DATA       	=> 	w_o_DATA_IO,
			o_DATA       	=> 	w_i_DATA_IO,
			i_CHOICE			=> 	i_CHOICE,
			i_PREPARE		=> 	i_PREPARE,
			i_LOAD			=>		i_LOAD,
			o_PREPARE		=> 	w_i_INT(0),
			o_DONE			=> 	w_i_INT(1),
			o_LOAD			=>		w_i_INT(2),
			-- DISPLAY
			o_DIS0       	=> 	o_DIS0,
			o_DIS1       	=> 	o_DIS1,
			o_DIS2      	=> 	o_DIS2,
			o_DIS3       	=> 	o_DIS3,
			i_WR				=>		w_o_WR_IO,
			i_RD				=>		w_o_RD_IO
		);

---------------------------- END INSTANCE -----------------------------
		

end behavioral;