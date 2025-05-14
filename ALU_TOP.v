module ALU_TOP 
#(parameter IN_DATA_WIDTH = 16 ,
            Arith_OUT_WIDTH = IN_DATA_WIDTH + IN_DATA_WIDTH , // multiply need more bits 
            LOGIC_OUT_WIDTH = IN_DATA_WIDTH ,
            SHIFT_OUT_WIDTH = IN_DATA_WIDTH ,
            CMP_OUT_WIDTH   = 3 
)( 
input  wire signed [IN_DATA_WIDTH-1:0]  A , B,
input  wire        [3:0]                ALU_FUNC,
input  wire                             RST,CLK,

output wire signed [Arith_OUT_WIDTH-1:0] Arith_OUT,                      
output wire                              Arith_Flag,
output wire                              Carry_OUT,
output wire        [LOGIC_OUT_WIDTH-1:0] Logic_OUT,                      
output wire                              Logic_Flag,
output wire        [SHIFT_OUT_WIDTH-1:0] SHIFT_OUT,                      
output wire                              SHIFT_Flag,
output wire        [CMP_OUT_WIDTH-1:0]   CMP_OUT,                      
output wire                              CMP_Flag
);

// Internal Signal 
wire Arith_Enable;  
wire Logic_Enable;
wire SHIFT_Enable;
wire CMP_Enable;

// DECODER
DECODER_UNIT DECODER(
.IN  (ALU_FUNC[3:2]),
.SHIFT_Enable(SHIFT_Enable),
.Arith_Enable(Arith_Enable),
.Logic_Enable(Logic_Enable),
.CMP_Enable(CMP_Enable)
);

// ARITHMATIC UNIT
ARITHMETIC_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH) , .OUT_DATA_WIDTH(Arith_OUT_WIDTH)) ARITHMETIC (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.RST(RST),
.CLK(CLK),
.Arith_Enable(Arith_Enable),
.Arith_OUT(Arith_OUT),
.Arith_Flag(Arith_Flag),
.Carry_OUT(Carry_OUT)
);

// LOGIC UNIT
LOGIC_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH) , .OUT_DATA_WIDTH(LOGIC_OUT_WIDTH)) LOGIC (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.RST(RST),
.CLK(CLK),
.Logic_Enable(Logic_Enable),
.Logic_OUT(Logic_OUT),
.Logic_Flag(Logic_Flag)
);

// SHIFT UNIT
SHIFT_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH) , .OUT_DATA_WIDTH(SHIFT_OUT_WIDTH)) SHIFT (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.RST(RST),
.CLK(CLK),
.SHIFT_Enable(SHIFT_Enable),
.SHIFT_OUT(SHIFT_OUT),
.SHIFT_Flag(SHIFT_Flag)
);

// CMP UNIT
CMP_UNIT # ( .IN_DATA_WIDTH(IN_DATA_WIDTH) , .OUT_DATA_WIDTH(CMP_OUT_WIDTH)) CMP (
.A(A),
.B(B),
.ALU_FUNC(ALU_FUNC[1:0]),
.RST(RST),
.CLK(CLK),
.CMP_Enable(CMP_Enable),
.CMP_OUT(CMP_OUT),
.CMP_Flag(CMP_Flag)
);
endmodule 