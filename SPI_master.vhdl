library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.STD_LOGIC_unsigned.all;


entity spi_master is
 generic(
	c_clkfreq	 	: integer 	:= 100_000_000;
	c_sclkfreq 		: integer 	:= 1_000_000;
	c_cpol			: std_logic := '0';
	c_cpha			: std_logic := '0'
 );
 Port ( 
	clk_i		 : in  std_logic;
	en_i		 : in  std_logic;
	mosi_data_i  : in  std_logic_vector (7 downto 0);-- slave giren sinyal --write
	miso_data_o	 : out std_logic_vector (7 downto 0);--	slaveden çıkan sinyal --read
	data_ready_o : out std_logic;
	
	cs_o		 : out std_logic; --slave seçiyoruz

	miso_i		 : in  std_logic; -- slaveden gelen veri
	mosi_o 		 : out std_logic; -- slaveye giden veri 
	sclk_o		 : out std_logic
	);
end spi_master;

architecture Behavioral of spi_master is

begin
-----------------
constant c_edgecntrlimdiv2 	: integer	:=c_clkfreq/(c_sclkfreq*2);
--bir daha ikiye bölmesinin manası, falling ve rising edge ayırması
-----------------

--internal signals
signal write_reg	: std_logic_vector (7 downto 0) 	:= (others => '0');	
signal read_reg		: std_logic_vector (7 downto 0) 	:= (others => '0');	

signal sclk_en		: std_logic := '0';
signal sclk			: std_logic := '0';
signal sclk_prev	: std_logic := '0';
signal sclk_rise	: std_logic := '0';
signal sclk_fall	: std_logic := '0';
 
signal pol_phase	: std_logic_vector (1 downto 0) := (others => '0');
signal mosi_en		: std_logic := '0';
signal miso_en		: std_logic := '0';
signal once         : std_logic := '0';
 
signal edgecntr		: integer range 0 to c_edgecntrlimdiv2 := 0;

signal cntr 		: integer range 0 to 15 := 0;


--STATE DEFINITIONS
type states is (s_ıdle , s_transfer);
signal state : states := s_ıdle;
-----------------------------------------

begin
pol_phase <= c_cpol & c_cpha;

p_sample_en : process (pol_phase , sclk_fall , sclk_rise)
begin
	case pol_phase is
	
		when "00" =>
			mosi_en <= sclk_fall; --datayı vermeliyim 
			miso_en	<= sclk_rise; --örneklemeliyim
 
		when "01" =>
			mosi_en <= sclk_rise;
			miso_en	<= sclk_fall;		
 
		when "10" =>
			mosi_en <= sclk_rise;
			miso_en	<= sclk_fall;	
			
		when "11" =>
			mosi_en <= sclk_fall;
			miso_en	<= sclk_rise;	
	
		when others =>
		
	end case;

end process p_sample_en;
-------------------------------------------------------
	

end Behavioral;
