//_\TLV_version 1d: tl-x.org, generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro
//_\source top.tlv 47

//_\SV
   // Include Tiny Tapeout Lab.
   // Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/f4142c041d7a4c4235fcfb2f438038c557f254c5/tlv_lib/tiny_tapeout_lib.tlv"// Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlv_lib/fpga_includes.tlv"

   // Default Makerchip TL-Verilog Code Template
   // Included hidden file.// Included hidden file.


// ================================================
// A simple Makerchip Verilog test bench driving random stimulus.
// Modify the module contents to your needs.
// ================================================

module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
   // Tiny tapeout I/O signals.
   logic [7:0] ui_in, uo_out;
   
   logic [31:0] r;
   always @(posedge clk) r <= 0;
   
   
   logic ena = 1'b0;
   logic rst_n = ! reset;

   
   initial begin
      #1
         ui_in = 8'h0;
      #10  // Step over reset.
         ui_in = 8'h01;
      #10
         ui_in = 8'h81;
      #10
         ui_in = 8'h02;
      #10
         ui_in = 8'h82;
   end
   

   // Instantiate the Tiny Tapeout module.
   my_design tt(.*);

   assign passed = top.cyc_cnt > 60;
   assign failed = 1'b0;
endmodule


// Provide a wrapper module to debounce input signals if requested.
// The Tiny Tapeout top-level module.
// This simply debounces and synchronizes inputs.
// Debouncing is based on a counter. A change to any input will only be recognized once ALL inputs
// are stable for a certain duration. This approach uses a single counter vs. a counter for each
// bit.
module tt_um_template (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    
    // Synchronize.
    logic [9:0] inputs_ff, inputs_sync;
    always @(posedge clk) begin
        inputs_ff <= {ui_in, ena, rst_n};
        inputs_sync <= inputs_ff;
    end

    // Debounce.
    `define DEBOUNCE_MAX_CNT 14'h3ffff
    logic [9:0] inputs_candidate, inputs_captured;
    logic sync_rst_n = inputs_sync[0];
    logic [13:0] cnt;
    always @(posedge clk) begin
        if (!sync_rst_n)
           cnt <= `DEBOUNCE_MAX_CNT;
        else if (inputs_sync != inputs_candidate) begin
           // Inputs changed before stablizing.
           cnt <= `DEBOUNCE_MAX_CNT;
           inputs_candidate <= inputs_sync;
        end
        else if (cnt > 0)
           cnt <= cnt - 14'b1;
        else begin
           // Cnt == 0. Capture candidate inputs.
           inputs_captured <= inputs_candidate;
        end
    end
    logic [7:0] clean_ui_in;
    logic clean_ena, clean_rst_n;
    assign {clean_ui_in, clean_ena, clean_rst_n} = inputs_captured;

    my_design my_design (
        .ui_in(clean_ui_in),
        
        .ena(clean_ena),
        .rst_n(clean_rst_n),
        .*);
endmodule
// The above macro expands to multiple lines. We enter a new \SV block to reset line tracking.
//_\SV



// =======================
// The Tiny Tapeout module
// =======================

module my_design (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
   

   wire reset = ! rst_n;

// ---------- Generated Code Inlined Here (before 1st \TLV) ----------
// Generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro from Redwood EDA, LLC.
// (Installed here: /usr/local/mono/sandpiper/distro.)
// Redwood EDA, LLC does not claim intellectual property rights to this file and provides no warranty regarding its correctness or quality.


// For silencing unused signal messages.
`define BOGUS_USE(ignore)


genvar digit, input_label, leds, switch;


//
// Signals declared top-level.
//

// For $slideswitch.
logic [7:0] L0_slideswitch_a0;

// For $sseg_decimal_point_n.
logic L0_sseg_decimal_point_n_a0;

// For $sseg_digit_n.
logic [7:0] L0_sseg_digit_n_a0;

// For $sseg_segment_n.
logic [6:0] L0_sseg_segment_n_a0;

// For /fpga_pins/fpga|calc$diff.
logic [7:0] FpgaPins_Fpga_CALC_diff_a1,
            FpgaPins_Fpga_CALC_diff_a2;

// For /fpga_pins/fpga|calc$digit.
logic [3:0] FpgaPins_Fpga_CALC_digit_a3;

// For /fpga_pins/fpga|calc$equals_in.
logic FpgaPins_Fpga_CALC_equals_in_a0,
      FpgaPins_Fpga_CALC_equals_in_a1,
      FpgaPins_Fpga_CALC_equals_in_a2;

// For /fpga_pins/fpga|calc$mem.
logic [7:0] FpgaPins_Fpga_CALC_mem_a2,
            FpgaPins_Fpga_CALC_mem_a3,
            FpgaPins_Fpga_CALC_mem_a4;

// For /fpga_pins/fpga|calc$op.
logic [2:0] FpgaPins_Fpga_CALC_op_a0,
            FpgaPins_Fpga_CALC_op_a1,
            FpgaPins_Fpga_CALC_op_a2;

// For /fpga_pins/fpga|calc$out.
logic [7:0] FpgaPins_Fpga_CALC_out_a2,
            FpgaPins_Fpga_CALC_out_a3;

// For /fpga_pins/fpga|calc$prod.
logic [7:0] FpgaPins_Fpga_CALC_prod_a1,
            FpgaPins_Fpga_CALC_prod_a2;

// For /fpga_pins/fpga|calc$quot.
logic [7:0] FpgaPins_Fpga_CALC_quot_a1,
            FpgaPins_Fpga_CALC_quot_a2;

// For /fpga_pins/fpga|calc$reset.
logic FpgaPins_Fpga_CALC_reset_a0,
      FpgaPins_Fpga_CALC_reset_a1,
      FpgaPins_Fpga_CALC_reset_a2;

// For /fpga_pins/fpga|calc$reset_or_valid.
logic FpgaPins_Fpga_CALC_reset_or_valid_a1,
      FpgaPins_Fpga_CALC_reset_or_valid_a2;

// For /fpga_pins/fpga|calc$sum.
logic [7:0] FpgaPins_Fpga_CALC_sum_a1,
            FpgaPins_Fpga_CALC_sum_a2;

// For /fpga_pins/fpga|calc$val1.
logic [7:0] FpgaPins_Fpga_CALC_val1_a1,
            FpgaPins_Fpga_CALC_val1_a2;

// For /fpga_pins/fpga|calc$val2.
logic [7:0] FpgaPins_Fpga_CALC_val2_a0,
            FpgaPins_Fpga_CALC_val2_a1;

// For /fpga_pins/fpga|calc$valid.
logic FpgaPins_Fpga_CALC_valid_a1,
      FpgaPins_Fpga_CALC_valid_a2;




   //
   // Scope: /fpga_pins
   //


      //
      // Scope: /fpga
      //


         //
         // Scope: |calc
         //

            // Staging of $diff.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_diff_a2[7:0] <= FpgaPins_Fpga_CALC_diff_a1[7:0];

            // Staging of $equals_in.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_equals_in_a1 <= FpgaPins_Fpga_CALC_equals_in_a0;
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_equals_in_a2 <= FpgaPins_Fpga_CALC_equals_in_a1;

            // Staging of $mem.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_mem_a3[7:0] <= FpgaPins_Fpga_CALC_mem_a2[7:0];
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_mem_a4[7:0] <= FpgaPins_Fpga_CALC_mem_a3[7:0];

            // Staging of $op.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_op_a1[2:0] <= FpgaPins_Fpga_CALC_op_a0[2:0];
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_op_a2[2:0] <= FpgaPins_Fpga_CALC_op_a1[2:0];

            // Staging of $out.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_out_a3[7:0] <= FpgaPins_Fpga_CALC_out_a2[7:0];

            // Staging of $prod.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_prod_a2[7:0] <= FpgaPins_Fpga_CALC_prod_a1[7:0];

            // Staging of $quot.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_quot_a2[7:0] <= FpgaPins_Fpga_CALC_quot_a1[7:0];

            // Staging of $reset.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_reset_a1 <= FpgaPins_Fpga_CALC_reset_a0;
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_reset_a2 <= FpgaPins_Fpga_CALC_reset_a1;

            // Staging of $reset_or_valid.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_reset_or_valid_a2 <= FpgaPins_Fpga_CALC_reset_or_valid_a1;

            // Staging of $sum.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_sum_a2[7:0] <= FpgaPins_Fpga_CALC_sum_a1[7:0];

            // Staging of $val1.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_val1_a2[7:0] <= FpgaPins_Fpga_CALC_val1_a1[7:0];

            // Staging of $val2.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_val2_a1[7:0] <= FpgaPins_Fpga_CALC_val2_a0[7:0];

            // Staging of $valid.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_valid_a2 <= FpgaPins_Fpga_CALC_valid_a1;




// ---------- Generated Code Ends ----------
//_\TLV
   /* verilator lint_off UNOPTFLAT */
   // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/f4142c041d7a4c4235fcfb2f438038c557f254c5/tlvlib/tinytapeoutlib.tlv 76   // Instantiated from top.tlv, 126 as: m5+tt_connections()
      assign L0_slideswitch_a0[7:0] = ui_in;
      assign L0_sseg_segment_n_a0[6:0] = ~ uo_out[6:0];
      assign L0_sseg_decimal_point_n_a0 = ~ uo_out[7];
      assign L0_sseg_digit_n_a0[7:0] = 8'b11111110;
   //_\end_source

   // Instantiate the Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 307   // Instantiated from top.tlv, 129 as: m5+board(/top, /fpga, 7, $, , hidden_solution)
      
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 355   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 309 as: m4+thanks(m5__l(309)m5_eval(m5_get(BOARD_THANKS_ARGS)))
         //_/thanks
            
      //_\end_source
      
   
      // Board VIZ.
   
      // Board Image.
      
      //_/fpga_pins
         
         //_/fpga
            //_\source /raw.githubusercontent.com/stevehoover/immutable/master/MESTcourse/solutions.tlv 105   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 340 as: m4+hidden_solution.
               //_\source /raw.githubusercontent.com/stevehoover/immutable/master/MESTcourse/solutions.tlv 108   // Instantiated from /raw.githubusercontent.com/stevehoover/immutable/master/MESTcourse/solutions.tlv, 106 as: m5+call(m5__l(106)m5_call(if,m5_get(CalcLab), calc_solution, cpu_solution))
                  /* verilator lint_off WIDTH */
                  //_|calc
               
                     // ============================================================================================================
               
               
                     //_@0
                        assign FpgaPins_Fpga_CALC_reset_a0 = reset;
                     
                     //_@0
                        // Board inputs
                        assign FpgaPins_Fpga_CALC_op_a0[2:0] = ui_in[6:4];
                        assign FpgaPins_Fpga_CALC_val2_a0[7:0] = {4'b0, ui_in[3:0]};
                     
                     
                        assign FpgaPins_Fpga_CALC_equals_in_a0 = ui_in[7];
                     
                     //_@1
                        //$reset = *reset;
                        assign FpgaPins_Fpga_CALC_val1_a1[7:0] = FpgaPins_Fpga_CALC_out_a3;
                        
                        
                        assign FpgaPins_Fpga_CALC_valid_a1 = FpgaPins_Fpga_CALC_reset_a1 ? 1'b0 : FpgaPins_Fpga_CALC_equals_in_a1 && ! FpgaPins_Fpga_CALC_equals_in_a2;
                        assign FpgaPins_Fpga_CALC_reset_or_valid_a1 = FpgaPins_Fpga_CALC_valid_a1 || FpgaPins_Fpga_CALC_reset_a1;
                        
               
                        
                        
                           
                           
                                          
                                                         
                        
               
               
                     
                     //_?$reset_or_valid
                        //_@1
                           assign FpgaPins_Fpga_CALC_sum_a1[7:0] = FpgaPins_Fpga_CALC_val1_a1 + FpgaPins_Fpga_CALC_val2_a1;
                           assign FpgaPins_Fpga_CALC_diff_a1[7:0] = FpgaPins_Fpga_CALC_val1_a1 - FpgaPins_Fpga_CALC_val2_a1;
                           assign FpgaPins_Fpga_CALC_prod_a1[7:0] = FpgaPins_Fpga_CALC_val1_a1 * FpgaPins_Fpga_CALC_val2_a1;
                           assign FpgaPins_Fpga_CALC_quot_a1[7:0] = FpgaPins_Fpga_CALC_val1_a1 / FpgaPins_Fpga_CALC_val2_a1;
                        //_@2
                           
                           assign FpgaPins_Fpga_CALC_mem_a2[7:0] = FpgaPins_Fpga_CALC_reset_a2               ? 8'b0 :
                                       FpgaPins_Fpga_CALC_valid_a2 && (FpgaPins_Fpga_CALC_op_a2[2:0] == 3'b101) ? FpgaPins_Fpga_CALC_val1_a2 :
                                                              FpgaPins_Fpga_CALC_mem_a3;
                           
                     
                     
                        
                        
                        
                        
                        
                        
                        
                        
                     
                     //_@2
                        assign FpgaPins_Fpga_CALC_out_a2[7:0] = FpgaPins_Fpga_CALC_reset_a2 ? 8'b0 :
                                    ! FpgaPins_Fpga_CALC_valid_a2 ? FpgaPins_Fpga_CALC_out_a3 :
                                    (FpgaPins_Fpga_CALC_op_a2 == 3'b000) ? FpgaPins_Fpga_CALC_sum_a2  :
                                    (FpgaPins_Fpga_CALC_op_a2 == 3'b001) ? FpgaPins_Fpga_CALC_diff_a2 :
                                    (FpgaPins_Fpga_CALC_op_a2 == 3'b010) ? FpgaPins_Fpga_CALC_prod_a2 :
                                    (FpgaPins_Fpga_CALC_op_a2 == 3'b011) ? FpgaPins_Fpga_CALC_quot_a2 :
                                    (FpgaPins_Fpga_CALC_op_a2 == 3'b100) ? FpgaPins_Fpga_CALC_mem_a4 : FpgaPins_Fpga_CALC_out_a3;
                     
                     //_@3
                        assign FpgaPins_Fpga_CALC_digit_a3[3:0] = FpgaPins_Fpga_CALC_out_a3[3:0];
                        assign uo_out =
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h0 ? 8'b00111111 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h1 ? 8'b00000110 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h2 ? 8'b01011011 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h3 ? 8'b01001111 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h4 ? 8'b01100110 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h5 ? 8'b01101101 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h6 ? 8'b01111101 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h7 ? 8'b00000111 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h8 ? 8'b01111111 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'h9 ? 8'b01101111 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'hA ? 8'b01110111 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'hB ? 8'b01111100 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'hC ? 8'b00111001 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'hD ? 8'b01011110 :
                           FpgaPins_Fpga_CALC_digit_a3 == 4'hE ? 8'b01111001 :
                                            8'b01110001;
                     
                        
                     
                  
               
                  // ============================================================================================================
               
                  // Connect Tiny Tapeout outputs.
                  // (*uo_out connected above.)
                  
                  
               //_\end_source
            
            //_\end_source
   
      // LEDs.
      
   
      // 7-Segment
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 395   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 346 as: m4+fpga_sseg.
         for (digit = 0; digit <= 0; digit++) begin : L1_Digit //_/digit
            
            for (leds = 0; leds <= 7; leds++) begin : L2_Leds //_/leds

               // For $viz_lit.
               logic L2_viz_lit_a0;

               assign L2_viz_lit_a0 = (! L0_sseg_digit_n_a0[digit]) && ! ((leds == 7) ? L0_sseg_decimal_point_n_a0 : L0_sseg_segment_n_a0[leds % 7]);
               
            end
         end
      //_\end_source
   
      // slideswitches
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 454   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 349 as: m4+fpga_switch.
         for (switch = 0; switch <= 7; switch++) begin : L1_Switch //_/switch

            // For $viz_switch.
            logic L1_viz_switch_a0;

            assign L1_viz_switch_a0 = L0_slideswitch_a0[switch];
            
         end
      //_\end_source
   
      // pushbuttons
      
   //_\end_source
   // Label the switch inputs [0..7] (1..8 on the physical switch panel) (top-to-bottom).
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/f4142c041d7a4c4235fcfb2f438038c557f254c5/tlvlib/tinytapeoutlib.tlv 82   // Instantiated from top.tlv, 131 as: m5+tt_input_labels_viz(m5_get(input_labels))
      for (input_label = 0; input_label <= 7; input_label++) begin : L1_InputLabel //_/input_label
         
      end
   //_\end_source

//_\SV
endmodule


// Undefine macros defined by SandPiper.
`undef BOGUS_USE
