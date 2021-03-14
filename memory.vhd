

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity memory is
     Port (index : in STD_LOGIC_VECTOR (3 downto 0);
           A: out STD_LOGIC_Vector (3 downto 0));
end memory;

architecture Behavioral of memory is

type memType is array(0 to 15) of std_logic_Vector(3 downto 0);
--creating the data pairs in the memory array
signal mem: memType := ("0001", "0000", "0001", "0011", "0101", "0011", "1000", "1001",
                           "0011", "0111", "0100", "1001", "1010", "0010", "0110", "0101");

begin
   

    process(index)
    begin
        --wait until clock = '1';
        A <= mem(conv_integer(index));

        
    end process;
    



end Behavioral;
