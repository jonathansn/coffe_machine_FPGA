library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CAMINHO_CONTROLE is
	 Generic(
	 		p_DATA_WIDTH   : INTEGER := 16;        -- Número de bits dos dados. 
	 		p_ADD_WIDTH    : INTEGER := 9         -- Número de bits dos endereços. 
	 );
    Port ( 
				i_CLK		: in  STD_LOGIC;
				i_RST		: in  STD_LOGIC;
				
				i_DATA_ROM	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);	  
				i_DATA_ULA	: in  STD_LOGIC;
				o_SEL_ULA	: out STD_LOGIC_VECTOR(2 DOWNTO 0);	
				o_SEL_IMED	: out STD_LOGIC_VECTOR(1 DOWNTO 0);	
				o_WR_BCO   	: out STD_LOGIC;
				o_WR_RAM   	: out STD_LOGIC;
				o_WR_IO    	: out STD_LOGIC;
				o_RD_IO		: out STD_LOGIC;
				o_EN_ROM	: out STD_LOGIC;
				o_ADD_ROM	: out STD_LOGIC_VECTOR(10 DOWNTO 0);
				o_DATA		: out STD_LOGIC_VECTOR(10 DOWNTO 0);
				o_EN_CLK	: out STD_LOGIC;
				
				o_RET		: out STD_LOGIC;
				o_DOUT_LIFO : out STD_LOGIC_VECTOR(63 DOWNTO 0);
				i_DIN_LIFO  : in  STD_LOGIC_VECTOR(63 DOWNTO 0);
				
				i_INT		: in  STD_LOGIC_VECTOR(5 DOWNTO 0);
				o_BUSY      : out STD_LOGIC				
	 );
end CAMINHO_CONTROLE;

architecture Behavioral of CAMINHO_CONTROLE is
-----------------------------------------------------------------

	COMPONENT CONTROLE is
	    Generic (
					p_DATA_WIDTH	: INTEGER := 16
	    );	
	    Port ( 
					i_CLK		: in  STD_LOGIC;
					i_RST		: in  STD_LOGIC;
					i_DATA   	: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);	  
					i_DATA_ULA	: in  STD_LOGIC;
					o_SEL_ULA	: out STD_LOGIC_VECTOR(2 DOWNTO 0);	
					o_SEL_IMED	: out STD_LOGIC_VECTOR(1 DOWNTO 0);	
					o_WR_BCO   	: out STD_LOGIC;
					o_WR_RAM   	: out STD_LOGIC;
					o_WR_IO    	: out STD_LOGIC;
					o_RD_IO		: out STD_LOGIC;
				    o_PUSH  	: out STD_LOGIC;
				    o_POP   	: out STD_LOGIC;
					o_RET		: out STD_LOGIC;
					o_EN_ROM	: out STD_LOGIC;
					o_ADD_ROM	: out STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);
					i_NEXT_PC   : in  STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);
					o_INT_ADD	: out STD_LOGIC_VECTOR(1 DOWNTO 0);
					i_INT		: in  STD_LOGIC_VECTOR(5 DOWNTO 0);
					o_REG_INT	: out STD_LOGIC_VECTOR(5 DOWNTO 0)					
		 );
	end COMPONENT;


	COMPONENT REGISTRADOR is
		 Generic (
					p_DATA_WIDTH		: INTEGER := 16
		 );
		 Port ( 
					i_CLK   	: in  STD_LOGIC;
					i_RST   	: in  STD_LOGIC;
					i_DATA		: in  STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);	  
					o_DATA		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);	
					i_WR   		: in  STD_LOGIC	
		 );
	end COMPONENT;	

	COMPONENT LIFO is
		 Generic(
				p_DATA_WIDTH   : INTEGER := 16;        -- Número de bits dos dados. 
				p_ADD_WIDTH    : INTEGER := 9         -- Número de bits dos endereços. 
		 );
		Port ( 
			  i_CLK 	: in  STD_LOGIC;
			  i_RST   	: in  STD_LOGIC;
			  i_RD 		: in  STD_LOGIC;
			  i_WR 		: in  STD_LOGIC;
			  i_DATA  	: in  STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			  o_DATA  	: out STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0)
		 );
	end COMPONENT;

	
	COMPONENT INTERRUPCAO is
		Port ( 
				i_CLK   	: in  STD_LOGIC;
				i_RST   	: in  STD_LOGIC;
				i_INT_ADD	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
				i_REG_INT   : in  STD_LOGIC_VECTOR(5 DOWNTO 0);
				i_INT		: in  STD_LOGIC_VECTOR(5 DOWNTO 0);
				o_BUSY      : out STD_LOGIC;
				o_INT		: out STD_LOGIC_VECTOR(5 DOWNTO 0)

		 );
	end COMPONENT;
	
	
	signal w_SEL_JMP  	: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal w_DATA   	: STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);	
	signal w_DIN_SP  	: STD_LOGIC_VECTOR(72 DOWNTO 0);				-- Stack Pointer (in).
	signal w_DOUT_SP 	: STD_LOGIC_VECTOR(72 DOWNTO 0);				-- Stack Pointer (out).
	signal w_PUSH   	: STD_LOGIC;
	signal w_POP    	: STD_LOGIC;
	signal w_ADD_ROM	: STD_LOGIC_VECTOR((p_DATA_WIDTH-8) DOWNTO 0);
	signal w_INT_ADD	: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal w_INT0		: STD_LOGIC;
	signal w_INT1		: STD_LOGIC;
	signal w_INT		: STD_LOGIC_VECTOR(5 DOWNTO 0);
	signal w_REG_INT	: STD_LOGIC_VECTOR(5 DOWNTO 0);

	
	
