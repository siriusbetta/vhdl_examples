library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    generic (
         WIDTH : integer := 4
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        q : out std_logic_vector(WIDTH - 1 downto 0)
    );
end counter;

architecture Structural of counter is
    signal cnt : unsigned(WIDTH - 1 downto 0) := (others => '0');
begin   
    P_CNT: process(clk, reset)
    begin
        if reset = '1' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;

    q <= std_logic_vector(cnt);

end Structural;
