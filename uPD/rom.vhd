-- -----------------------------------------------------
-- Arquivo ROM.vhd 
-- -----------------------------------------------------
                                                        
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
   
   
   
entity ROM is 
  Generic ( 
      p_ADD_WIDTH    : INTEGER := 9; 
      p_DATA_WIDTH   : INTEGER := 16 
  ); 
  Port ( 
      i_CLK	   : in STD_LOGIC; 
      i_RST	   : in STD_LOGIC; 
      i_EN_CLK	   : in STD_LOGIC; 
      i_EN 	   : in STD_LOGIC; 
      i_ADDRESS      : in STD_LOGIC_VECTOR ((p_ADD_WIDTH-1) downto 0); 
      o_DOUT         : out STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0) 
  ); 
end ROM; 
   
   
architecture Behavioral of ROM is 
      type ROM_TYPE is array(0 TO ((2**p_ADD_WIDTH)-1)) of std_logic_vector(o_DOUT'range); 
      signal ROM : ROM_TYPE := ((others=> (others=>'0'))); 
      signal w_ADDRESS	: STD_LOGIC_VECTOR(i_ADDRESS'range); 
   
  
begin 
   
   
-- -----------------------------------------------------
-- Codigo de maquina: 
-- -----------------------------------------------------
                                                        
-- # Endereço 2 CHOICE
-- .PROG
    ROM(0) <= "1000100000111111";    -- SETR RINT 63
    ROM(1) <= "0000100000000001";    -- LDI R0 1
    ROM(2) <= "0010000000010100";    -- OUT R0 20
    ROM(3) <= "0011000000000001";    -- JI MAIN:
   
   
  w_ADDRESS <= (others=>'0') when(i_RST = '1') else i_ADDRESS; 
	U_ROM : process(i_CLK) 
	begin 
      if rising_edge (i_CLK) then 
          if (i_RST = '1') then 
              o_DOUT <= (others=>'0'); 
          else 
              if (i_EN = '1') then 
			o_DOUT <= ROM(conv_integer(w_ADDRESS)); 
              end if; 
          end if; 
      end if; 
	end process U_ROM; 
   
end Behavioral;            
