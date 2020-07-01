module predict(BpctoMe, pcNewtoMe, BtoMe, zerotoMe, BtoID, jumpSuccess, mux1select, correctPc);
    input [31:0] BpctoMe, pcNewtoMe;
    input BtoMe, zerotoMe;
    input BtoID;

    output jumpSuccess, mux1select;
    output [31:0] correctPc;

    reg mux1select, jumpSuccess;
    reg [31:0] correctPc;

    wire jump;
    wire [31:0] nowpc;

    reg BHL[1023:0];

    assign jump = BtoMe&zerotoMe;
    assign nowpc = pcNewtoMe - 4;

    integer i;

    initial begin
      for (i=0; i < 1024; i=i+1) BHL[i] = 0;
    end

    always @(*) begin
        if(BtoMe) begin
             if(BHL[nowpc[11:2]] == jump) begin
                 jumpSuccess = 0;
             end

             else begin
                 jumpSuccess = 1;
                 BHL[nowpc[11:2]] = jump;
                 if(jump) begin
                     correctPc = BpctoMe;
                 end

                 else begin
                     correctPc = pcNewtoMe;
                 end
             end
        end

        else begin
            jumpSuccess = 0;
        end
    end

    always @(*) begin
        if(BtoID)begin
            mux1select = BHL[nowpc[11:2]];
        end

        else begin
            mux1select = 0;
        end
    end
endmodule
