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
                                                        
-- SETR RINT 7 # Habilita as interrupções
    ROM(0) <= "1000100000000111";    -- SETR RINT 7 # Habilita as interrupções
    ROM(1) <= "0000100001111111";    -- LDI R0 127 # zera display begin
    ROM(2) <= "0010000000000011";    -- OUT R0 3
    ROM(3) <= "0000100001111111";    -- LDI R0 127
    ROM(4) <= "0010000000000100";    -- OUT R0 4
    ROM(5) <= "0000100001111111";    -- LDI R0 127
    ROM(6) <= "0010000000000101";    -- OUT R0 5
    ROM(7) <= "0000100001111111";    -- LDI R0 127
    ROM(8) <= "0010000000000110";    -- OUT R0 6 # zera display end
    ROM(9) <= "0000100000000010";    -- LDI R0 2 # suprimento begin
    ROM(10) <= "0100000000000000";    -- STO R0 0
    ROM(11) <= "0000100000000010";    -- LDI R0 2
    ROM(12) <= "0100000000000001";    -- STO R0 1
    ROM(13) <= "0000100000000010";    -- LDI R0 2
    ROM(14) <= "0100000000000010";    -- STO R0 2
    ROM(15) <= "0000100000000010";    -- LDI R0 2
    ROM(16) <= "0100000000000011";    -- STO R0 3 # suprimento end
    ROM(17) <= "0000100000000001";    -- LDI R0 1 # choice begin
    ROM(18) <= "0100000000001010";    -- STO R0 10
    ROM(19) <= "0000100000001001";    -- LDI R0 9
    ROM(20) <= "0100000000001011";    -- STO R0 11
    ROM(21) <= "0000100000010001";    -- LDI R0 17
    ROM(22) <= "0100000000001100";    -- STO R0 12
    ROM(23) <= "0000100000011001";    -- LDI R0 25
    ROM(24) <= "0100000000001101";    -- STO R0 13
    ROM(25) <= "0000100000000010";    -- LDI R0 2
    ROM(26) <= "0100000000001110";    -- STO R0 14
    ROM(27) <= "0000100000001010";    -- LDI R0 10
    ROM(28) <= "0100000000001111";    -- STO R0 15
    ROM(29) <= "0000100000010010";    -- LDI R0 18
    ROM(30) <= "0100000000010000";    -- STO R0 16
    ROM(31) <= "0000100000011010";    -- LDI R0 26
    ROM(32) <= "0100000000010001";    -- STO R0 17
    ROM(33) <= "0000100000000100";    -- LDI R0 4
    ROM(34) <= "0100000000010010";    -- STO R0 18
    ROM(35) <= "0000100000001100";    -- LDI R0 12
    ROM(36) <= "0100000000010011";    -- STO R0 19
    ROM(37) <= "0000100000010100";    -- LDI R0 20
    ROM(38) <= "0100000000010100";    -- STO R0 20
    ROM(39) <= "0000100000011100";    -- LDI R0 28
    ROM(40) <= "0100000000010101";    -- STO R0 21 # choice end
    ROM(41) <= "0000100000000001";    -- LDI R0 1 # load enable begin
    ROM(42) <= "0010000000000010";    -- OUT R0 2 # load enable end
    ROM(43) <= "0000100000000000";    -- LDI R0 0 #O
    ROM(44) <= "0010000000000100";    -- OUT R0 4
    ROM(45) <= "0000100000010101";    -- LDI R0 21 #K
    ROM(46) <= "0010000000000011";    -- OUT R0 3
    ROM(47) <= "0000100001111111";    -- LDI R0 127
    ROM(48) <= "0010000000000101";    -- OUT R0 5
    ROM(49) <= "0000100001111111";    -- LDI R0 127
    ROM(50) <= "0010000000000110";    -- OUT R0 6
    ROM(51) <= "0011000000110100";    -- JI 52
    ROM(52) <= "0000000000000000";    -- NOP
    ROM(53) <= "0011000000110100";    -- JI 52
    ROM(54) <= "0000111000000000";    -- LDI R3 0 #D
    ROM(55) <= "0010011000000110";    -- OUT R3 6
    ROM(56) <= "0000111000000000";    -- LDI R3 0 #O
    ROM(57) <= "0010011000000101";    -- OUT R3 5
    ROM(58) <= "0000111000010001";    -- LDI R3 17 #N
    ROM(59) <= "0010011000000100";    -- OUT R3 4
    ROM(60) <= "0000111000001110";    -- LDI R3 14 #E
    ROM(61) <= "0010011000000011";    -- OUT R3 3
    ROM(62) <= "0011000000110100";    -- JI 52
