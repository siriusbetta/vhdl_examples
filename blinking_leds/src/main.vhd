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

signal blinker_out : std_logic := '0';

-- components
component debouncer is 
     port (
            clk     : in  std_logic;
            reset_n : in  std_logic;
            button : in std_logic;
            debounced_out : out std_logic
        );
end component;

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
DEBOUNCE_INST : debouncer 
    port map (
        clk     => clk,
        reset_n => reset_n,
        button => button,
        debounced_out => button_clean
    );

BLINKER_1Hz_INST: blinker
    generic map (
            WIDTH => 13500000
                )
        port map (
             clk => clk,
             reset => reset_n,
             q => blinker_out    
    );
-- end instances

-- processes


-- end processes

    -- Connect internal signals to output ports (or further processing)
    led_out <= "11111" & blinker_out;
end architecture structural;