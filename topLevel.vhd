library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity topLevel is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           CLK, BTNC : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (15 downto 0);     
           sel : out STD_LOGIC_VECTOR (7 downto 0); --sel controls which one is on used to be called an
           seg : out STD_LOGIC_VECTOR (6 downto 0); -- seg controls which seg is active, used to be called cn
           DP : out STD_LOGIC);
end topLevel;

architecture Behavioral of topLevel is
     
    component memory is
     Port (index : in STD_LOGIC_VECTOR (3 downto 0);
           A : out STD_LOGIC_Vector (3 downto 0));
    end component; 
    
    component memory1 is
     Port (index : in STD_LOGIC_VECTOR (3 downto 0);
           B : out STD_LOGIC_Vector (3 downto 0));
    end component; 
    
     
    component sevenSeg
    port ( clock : in std_logic ;
           d0,d1,d2,d3,d4,d5,d6,d7 : in std_logic_vector (3 downto 0);
           segs : out std_logic_vector (6 downto 0);
           sl : out std_logic_vector (7 downto 0));
    end component;
    
    component fourBitAU 
    Port ( Sel : IN STD_LOGIC_VECTOR (1 downto 0);
         Cin : IN STD_LOGIC;
         Num1, Num2 : IN STD_LOGIC_VECTOR (3 downto 0);
         Fout : OUT STD_LOGIC_VECTOR (3 downto 0);
         Cout : OUT STD_LOGIC );
    end component;
    
    component control is
        Port ( SelIn : IN STD_LOGIC_VECTOR (2 downto 0);
         Ai, Bi : IN std_logic_vector (3 downto 0);
         clock : IN std_logic;
         btn : IN std_logic;
         Ao, Bo : OUT std_logic_vector (3 downto 0);
         selOut : OUT std_logic_vector (2 downto 0);
         stateDebug : out std_logic_vector (1 downto 0));
    end component;

    --stores the 3 operation to be performed by the alus
    signal instruct : std_logic_vector (2 downto 0);
    
    --a0 and b0 represent the 1st alus data pair
    --a1 and b1 represent the 2nd alus data pair
    --index0 and index1 go to each respective memory unit
    --Z stores a 0 vector just for easy 7seg displaying
    --r0 and r1 store the result from each respective alu
    --N0 stores the 4 bit vector that holds the selected operation
    --test contains the current state of the control unit for debugging
    signal a0,b0,a1,b1,index0,index1,Z,r0,r1,N0,test : std_logic_vector (3 downto 0);

    --aa and bb hold the indexs sent fron the control unit to the memory units
    signal aa, bb : std_logic_vector (3 downto 0);
    --ss stores the selected operation for the alus to perform
    signal ss : std_logic_vector (2 downto 0);
    
    --print state holds the current state of the cpu to printed
    signal printState : std_logic_vector (1 downto 0);
begin 

    Z <= "0000"; -- simple 0 vector for printing 0
    
    --takes 3 rightmost switches control the operation of the alus
    instruct <= SW(2 downto 0);
    --left most 4 switches control the index of mem0
    index0 <= SW(15 downto 12);
    --next left 4 switches control the index of mem1
    index1 <= SW(11 downto 8);

    
    ctrl : control port map(selIn => instruct, Ai => index0, Bi => index1, clock=>CLK, btn => BTNC, Ao => aa, Bo=> bb, selOut =>  ss ,stateDebug=>printState );
    
    mem0a : memory port map(index => aa, A=>a0);
    mem0b : memory1 port map(index => aa, B=>b0);
    mem1a : memory port map(index => bb, A=>a1);
    mem1b : memory1 port map(index => bb, B=>b1);
    
    AU0 : fourBitAU port map(Cin=> ss(0), num1=>a0, num2=> b0, sel=> ss(2 downto 1), fout=> r0, cout=> LED(0));
    AU1 : fourBitAU port map(Cin=> ss(0), num1=>a1, num2=> b1, sel=> ss(2 downto 1), fout=> r1, cout=> LED(1));
   
    --padding with 0's to be sent into 7seg
    test<= "00"&printState;
    --padding with 0 to sent to 7seg
    N0 <= '0'&ss;
    
    seg7 : sevenSeg port map(clock => CLK, d0=>N0, d1=>Z, d2=>r1, d3=>r0, d4=>b1, d5=>a1, d6=>b0, d7=>a0, segs => seg, sl=>sel);

end Behavioral;

