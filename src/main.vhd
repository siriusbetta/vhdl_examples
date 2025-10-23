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
signal button_clean : std_logic;
signal button_prev : std_logic := '0';

signal led_state : std_logic := '0';

component debouncer is 
     port (
            clk     : in  std_logic;
            reset_n : in  std_logic;
            button : in std_logic;
            debounced_out : out std_logic
        );
end component;

begin
-- processes
   
DEBOUNCE_INST : debouncer 
    port map (
        clk     => clk,
        reset_n => reset_n,
        button => button,
        debounced_out => button_clean
    );
        

LED_TOGGLE : process(clk, reset_n)
begin
    if reset_n = '1' then
        button_prev <= '0';
        led_state <= '0';
    elsif rising_edge(clk) then
        button_prev <= button_clean;
        if button_prev = '0' and button_clean = '1' then
            led_state <= not led_state;
        end if;
    end if;
end process;


    -- Connect internal signals to output ports (or further processing)
    led_out(0) <= led_state;

end architecture structural;