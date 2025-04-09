-- Kütüphaneler
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 4x1 MUX devresinin entity tanımı
entity mux4x1 is
    Port ( 
        clk   : in  std_logic;                          -- Saat sinyali girişi
        sel   : in  std_logic_vector(1 downto 0);         -- 2-bit seçim ucu
        data0 : in  std_logic;                          -- 1. giriş
        data1 : in  std_logic;                          -- 2. giriş
        data2 : in  std_logic;                          -- 3. giriş
        data3 : in  std_logic;                          -- 4. giriş
        y     : out std_logic                           -- Çıkış
    );
end mux4x1;

-- Devre davranışının tanımlandığı mimari
architecture Behavioral of mux4x1 is
begin
    -- Saat sinyali her yükselen kenarında işlemin gerçekleştiği process bloğu
    process(clk)
    begin
        if rising_edge(clk) then
            -- Seçim ucunun durumuna göre ilgili giriş çıkışa aktarılıyor
            case sel is
                when "00" => 
                    y <= data0;  -- Seçim 00 ise data0 aktarılır
                when "01" => 
                    y <= data1;  -- Seçim 01 ise data1 aktarılır
                when "10" => 
                    y <= data2;  -- Seçim 10 ise data2 aktarılır
                when "11" => 
                    y <= data3;  -- Seçim 11 ise data3 aktarılır
                when others => 
                    y <= '0';    -- Tanımsız durumda çıkış 0 yapılır
            end case;
        end if;
    end process;
end Behavioral;
