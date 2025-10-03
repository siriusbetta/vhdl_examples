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
signal debounced_out : std_logic;
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
        debounced_out => debounced_out
    );
        

    -- Connect internal signals to output ports (or further processing)
    led_out(0) <= debounced_out;

end architecture structural;