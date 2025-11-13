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
signal cnt : integer range 0 to 6 := 0;
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
        cnt <= 1;
    elsif rising_edge(clk_1hz) then
        if cnt = 6 then
            cnt <= 1;
        else
            cnt <= cnt + 1;
        end if;
    end if;
end process;
RUNNUNG_LEDS : process(clk_1hz, reset_n)
begin
    if reset_n = '1' then
        led_pattern <= "111111";
    elsif rising_edge(clk_1hz) then
        case cnt is 
            when 1 => led_pattern <= "111110";
            when 2 => led_pattern <= "111101";
            when 3 => led_pattern <= "111011"; 
            when 4 => led_pattern <= "110111";
            when 5 => led_pattern <= "101111";
            when 6 => led_pattern <= "011111";
            when others => led_pattern <= "111111";  
    end case;
    end if;
end process;


-- end processes

-- Connect internal signals to output ports (or further processing)
   
    led_out <= led_pattern;
end architecture structural;