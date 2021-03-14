----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/14/2020 06:08:31 PM
-- Design Name: 
-- Module Name: sysClock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sysClock is
    Port ( clock : in STD_LOGIC;
           pulse : out STD_LOGIC);
end sysClock;

architecture Behavioral of sysClock is

    signal CLK_CNT : unsigned(31 downto 0);

begin

    PULSE_PROC : process(clock)
    begin
      if rising_edge(clock) then
        if clk_cnt >= 8000 then
          clk_cnt <= (others => '0');
           
        else
          clk_cnt <= clk_cnt + 1;
           
        end if;
      end if;
    end process;

end Behavioral;
