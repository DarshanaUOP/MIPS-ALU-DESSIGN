/*	
	REGISTRATION NO	: E/14/023
	REFFERENCE 	: "Computer_Organization_and_Design_5th_Edi.pdf"
	CHAPTER		: "Constructing a Basic Arithmetic Logic Unit"
*/
module MIPSALU(ALUCtl,A,B,ALUOut,Zero);
	input 		[3:0] ALUCtl;
	input 		[31:0] A,B;
	output 	 reg	[31:0] ALUOut;
	output		Zero;

	assign Zero = (ALUOut==0);	// Zero is true if ALUOut is 0
	always @(ALUCtl,A,B) begin	// reevaluate if these change
		case (ALUCtl)
			0: ALUOut <= A & B;
			1: ALUOut <= A | B;
			2: ALUOut <= A + B;
			6: ALUOut <= A - B;
			7: ALUOut <= A < B ? 1 : 0;
			12: ALUOut <= ~(A | B);
			default: ALUOut <= 0;
		endcase
	end
endmodule

`timescale 1 ns / 1 ps 
module tb_MIPSALU();
	
	wire 		Zero;
	reg	[31:0] 	A,B;
	
	wire	[31:0]	ALUOut;
	reg 	[3:0]	ALUCtl;
	
	MIPSALU		ALU	(ALUCtl,A,B,ALUOut,Zero);

initial begin
	A	=	32'h0;
	B	=	32'h0;
	ALUCtl		=	4'h0;

/* TEST CASSES FOR AND OPERATION */
	#20	ALUCtl	=	4'h0;		// 0 - AND
	// SET A AND B BOTH ZERO
	#20	A	=	32'h0;
	#20	B	=	32'h0;

	// SET A AND B BOTH ONE
	#20	A	=	32'h1;
	#20	B	=	32'h1;

	// REMAIN A ONE AND CHANGE B TO TWO
	#20	A	=	32'h1;
	#20	B	=	32'h2;

	// CHANGE A INTO 3 AND B INTO 6 
	#20	A	=	32'h3;
	#20	B	=	32'h6;

	// CHANGE A INTO 7 AND B INTO 4
	#20	A	=	32'h7;
	#20	B	=	32'h4;

	// CHANGE A INTO 4'ha (TEN) AND B INTO 4'hc (12)
	#20	A	=	32'ha;
	#20	B	=	32'hc;

/* TEST CASSES FOR OR OPERATION */	
	#20	ALUCtl	=	4'h1;		// 1 - OR 
	// SET A AND B BOTH ZERO
	#20	A	=	32'h0;
	#20	B	=	32'h0;

	// SET A AND B BOTH ONE
	#20	A	=	32'h1;
	#20	B	=	32'h1;

	// REMAIN A ONE AND CHANGE B TO TWO
	#20	A	=	32'h1;
	#20	B	=	32'h2;

	// CHANGE A INTO 3 AND B INTO 6 
	#20	A	=	32'h3;
	#20	B	=	32'h6;

	// CHANGE A INTO 7 AND B INTO 4
	#20	A	=	32'h7;
	#20	B	=	32'h4;

	// CHANGE A INTO 4'ha (TEN) AND B INTO 4'hc (12)
	#20	A	=	32'ha;
	#20	B	=	32'hc;

/* TEST CASSES FOR ADD OPERATION */
	#20	ALUCtl	=	4'b0010;	// 2 - ADD
	// SET A AND B BOTH ZERO
	#20	A	=	32'h0;
	#20	B	=	32'h0;

	// SET A AND B BOTH ONE
	#20	A	=	32'h1;
	#20	B	=	32'h1;

	// REMAIN A ONE AND CHANGE B TO TWO
	#20	A	=	32'h1;
	#20	B	=	32'h2;

	// CHANGE A INTO 3 AND B INTO 6 
	#20	A	=	32'h3;
	#20	B	=	32'h6;

	// CHANGE A INTO 7 AND B INTO 4
	#20	A	=	32'h7;
	#20	B	=	32'h4;

	// CHANGE A INTO 4'ha (TEN) AND B INTO 4'hc (12)
	#20	A	=	32'ha;
	#20	B	=	32'hc;

/* TEST CASSES FOR SUBSTRACT OPERATION */
	#20	ALUCtl	=	4'b0110;	// 6 - Substrct
	// SET A AND B BOTH ZERO
	#20	A	=	32'h0;
	#20	B	=	32'h0;

	// SET A AND B BOTH ONE
	#20	A	=	32'h1;
	#20	B	=	32'h1;

	// REMAIN A ONE AND CHANGE B TO TWO
	#20	A	=	32'h1;
	#20	B	=	32'h2;

	// CHANGE A INTO 3 AND B INTO 6 
	#20	A	=	32'h3;
	#20	B	=	32'h6;

	// CHANGE A INTO 7 AND B INTO 4
	#20	A	=	32'h7;
	#20	B	=	32'h4;

	// CHANGE A INTO 4'ha (TEN) AND B INTO 4'hc (12)
	#20	A	=	32'ha;
	#20	B	=	32'hc;

/* TEST CASSES FOR 'SET ON LESS THAN OPERATION' */ 
	#20	ALUCtl	=	4'h7;	// 7 - Set on Less Than (SLT)
	// SET A AND B BOTH ZERO
	#20	A	=	32'h0;
	#20	B	=	32'h0;

	// SET A AND B BOTH ONE
	#20	A	=	32'h1;
	#20	B	=	32'h1;

	// REMAIN A ONE AND CHANGE B TO TWO
	#20	A	=	32'h1;
	#20	B	=	32'h2;

	// CHANGE A INTO 3 AND B INTO 6 
	#20	A	=	32'h3;
	#20	B	=	32'h6;

	// CHANGE A INTO 7 AND B INTO 4
	#20	A	=	32'h7;
	#20	B	=	32'h4;

	// CHANGE A INTO 4'ha (TEN) AND B INTO 4'hc (12)
	#20	A	=	32'ha;
	#20	B	=	32'hc;

/* TEST CASSES FOR 'NOR' OPERATION */
	#20	ALUCtl	=	4'hc;	// 12 - NOR
	// SET A AND B BOTH ZERO
	#20	A	=	32'h0;
	#20	B	=	32'h0;

	// SET A AND B BOTH ONE
	#20	A	=	32'h1;
	#20	B	=	32'h1;

	// REMAIN A ONE AND CHANGE B TO TWO
	#20	A	=	32'h1;
	#20	B	=	32'h2;

	// CHANGE A INTO 3 AND B INTO 6 
	#20	A	=	32'h3;
	#20	B	=	32'h6;

	// CHANGE A INTO 7 AND B INTO 4
	#20	A	=	32'h7;
	#20	B	=	32'h4;

	// CHANGE A INTO 4'ha (TEN) AND B INTO 4'hc (12)
	#20	A	=	32'ha;
	#20	B	=	32'hc;
end

endmodule
