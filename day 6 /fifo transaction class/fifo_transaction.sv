class fifo_transaction;
  rand bit rst_n;
  rand bit wr_en;
  rand bit rd_en;
  rand bit [7:0] data_in;
  bit [7:0] data_out;
  bit full, empty;

  constraint c_rst {
    rst_n dist {0:=2, 1:=8};
  }

  constraint c_wr_rd {
    wr_en dist {0:=3, 1:=7};
    rd_en dist {0:=7, 1:=3};
  }

  constraint c_data {
    data_in dist {[1:10]:/10, [11:255]:/90};
  }

  function void display();
    $display("rst_n=%0b wr_en=%0b rd_en=%0b data_in=%0d data_out=%0d full=%0b empty=%0b",
              rst_n, wr_en, rd_en, data_in, data_out, full, empty);
  endfunction
endclass
