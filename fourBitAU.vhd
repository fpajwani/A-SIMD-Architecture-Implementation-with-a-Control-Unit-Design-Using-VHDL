library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fourBitAU is
  Port ( Sel : IN STD_LOGIC_VECTOR (1 downto 0);
         Cin : IN STD_LOGIC;
         Num1, Num2 : IN STD_LOGIC_VECTOR (3 downto 0);
         Fout : OUT STD_LOGIC_VECTOR (3 downto 0);
         Cout : OUT STD_LOGIC );
end fourBitAU;

architecture Behavioral of fourBitAU is

component oneBitAU is
  Port ( Sel : IN STD_LOGIC_VECTOR (2 downto 0); 
         A, B, Cin : IN STD_LOGIC; 
         F, Cout : OUT STD_LOGIC );
end component;

signal carryFA : STD_LOGIC_VECTOR (4 downto 0);
signal sel3bit : STD_LOGIC_VECTOR (2 downto 0);

begin

    carryFA(0) <= Cin;
    sel3bit <= Sel & Cin;
    
    AU: for i in 0 to 3 generate
    
        U0: oneBitAU Port Map ( Sel => sel3bit,
                              A => Num1(i),
                              B => Num2(i),
                              Cin => carryFA(i),
                              F => Fout(i),
                              Cout => carryFA(i+1) );
        
    end generate AU;
    
    Cout <= carryFA(4);

end Behavioral;
