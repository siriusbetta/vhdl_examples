library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blinker is
    generic (
         WIDTH : integer := 50000
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        q : out std_logic
    );
end blinker;

architecture Structural of blinker is
    constant freg_value : natural := 13500000;
    signal freg_cnt : natural range 0 to freg_value;
    signal toggle : std_logic := '0';

begin
    p1_Hz: process(clk) is
    begin
        if rising_edge(clk) then
            if freg_cnt = freg_value - 1 then
                toggle <= not toggle;
                freg_cnt <= 0;
            else
                freg_cnt <= freg_cnt + 1;
            end if;
        end if;
    end process;
        
    q <= toggle;

end Structural;