-----------------------------------------------------------------	
begin

	w_DATA <= i_DATA_ROM;
	o_DATA <= w_DATA(10 DOWNTO 0);
	
	
	--==============================================================
	-- LÓGICA DE CONTROLE 
	--==============================================================	
	U_DEC : CONTROLE 
	    Generic Map (
					p_DATA_WIDTH	=> p_DATA_WIDTH
	    )	
	    Port Map ( 
					i_CLK   		=> i_CLK,
					i_RST   		=> i_RST,
					i_DATA   		=> w_DATA,
					i_DATA_ULA		=> i_DATA_ULA,
					o_SEL_ULA		=> o_SEL_ULA,
					o_SEL_IMED		=> o_SEL_IMED,
					o_WR_BCO      	=> o_WR_BCO,
					o_WR_RAM      	=> o_WR_RAM,
					o_WR_IO       	=> o_WR_IO,
					o_RD_IO			=> o_RD_IO,
					o_PUSH  		=> w_PUSH,
					o_POP   		=> w_POP,
					o_RET			=> o_RET,
					o_EN_ROM		=> o_EN_ROM,
					o_ADD_ROM		=> w_ADD_ROM,
					i_NEXT_PC		=> w_DOUT_SP((p_DATA_WIDTH-8) downto 0),
					o_INT_ADD	    => w_INT_ADD,
					i_INT			=> w_INT,
					o_REG_INT		=> w_REG_INT
		);
	
		o_ADD_ROM <= w_INT_ADD & w_ADD_ROM;
		
		
		--
		-- TRATAMENTO DE INTERRUPCOES.
		--
		U_INT : INTERRUPCAO 
		Port Map ( 
					i_CLK   	=> i_CLK,
					i_RST   	=> i_RST,
					i_INT_ADD	=> w_INT_ADD,
					i_REG_INT   => w_REG_INT,
					i_INT		=> i_INT,
					o_BUSY      => o_BUSY,
					o_INT		=> w_INT
		 );
		
		--
		-- SALVAR E RESTAURAR REGISTRADORES.
		--
		w_DIN_SP  <= w_ADD_ROM & i_DIN_LIFO;
		o_DOUT_LIFO <= w_DOUT_SP(63 DOWNTO 0);
		
	
		U_LIFO : LIFO 
		 Generic Map (
						p_DATA_WIDTH   => 73,
						p_ADD_WIDTH    => p_ADD_WIDTH
		 )
		 Port Map ( 
					  i_CLK 	=> i_CLK,
					  i_RST   	=> i_RST,
					  i_RD 		=> w_POP,
					  i_WR 		=> w_PUSH,
					  i_DATA  	=> w_DIN_SP,
					  o_DATA  	=> w_DOUT_SP
		 );
		 
-----------------------------------------------------------------	
end behavioral;