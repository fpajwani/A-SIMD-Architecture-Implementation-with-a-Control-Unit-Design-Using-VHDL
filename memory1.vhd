

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity memory1 is
     Port (index : in STD_LOGIC_VECTOR (3 downto 0);
           B : out STD_LOGIC_Vector (3 downto 0));
end memory1;

architecture Behavioral of memory1 is

type memType is array(0 to 15) of std_logic_Vector(3 downto 0);
--creating the data pairs in the memory array
signal mem: memType := ("0000", "0001", "0001", "0001", "0010", "0111", "0111", "0011",
                           "0011", "0001", "0111", "0001", "0011", "1101", "0110", "0101");

begin
   

    process(index)
    begin
        
        B <= mem(conv_integer(index));
        
    end process;
    



end Behavioral;