-- .INT0
    ROM(512) <= "0000111000000010";    -- LDI R3 2
    ROM(513) <= "0010011000000001";    -- OUT R3 1
    ROM(514) <= "0000111000000001";    -- LDI R3 1
    ROM(515) <= "0010011000000000";    -- OUT R3 0
    ROM(516) <= "0000111000000000";    -- LDI R3 0 #F
    ROM(517) <= "0010011000000110";    -- OUT R3 6
    ROM(518) <= "0000111000000000";    -- LDI R3 0 #A
    ROM(519) <= "0010011000000101";    -- OUT R3 5
    ROM(520) <= "0000111000000000";    -- LDI R3 0 #I
    ROM(521) <= "0010011000000100";    -- OUT R3 4
    ROM(522) <= "0000111000000000";    -- LDI R3 0 #L
    ROM(523) <= "0010011000000011";    -- OUT R3 3
    ROM(524) <= "0010011000000011";    -- OUT R3 3
    ROM(525) <= "1000000000000000";    -- RETI
-- .INT1
    ROM(768) <= "0000111000000000";    -- LDI R3 0
    ROM(769) <= "0010011000000000";    -- OUT R3 0
    ROM(770) <= "0000111000000000";    -- LDI R3 0
    ROM(771) <= "0010011000000001";    -- OUT R3 1
    ROM(772) <= "0000111000000000";    -- LDI R3 0 #D
    ROM(773) <= "0010011000000110";    -- OUT R3 6
    ROM(774) <= "0000111000000000";    -- LDI R3 0 #O
    ROM(775) <= "0010011000000101";    -- OUT R3 5
    ROM(776) <= "0000111000010001";    -- LDI R3 17 #N
    ROM(777) <= "0010011000000100";    -- OUT R3 4
    ROM(778) <= "0000111000001110";    -- LDI R3 14 #E
    ROM(779) <= "0010011000000011";    -- OUT R3 3
    ROM(780) <= "0010011000000011";    -- OUT R3 3
    ROM(781) <= "1000000000000000";    -- RETI
-- .INT2
    ROM(1024) <= "0000111000010100";    -- LDI R3 20 # L
    ROM(1025) <= "0010011000000110";    -- OUT R3 6
    ROM(1026) <= "0000111000000000";    -- LDI R3 0 # O
    ROM(1027) <= "0010011000000101";    -- OUT R3 5
    ROM(1028) <= "0000111000001010";    -- LDI R3 10 # A
    ROM(1029) <= "0010011000000100";    -- OUT R3 4
    ROM(1030) <= "0000111000000000";    -- LDI R3 0 # D
    ROM(1031) <= "0010011000000011";    -- OUT R3 3
    ROM(1032) <= "0010011000000011";    -- OUT R3 3
    ROM(1033) <= "0000111000001010";    -- LDI R3 10
    ROM(1034) <= "0100011000000000";    -- STO R3 0
    ROM(1035) <= "0000111000001010";    -- LDI R3 10
    ROM(1036) <= "0100011000000001";    -- STO R3 1
    ROM(1037) <= "0000111000001010";    -- LDI R3 10
    ROM(1038) <= "0100011000000010";    -- STO R3 2
    ROM(1039) <= "0000111000001010";    -- LDI R3 10
    ROM(1040) <= "0100011000000011";    -- STO R3 3
    ROM(1041) <= "1000000000000000";    -- RETI
   
   
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
