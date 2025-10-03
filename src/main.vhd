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

signal led_blink : std_logic := '0';

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

begin
-- processes
   
BLINKER_INST : blinker
        generic map(
                WIDTH => 13500000
            )
            port map (
                clk => clk,
                reset => reset_n,
                q => led_blink
            );
 
    -- Connect internal signals to output ports (or further processing)
    led_out(0) <= led_blink;

end architecture structural;