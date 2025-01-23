library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;


entity tb_range_sensor is
end tb_range_sensor;

architecture Behavioral of tb_range_sensor is




component range_sensor is
    Port (
	clk 		: in STD_LOGIC; 
    trigger 	: in STD_LOGIC; 
    distance 	: out STD_LOGIC_VECTOR(7 downto 0) 
	);
end component range_sensor;


    constant clk_period : time := 1 ms; 
    signal clk			: STD_LOGIC := '0';
    signal trigger 		: STD_LOGIC;
    signal distance		: STD_LOGIC_VECTOR(7 downto 0);

begin

    
    UUT : range_sensor
        port map (
            clk => clk,
            trigger => trigger,
            distance => distance
        );

    -- Saat işlemi
    clk_process : process
    begin
        while now < 1000 ms loop
            clk <= not clk; -- Saati değiştir
            wait for clk_period / 2; -- Saat periyodunun yarısı kadar bekle
        end loop;
        wait;
    end process clk_process;

  
    stimulus : process
    begin
	
        wait for 10 ms; 
		
		trigger <= '1';
		wait for 100 ms;
		
		trigger <= '0';
		wait for 10 ms;
		
		trigger <= '1';
		wait for 185 ms;
		
		trigger <= '0';	
		wait for 10 ms;
		
		trigger <= '1';
		wait for 1 ms;
		
		
        wait;
		
		assert false
		report "SIM DONE"
		severity failure;
    end process stimulus;

end Behavioral;
