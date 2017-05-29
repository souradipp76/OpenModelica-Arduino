model test_firmware

import sComm=SerialCommunication;
Integer h(fixed = false), wr(fixed = true),c_ok(fixed = false);
//String byte_read(fixed = false);
algorithm
  h:=sComm.open_serial(1,0,115200);
  for i in 1:3 loop
    wr:=sComm.write_serial(1,"v",1);
    //byte_read:=sComm.read_serial(1,2);
  end for;
  c_ok:=sComm.close_serial(1);
end test_firmware;