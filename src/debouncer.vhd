library IEEE;
use IEEE.std_logic_1164.all;

entity debouncer is
    port (
        clk     : in  std_logic;
        reset_n : in  std_logic;
        button : in std_logic;
        debounced_out : out std_logic
    );
end entity debouncer;

architecture structural of debouncer is

signal button_sync : std_logic :='0';
signal button_debounced : std_logic := '0';
signal button_prev : std_logic := '0';
signal counter : integer range 0 to 50000 := 0;

begin
-- processes
    process(clk)
    begin
        if reset_n = '1' then  -- ← ДОБАВИТЬ условие сброса
            button_sync      <= '0';
            button_debounced <= '0';
            button_prev      <= '0';
            counter          <= 0;
        elsif rising_edge(clk) then
            button_sync <= button;
            button_prev <= button_debounced;

            if button_sync = '1' then
                if counter  < 50000  then
                    counter <= counter + 1;
                end if;    
            else
                counter <= 0;  
            end if;

            if counter = 50000 then
                button_debounced <= '1';
            else
                button_debounced <= '0';
            end if;
           
        end if;
    end process;

    debounced_out <= button_debounced;

end architecture structural;