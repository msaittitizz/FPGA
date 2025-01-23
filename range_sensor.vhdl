library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
entity range_sensor is
    Port (
	clk 		: in STD_LOGIC; 
    trigger 	: in STD_LOGIC; 
    distance 	: out STD_LOGIC_VECTOR(7 downto 0) 
	);
end range_sensor;

0
architecture Behavioral of range_sensor is
    signal pulse_width 		: integer 	:= 	0	; 
    signal pulse_started 	: STD_LOGIC := '0'	; 
    signal pulse_ended 		: STD_LOGIC := '0'	; 
    signal counter 			: INTEGER 	:= 	0	; 
	signal reg_distance		: STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin

    process(clk)
    begin
        if rising_edge(clk) then

				
				if pulse_started = '1' then
					pulse_width <= pulse_width + 1;
				end if;
	
				
				if pulse_ended = '1' then
					
					reg_distance <= std_logic_vector(to_unsigned(pulse_width, reg_distance'length)); 
					pulse_width <= 0; 
				end if;
        end if;
    end process;
	distance <= reg_distance;
    
	process(clk)
    begin
        if rising_edge(clk) then
          
            if trigger = '1' then
                pulse_started <= '1';
			else
				pulse_ended <= '0';
            end if;

      
            if pulse_started = '1'and trigger = '0' then
                pulse_started <= '0';
                pulse_ended <= '1'; 
	
            end if;
        end if;
    end process;
	
	

end Behavioral;
