module fifo_tb;
  fifo_transaction f;

  initial begin
    f = new();
    for(int i = 0; i < 10; i++) begin
      f.randomize();
      f.display();
    end
    $finish;
  end
endmodule
