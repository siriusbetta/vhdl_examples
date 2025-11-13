library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_module is
    port (
        clk     : in  std_logic;
        reset_n : in  std_logic;
        button : in std_logic;
        led_out : out std_logic_vector(5 downto 0)
    );
end entity top_module;

architecture structural of top_module is
-- functions
    
-- variables

signal clk_1hz : std_logic := '0';
signal led_pattern : std_logic_vector(5 downto 0);
signal state : std_logic := '1';
signal mov : std_logic := '1';
signal button_deb : std_logic := '0';
signal button_prev : std_logic := '0';

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

component debouncer is
port (
        clk     : in  std_logic;
        reset_n : in  std_logic;
        button  : in std_logic;
        debounced_out : out std_logic
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

DEBOUNCER_INST : debouncer
    port map (
        clk     => clk,
        reset_n => reset_n,
        button  => button,
        debounced_out => button_deb
    );

-- end instances

-- processes

CONTROL_BUTTON : process(clk, reset_n)
begin
    if reset_n = '1' then
        mov <= '0';
        button_prev <= '0';
    elsif rising_edge(clk) then
        button_prev <= button_deb;
        if button_prev = '0' and button_deb = '1' then
            mov <= not mov;
            if mov = '1' then 
                state <= not state;
            end if;
        end if;
    end if;
end process;

RUNNUNG_LEDS : process(clk_1hz, reset_n)
begin
    if reset_n = '1' then 
        led_pattern <= "011111";
    elsif rising_edge(clk_1hz) then
        if mov = '1' then
            if state = '1' then
                led_pattern <= led_pattern(0) & led_pattern(led_pattern'length-1 downto 1); -- циклический сдвиг вправо на 1
            else
                led_pattern <= led_pattern(led_pattern'length-2 downto 0) & led_pattern(led_pattern'length-1); -- циклический сдвиг влево на 1
            end if;
        end if;
    end if;
    
end process;


-- end processes

-- Connect internal signals to output ports (or further processing)
   
    led_out <= led_pattern;
end architecture structural;