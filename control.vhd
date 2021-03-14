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

entity control is
  Port ( SelIn : IN STD_LOGIC_VECTOR (2 downto 0);
         Ai, Bi : IN std_logic_vector (3 downto 0);
         clock : IN std_logic;
         btn : IN std_logic;
         Ao, Bo : OUT std_logic_vector (3 downto 0);
         selOut : OUT std_logic_vector (2 downto 0);
         stateDebug : out std_logic_vector (1 downto 0));
end control;

architecture Behavioral of control is
 
signal state : std_logic_Vector (1 downto 0) := "11";
signal op : std_logic_vector (2 downto 0);
signal aa,bb : std_logic_vector (3 downto 0);
begin

    process
       begin
        wait until clock = '1';
        
            
            stateDebug <= state;
            
            --inital waiting state to prevent desyncronization
            if state = "11" then 
                --wait until btn = '1';
                state <= "00";
                
            --idle state            
            elsif state = "00" then
                --wait until btn = '1';
                state <= "01";
            --get data
            elsif(state = "01") then
                aa <= Ai;
                bb <= Bi;
                op <= selIn;
                state <= "10";
                
            -- send data & instruction and execute
            else
                state <= "00";
                ao <= aa;
                bo <= bb;           
                selOut <= op;
                
            end if;
            
            
         
    end process;
            
end Behavioral;
