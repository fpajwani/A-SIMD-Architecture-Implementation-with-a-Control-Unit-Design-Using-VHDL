library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity oneBitAU is
  Port ( Sel : IN STD_LOGIC_VECTOR (2 downto 0); 
         A, B, Cin : IN STD_LOGIC; 
         F, Cout : OUT STD_LOGIC );
end oneBitAU;

architecture Behavioral of oneBitAU is

signal aSig, bSig, cinSig : STD_LOGIC;

begin

    process(Sel, Cin,A,B)
    begin
        if sel = "000" then    -- A + B (add)
--            F <= Cin XOR (A XOR B);
--            Cout <= (Cin AND (A XOR B)) OR (A AND B);
            aSig   <= A;
            bSig   <= B;
            cinSig <= Cin;
        
        elsif sel = "010" then -- A complement + B
--            F <= Cin XOR (NOT(A) XOR B);
--            Cout <= (Cin AND (NOT(A) XOR B)) OR (NOT(A) AND B);
            aSig   <= NOT(A);
            bSig   <= B;
            cinSig <= Cin;
        
        elsif sel = "100" then -- A - 1 (decrement)
--            -- always adds 1
--            F <= Cin XOR (A XOR '1');
--            Cout <= (Cin AND (A XOR '1')) OR (A AND '1');
            aSig   <= A;
            bSig   <= '1';
            cinSig <= Cin;
                    
        elsif sel = "110" then -- A complement (1's complement)
--            F <= Cin XOR (A XOR '1');
--            Cout <= '0';
            aSig   <= A;
            bSig   <= '1';
            cinSig <= '0';
            
        elsif sel = "001" then -- A + B complement + 1 (sub A - B)
--            F <= Cin XOR (A XOR NOT(B));
--            Cout <= (Cin AND (A XOR NOT(B))) OR (A AND NOT(B));
            aSig   <= A;
            bSig   <= NOT(B);
            cinSig <= Cin;
            
        elsif sel = "011" then -- A complement + B + 1 (sub B - A)
--            F <= Cin XOR (NOT(A) XOR B);
--            Cout <= (Cin AND (NOT(A) XOR B)) OR (NOT(A) AND B);
            aSig   <= NOT(A);
            bSig   <= B;
            cinSig <= Cin;
            
        elsif sel = "101" then -- A + 1 (increment)
--            F <= Cin XOR (A XOR '0');
--            Cout <= (Cin AND (A XOR '0')) OR (A AND '0');
            aSig   <= A;
            bSig   <= '0';
            cinSig <= Cin;
            
        else                   -- sel = "111", A complement + 1 (2's complement)
--            F <= Cin XOR (NOT(A) XOR '0');
--            Cout <= (Cin AND (NOT(A) XOR '0')) OR (NOT(A) AND '0');
            aSig   <= NOT(A);
            bSig   <= '0';
            cinSig <= Cin;
            
        end if;
    end process;

    -- full adder
    F <= cinSig XOR (aSig XOR bSig);
    Cout <= (cinSig AND (aSig XOR bSig)) OR (aSig AND bSig);

end Behavioral;
