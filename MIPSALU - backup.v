/*
	REFFERENCE : "E:\Semester 8\EE587  Digital Systems Design and Synthesis\Books\Computer_Organization_and_Design_5th_Edi.pdf"
		   CHAPTER	: "Constructing a Basic Arithmetic Logic Unit"
*/
module MIPSALU(ALUCtl,A,B,ALUOut,Zero)
	input [3:0] ALUctl;
	input [31:0] A,B;
	output reg [31:0] ALUOut;
	output Zero;

	assign Zero = (ALUOut==0);	// Zero is true if ALUOut is 0
	always @(ALUctl,A,B) begin	// reevaluate if these change
		case (ALUctl)
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

module ALUControl (ALUOp,FuncCode,ALUCtl)
	input [1:0] ALUOp;
	input [5:0] FuncCode;
	output reg [3:0] ALUCtl;
	
	always case(FuncCode)
		32: ALUOp <= 2;		// ADD
		34: ALUOp <= 6;		// SUBSTRACT
		36: ALUOp <= 0;		// AND
		37: ALUOp <= 1;		// OR
		39: ALUOp <= 12;	// NOR
		42: ALUOp <= 7;		// SLT (Set Less Than)
		default: ALUOp <= 15;	// Not happened
	endcase
endmodule

`timescale 1 ns / 1 ps
module tb_MIPSALU()
	reg [1:0] ALUOp;

	MIPSALU		ALU		(ALUCtl,A,B,ALUOut,Zero)
	ALUControl	ALUCONTROL	(ALUOp,FuncCode,ALUCtl)

endmodule