model test_firmware

import sComm=Arduino.SerialCommunication.Functions;
Integer h(fixed = false);
//Integer byte_read(fixed = false);
//String str(fixed =false);
//Integer wr(fixed =false);
Integer c_OK(fixed =false);
Integer a_in(fixed =false);
//Integer d_wr(fixed =false);
//Integer d_rd(fixed =false);
algorithm
  h:=sComm.open_serial(1,0,115200);
  //wr:=sComm.write_serial(1,"v",1);
  //byte_read:= sComm.read_serial(1,2);
  //d_wr:=sComm.cmd_digital_out(1,9,0);
  //d_rd:=sComm.cmd_digital_in(1,12);
  //d_wr:=sComm.cmd_digital_out(1,9,0);
  //sComm.delay(1000);
  a_in:=sComm.cmd_analog_in(1,2);
  Modelica.Utilities.Streams.print(String(a_in));
  //Modelica.Utilities.Streams.print("time:"+String(time));
  when time == 10 then 
    c_OK := sComm.close_serial(1) "To close the connection safely";
  end when;
  annotation(
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 10));

end test_firmware;