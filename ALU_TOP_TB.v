`timescale 1us/1ns
module ALU_TOP_TB #(parameter IN_DATA_WIDTH_TB = 16 ,
            Arith_OUT_WIDTH_TB = IN_DATA_WIDTH_TB + IN_DATA_WIDTH_TB , // multiply need more bits 
            LOGIC_OUT_WIDTH_TB = IN_DATA_WIDTH_TB ,
            SHIFT_OUT_WIDTH_TB = IN_DATA_WIDTH_TB ,
            CMP_OUT_WIDTH_TB   = 3 
)();

 //Declartions
 reg  signed [IN_DATA_WIDTH_TB-1:0]   A_TB,B_TB;
 reg         [3:0]                    ALU_FUNC_TB;
 reg                                  CLK_TB;
 reg                                  RST_TB;

 wire signed [Arith_OUT_WIDTH_TB-1:0] Arith_OUT_TB;
 wire                                 Arith_Flag_TB;
 wire                                 Carry_OUT_TB;
 wire        [LOGIC_OUT_WIDTH_TB-1:0] LOGIC_OUT_TB;
 wire                                 LOGIC_Flag_TB;
 wire        [CMP_OUT_WIDTH_TB-1:0]   CMP_OUT_TB;
 wire                                 CMP_Flag_TB;
 wire        [SHIFT_OUT_WIDTH_TB-1:0] SHIFT_OUT_TB;
 wire                                 SHIFT_Flag_TB;

 // Instantiatios
 ALU_TOP
# ( .IN_DATA_WIDTH(IN_DATA_WIDTH_TB),
           .Arith_OUT_WIDTH(Arith_OUT_WIDTH_TB),
           .LOGIC_OUT_WIDTH(LOGIC_OUT_WIDTH_TB),
           .SHIFT_OUT_WIDTH(SHIFT_OUT_WIDTH_TB),
           .CMP_OUT_WIDTH  (CMP_OUT_WIDTH_TB))
 DUT_ALU (
  .A(A_TB),
  .B(B_TB),
  .CLK(CLK_TB),
  .RST(RST_TB),
  .ALU_FUNC(ALU_FUNC_TB),
  .Arith_OUT(Arith_OUT_TB),
  .Arith_Flag(Arith_Flag_TB),
  .Carry_OUT(Carry_OUT_TB),
  .Logic_OUT(LOGIC_OUT_TB),
  .Logic_Flag(LOGIC_Flag_TB),
  .CMP_OUT(CMP_OUT_TB),
  .CMP_Flag(CMP_Flag_TB),
  .SHIFT_OUT(SHIFT_OUT_TB),
  .SHIFT_Flag(SHIFT_Flag_TB)
  );

// CLOCK Generator
always 
 begin 
   if (CLK_TB)
     #6 CLK_TB=1'b0;
   else 
     #4 CLK_TB=1'b1;
 end 

// Initialization
initial 
  begin
    $dumpfile("ALU_TOP.cdv");
    $dumpvars;
    CLK_TB=1'b0;
    RST_TB=1'b1;
    A_TB=1'b0;
    B_TB=1'b0;
    ALU_FUNC_TB=4'b0;

/************************************************** ADDING ***************************************************/

$display("tast_1     **Addition**  NEG+NEG ");    
  #3 
  ALU_FUNC_TB=4'b0000;
  A_TB=16'shfffc;
  B_TB=16'shfffE;
  #7
    if(Arith_OUT_TB==16'shfffA )
         $display("tast_1  **Addition**  NEG+NEG =%0d  is passed",Arith_OUT_TB);
    else $display("tast_1  **Addition**  NEG+NEG =%0d  is fialed",Arith_OUT_TB);
 
              
$display("tast_2     **Addition**  NEG+POS ");
  #3 
   ALU_FUNC_TB=4'b0000;
   A_TB=16'shfffc;
   B_TB=16'sh2;
  #7
    if(Arith_OUT_TB==16'shfffE)
         $display("tast_2  **Addition**  NEG+POS   =%0d  is passed",Arith_OUT_TB);
    else $display("tast_2  **Addition**  NEG+POS   =%0d  is fialed",Arith_OUT_TB); 
              
$display("tast_3     **Addition**  POS+NEG ");    
  
    #3 
    ALU_FUNC_TB=4'b0000;
    A_TB=16'sh4;
    B_TB=16'shfffE;
    #7
    if(Arith_OUT_TB==16'sh2)
         $display("tast_3  **Addition**  POS+NEG   =%0d  is passed",Arith_OUT_TB);
    else $display("tast_3  **Addition**  POS+NEG   =%0d  is fialed",Arith_OUT_TB);
              
$display("tast_4    **Addition**  POS + POS ");    
  
  #3 
  ALU_FUNC_TB=4'b0000;
  A_TB=16'sh4;
  B_TB=16'sh2;
  #7
    if(Arith_OUT_TB==16'sh6)
         $display("tast_4  **Addition**  POS+POS   =%0d  is passed",Arith_OUT_TB);
    else $display("tast_4  **Addition**  POS+POS   =%0d  is fialed",Arith_OUT_TB);  
  

/************************************************** Subtraction ***************************************************/

$display("tast_5  ** Subtraction**  NEG-NEG ");    
    #3 
    ALU_FUNC_TB=4'b0001;
    A_TB=16'shfffc;
    B_TB=16'shfffE;
    #7
    if(Arith_OUT_TB==16'shfffE)
         $display("tast_5  ** Subtraction**  NEG-NEG   =%0d  is passed",Arith_OUT_TB);
    else $display("tast_5  ** Subtraction**  NEG-NEG   =%0d  is fialed",Arith_OUT_TB); 
              

$display("tast_6  ** Subtraction**  NEG-POS ");    
    #3 
     ALU_FUNC_TB=4'b0001;
     A_TB=16'shfffc;
     B_TB=16'sh2;
    #7
    if(Arith_OUT_TB==16'shfffA)
         $display("tast_6  ** Subtraction**  NEG-POS   =%0d  is passed",Arith_OUT_TB);
    else $display("tast_6  ** Subtraction**  NEG-POS   =%0d  is fialed",Arith_OUT_TB); 
     
   
$display("tast_7  ** Subtraction**  POS-NEG ");    
    #3 
    ALU_FUNC_TB=4'b0001;
    A_TB=16'sh4;
    B_TB=16'shfffE;
    #7
    if(Arith_OUT_TB==16'sh6)
          $display("tast_7  ** Subtraction**  POS-NEG   =%0d  is passed",Arith_OUT_TB);
    else  $display("tast_7  ** Subtraction**  POS-NEG   =%0d  is fialed",Arith_OUT_TB);
             
 
$display("tast_8  ** Subtraction**  POS-POS ");    
    #3 
    ALU_FUNC_TB=4'b0001;
    A_TB=16'sh4;
    B_TB=16'sh2;
    #7
    if(Arith_OUT_TB==16'sh2)
         $display("tast_8  ** Subtraction**  POS-POS   =%0d  is passed",Arith_OUT_TB);
    else $display("tast_8  ** Subtraction**  POS-POS   =%0d  is fialed",Arith_OUT_TB);  
  

/************************************************** Multiplication ***************************************************/

$display("tast_9  **Multiplication**  NEG*NEG ");    
  
    #3 
    ALU_FUNC_TB=4'b0010;
    A_TB=16'shfffc;
    B_TB=16'shfffE;
    #7
    if(Arith_OUT_TB==16'sh8)
         $display("tast_9  **Multiplication**  NEG*NEG   =%0d  is passed",Arith_OUT_TB);
    else $display("tast_9  **Multiplication**  NEG*NEG   =%0d  is fialed",Arith_OUT_TB); 
              

$display("tast_10  **Multiplication**  NEG*POS ");    
    #3 
    ALU_FUNC_TB=4'b0010;
    A_TB=16'shfffc;
    B_TB=16'sh2;
    #7
    if(Arith_OUT_TB==16'shfff8)
         $display("tast_10  **Multiplication**  NEG*POS  =%0d  is passed",Arith_OUT_TB);
    else $display("tast_10  **Multiplication**  NEG*POS  =%0d  is fialed",Arith_OUT_TB); 
              
$display("tast_11  **Multiplication**  POS*NEG ");    
    #3 
    ALU_FUNC_TB=4'b0010;
    A_TB=16'sh4;
    B_TB=16'shfffE;
    #7
    if(Arith_OUT_TB==16'shfff8)
         $display("tast_11  **Multiplication**  POS*NEG  =%0d  is passed",Arith_OUT_TB);
    else $display("tast_11  **Multiplication**  POS*NEG  =%0d  is fialed",Arith_OUT_TB);
              
$display("tast_12  **Multiplication**  POS*POS ");    
    #3 
    ALU_FUNC_TB=4'b0010;
    A_TB=16'sh4;
    B_TB=16'sh2;
    #7
    if(Arith_OUT_TB==16'sh8)
         $display("tast_12  **Multiplication**  POS*POS  =%0d  is passed",Arith_OUT_TB);
    else $display("tast_12  **Multiplication**  POS*POS  =%0d  is fialed",Arith_OUT_TB); 
  
  
/************************************************** Multiplication ***************************************************/

$display("tast_13  ** Division**  NEG/NEG ");    
    #3 
    ALU_FUNC_TB=4'b0011;
    A_TB=16'shfffc;
    B_TB=16'shfffE;
    #7
    if(Arith_OUT_TB==16'sh2)
         $display("tast_13      ** Division**  NEG/NEG  =%0d  is passed",Arith_OUT_TB);
    else $display("tast_13      ** Division**  NEG/NEG  =%0d  is fialed",Arith_OUT_TB); 
              
$display("tast_14  ** Division**  NEG/POS ");    
  
    #3 
    ALU_FUNC_TB=4'b0011;
    A_TB=16'shfffc;
    B_TB=16'sh2;
    #7
    if(Arith_OUT_TB==16'shfffE)
         $display("tast_14      ** Division**  NEG/POS  =%0d  is passed",Arith_OUT_TB);
    else $display("tast_14      ** Division**  NEG/POS  =%0d  is fialed",Arith_OUT_TB); 
              
$display("tast_15  ** Division**  POS/NEG ");    
    #3 
    ALU_FUNC_TB=4'b0011;
    A_TB=16'sh4;
    B_TB=16'shfffE;
    #7
    if(Arith_OUT_TB==16'shfffE)
         $display("tast_15      ** Division**  POS/NEG  =%0d  is passed",Arith_OUT_TB);
    else $display("tast_15      ** Division**  POS/NEG  =%0d  is fialed",Arith_OUT_TB);
              
$display("tast_16  ** Division**  POS/POS ");    
    #3 
    ALU_FUNC_TB=4'b0011;
    A_TB=16'sh4;
    B_TB=16'sh2;
    #7
    if(Arith_OUT_TB==16'sh2)
          $display("tast_16     ** Division**  POS/POS  =%0d  is passed",Arith_OUT_TB);
    else  $display("tast_16     ** Division**  POS/POS  =%0d  is fialed",Arith_OUT_TB);

   
/************************************************** LOGIC AND***************************************************/

$display("tast_17   **Logical   AND ** ");    
    #3 
    ALU_FUNC_TB=4'b0100;
    #7
    if(LOGIC_OUT_TB==16'h0)
         $display("tast_17         **Logical   AND **  =%0d  is passed",LOGIC_OUT_TB);
    else $display("tast_17         **Logical   AND **  =%0d  is fialed",LOGIC_OUT_TB);   
    

/************************************************** LOGIC OR ***************************************************/

$display("tast_18   **Logical   OR  ** ");    
    #3 
    ALU_FUNC_TB=4'b0101;
    #7
    if(LOGIC_OUT_TB==16'h6)
         $display("tast_18        **Logical   OR  **  =%0d  is passed",LOGIC_OUT_TB);
    else $display("tast_18        **Logical   OR  **  =%0d  is fialed",LOGIC_OUT_TB); 

/************************************************** LOGIC NAND ***************************************************/
    
$display("tast_19   **Logical   NAND  ** ");    
    #3 
    ALU_FUNC_TB=4'b0110;
    #7
    if(LOGIC_OUT_TB==16'hffff)
         $display("tast_19       **Logical   NAND  **  =%0d  is passed",LOGIC_OUT_TB);
    else $display("tast_19       **Logical   NAND  **  =%0d  is fialed",LOGIC_OUT_TB);
 
/************************************************** LOGIC NOR ***************************************************/
    
$display("tast_20   **Logical   NOR  ** ");    
    #3 
    ALU_FUNC_TB=4'b0111;
    #7
    if(LOGIC_OUT_TB==16'hfff9)
         $display("tast_20       **Logical   NOR  **  =%0d  is passed",LOGIC_OUT_TB);
    else $display("tast_20       **Logical   NOR  **  =%0d  is fialed",LOGIC_OUT_TB);  

/************************************************** NOP ***************************************************/
    
$display("tast_21     **Compare   NON **  ");    
    #3 
    ALU_FUNC_TB=4'b1000;
    #7
    if(CMP_OUT_TB==16'h0)
         $display("tast_21       **Compare   NON **   =%0d  is passed",CMP_OUT_TB);
    else $display("tast_21       **Compare   NON **   =%0d  is fialed",CMP_OUT_TB);                   
    
/************************************************** Compare ***************************************************/
    
$display("tast_22   **Compare   Equal **  ");    
    #3 
    ALU_FUNC_TB=4'b1001;
    #7
    if(CMP_OUT_TB==16'h0)
         $display("tast_22  	**Compare   Equal **   =%0d  is passed",CMP_OUT_TB);
    else $display("tast_22  	**Compare   Equal **   =%0d  is fialed",CMP_OUT_TB);                   
        
$display("tast_23  **Compare   Greater **  ");    
    #3 
    ALU_FUNC_TB=4'b1010;
    #7
    if(CMP_OUT_TB==16'h2)
         $display("tast_23 	**Compare   Greater **  =%0d  is passed",CMP_OUT_TB);
    else $display("tast_23	**Compare   Greater **  =%0d  is fialed",CMP_OUT_TB);                   
        
$display("tast_24  **Compare   Less ** ");    
  
    #3 
    ALU_FUNC_TB=4'b1011;
    #7
    if(CMP_OUT_TB==16'h0)
         $display("tast_24 	**Compare   Less **     =%0d  is passed",CMP_OUT_TB);
    else $display("tast_24 	**Compare   Less **     =%0d  is fialed",CMP_OUT_TB);                   
        
/********************************************* SHIFT *******************************************************/

$display("tast_25");    
    #3 
    ALU_FUNC_TB=4'b1100;
    #7
    if(SHIFT_OUT_TB==16'h2)
         $display("tast_25 	 ** SHIFT ** =%0d  is passed",SHIFT_OUT_TB);
    else $display("tast_25  	 ** SHIFT ** =%0d  is fialed",SHIFT_OUT_TB);        
    
$display("tast_26");    
    #3 
    ALU_FUNC_TB=4'b1101;
    #7
    if(SHIFT_OUT_TB==16'h8)
         $display("tast_26  	** SHIFT ** =%0d  is passed",SHIFT_OUT_TB);
    else $display("tast_26  	** SHIFT ** =%0d  is fialed",SHIFT_OUT_TB);
    
$display("tast_27");    
    #3 
    ALU_FUNC_TB=4'b1110;
    #7
    if(SHIFT_OUT_TB==16'h1)
         $display("tast_27  	** SHIFT ** =%0d  is passed",SHIFT_OUT_TB);
    else $display("tast_27 	** SHIFT ** =%0d  is fialed",SHIFT_OUT_TB);
    
$display("tast_28");    
    #3 
    ALU_FUNC_TB=4'b1111;
    #7
    if(SHIFT_OUT_TB==16'h4)
         $display("tast_28  	** SHIFT ** =%0d  is passed",SHIFT_OUT_TB);
    else $display("tast_28  	** SHIFT ** =%0d  is fialed",SHIFT_OUT_TB);  
    

 #100
 $finish ;
 end
endmodule 