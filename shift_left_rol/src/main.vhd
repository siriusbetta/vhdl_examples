library IEEE;
use IEEE.std_logic_1164.all;

entity top_module is
    port (
        clk     : in  std_logic;
        reset_n : in  std_logic;
        button : in std_logic;
        led_out : out std_logic_vector(5 downto 0)
    );
end entity top_module;

architecture structural of top_module is
-- variables

signal cnt_out : std_logic_vector(2 downto 0);
signal cnt : integer := 0;
signal clk_1hz : std_logic := '0';
signal led_pattern : std_logic_vector(5 downto 0);

-- components
component blinker is
    generic (
         WIDTH : integer := 13500000
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        q : out std_logic
    );
end component;

-- end components

begin
-- instances
BLINKER_1Hz_INST: blinker
    generic map (
            WIDTH => 13500000
                )
        port map (
             clk => clk,
             reset => reset_n,
             q => clk_1hz    
    );

-- end instances

-- processes
UPDATE_CNT : process(clk_1hz, reset_n)
begin
    if reset_n = '1' then
        cnt = 0;
    elsif 
end process;
RUNNUNG_LEDS : process(clk_1hz, reset_n)
begin
    if reset_n = '1' then
 --       led_pattern <= "111111";
    elsif rising_edge(clk_1hz) then
        case cnt_out is 
            when "000" => led_pattern <= "111110";
            when "001" => led_pattern <= "111101";
            when "010" => led_pattern <= "111011"; 
            when "011" => led_pattern <= "110111";
            when "100" => led_pattern <= "101111";
            when "101" => led_pattern <= "011111";
            when others => reset_n <= "1";  
    end case;
    end if;
end process;


-- end processes

-- Connect internal signals to output ports (or further processing)
   
    led_out <= led_pattern;
end architecture structural;