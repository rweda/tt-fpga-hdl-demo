module PmodOLED_PowerOn(
    input clk,            // System clock
    input rst_n,          // Active low reset
    output reg oled_cs,   // OLED CS
    output reg oled_sclk, // OLED Serial Clock
    output reg oled_sdin, // OLED Data Input
    input oled_sdout,     // OLED Data Output
    output reg oled_dc,   // OLED Data/Command Control
    output reg oled_res,  // OLED Reset
    output reg oled_vbat, // OLED VBAT Control
    output reg oled_vdd   // OLED VDD Control
);

    // Parameters
    parameter NUM_BYTES = 4; // Number of bytes to send
    parameter BYTE_SEQ = {8'hA5, 8'h5A, 8'h3C, 8'hC3}; // Example byte sequence

    // State definition
    localparam RESET_OLED       = 3'd0,
               INIT_START       = 3'd1,
               DISPLAY_OFF      = 3'd2,
               SET_CHARGE_PUMP  = 3'd3,
               SET_SEG_REMAP    = 3'd4,
               // Add more states based on your display's initialization sequence
               DISPLAY_CLEAR    = 3'd5,
               DISPLAY_ON       = 3'd6,
               INIT_DONE        = 3'd7;

    // SPI Master instantiation
    reg start_spi;
    reg [7:0] data_to_send;
    wire [7:0] data_received;
    wire done_spi;

    reg [3:0] current_state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= RESET_OLED;
        else
            current_state <= next_state;
    end

    always @(posedge clk) begin
        case (current_state)
            RESET_OLED: begin
                oled_res = 0; // Assert reset
                next_state = INIT_START;
            end
            INIT_START: begin
                oled_res = 1; // Release reset
                next_state = DISPLAY_OFF;
            end
            DISPLAY_OFF: begin
                // Code to send command for display off
                send_byte(8'hAE);
                send_byte(8'hA8);
                send_byte(8'h3F);
                send_byte(8'hD3);
                send_byte(8'h00);
                send_byte(8'h40);
                next_state = SET_CHARGE_PUMP;
            end
            SET_CHARGE_PUMP: begin
                // Code to configure charge pump
                send_byte(8'h8D);
                send_byte(8'h14);
                next_state = SET_SEG_REMAP;
            end
            SET_SEG_REMAP: begin
                // Code to configure charge pump
                send_byte(8'h20);
                send_byte(8'h00);
                next_state = DISPLAY_CLEAR;
            end
            // Add cases for other states
            DISPLAY_CLEAR: begin
                // Code to turn display on
                send_byte(8'hAE);
                next_state = DISPLAY_ON;
            end
            DISPLAY_ON: begin
                // Code to turn display on
                send_byte(8'hAE);
                next_state = INIT_DONE;
            end
            INIT_DONE: begin
                // Initialization complete
            end
            default: begin
                next_state = RESET_OLED;
            end
        endcase
    end

    spi_master spi_master_inst(
        .clk(clk),
        .rst_n(rst_n),
        .start(start_spi),
        .data_in(data_to_send),
        .data_out(data_received),
        .done(done_spi),
        .sclk(oled_sclk),
        .mosi(oled_sdin),
        .miso(oled_sdout),
        .cs(oled_cs)
    );

    // Task for sending a byte
    task send_byte;
        input [7:0] data;
        begin
            data_to_send <= data;
            start_spi <= 1'b1;
            @(posedge clk);
            start_spi <= 1'b0;
            wait(done_spi); // Wait for SPI transmission to complete
            @(posedge clk);
        end
    endtask

endmodule
