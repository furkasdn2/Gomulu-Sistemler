module LED_Controller (
    input wire clk,         // Saat sinyali girişi
    output reg redLED,      // Motor kapalı olduğu zaman verilen sinyal
    output reg blueLED      // Motor açık olduğu zaman verilen sinyal
);

reg [31:0] counter_red;     // Bekleme süresi
reg [31:0] counter_blue;    // Sulama süresi

always @(posedge clk) begin
    if (counter_red == 250000000) begin  // 5 saniye (5 * 50000000 = 250000000)
        counter_red <= 0;
        redLED <= ~redLED;                // Sinyali ters çevirir
        blueLED <= ~blueLED;              // Sinyali ters çevirir
    end else begin
        counter_red <= counter_red + 1;
    end

    if (counter_blue == 300000000) begin  // 6 saniye (6 * 50000000 = 250000000)
        counter_blue <= 0;
        counter_red <= 0;
        blueLED <= ~blueLED;              // Sinyali ters çevirir
        redLED <= ~redLED;                // Sinyali ters çevirir
    end else begin
        counter_blue <= counter_blue + 1;
    end
end

initial begin
    counter_red <= 0;       // Bekleme süresini sıfırla
    counter_blue <= 0;      // Sulama süresini sıfırla
    redLED <= 0;            // Başlangıçta sulama aktif değil
    blueLED <= 1;           // Motorumuz başlangıçta aktif durumda değil
end

endmodule
