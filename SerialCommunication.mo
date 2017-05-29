model SerialCommunication "Serial Communication Model"
  annotation (Documentation(info="<html>
<h4>Description</h4>
<p>
A serial communication model for hardware interfacing.
</p>
</html>"));

import ModelicaReference.Operators ;

  function open_serial
    input Integer handle, port, baudrate;
    output Integer OK;
    external OK=open_serial(handle, port, baudrate) annotation(
      Library = "/home/souradip/OpenModelica/SerialComm.so",
      LibraryDirectory = "/home/souradip/OpenModelica",
      Include = "#include \"/home/souradip/OpenModelica/headers/serial.h\"");
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>open_serial</b>(handle,port,baudrate);
</pre></blockquote>
<h4>Description</h4>
<p>
Establishes a serial communication using port number \"port\".
</p>
</html>"));
  end open_serial;

  function read_serial
    input Integer handle;
    input Integer size;
    output String nbread;
    external nbread=read_serial(handle, size) annotation(
      Library = "/home/souradip/OpenModelica/SerialComm.so",
      LibraryDirectory = "/home/souradip/OpenModelica",
      Include = "#include \"/home/souradip/OpenModelica/headers/serial.h\"");
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>read_serial</b>(handle,buf,size);
</pre></blockquote>
<h4>Description</h4>
<p>
Intiates serial read through the channel specified by \"handle\" and \"buf\".
</p>
</html>"));
  end read_serial;

  function write_serial
    input Integer handle ;
    input String str ;
    input Integer size;
    output Integer w_OK;
  	external w_OK=write_serial(handle,str,size) annotation(Library="/home/souradip/OpenModelica/SerialComm.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  	annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>write_serial</b>(handle,str,size);
</pre></blockquote>
<h4>Description</h4>
<p>
Intiates serial write through the channel specified by \"handle\" and \"buf\".
</p>
</html>"));
  	end write_serial;

  function close_serial
    input Integer handle;
    output Integer c_OK;
  	external c_OK=close_serial(handle) annotation(Library="/home/souradip/OpenModelica/SerialComm.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>close_serial</b>(handle);
</pre></blockquote>
<h4>Description</h4>
<p>
Closes the port for serial communication specified by \"handle\".
</p>
</html>"));
  end close_serial;

  function status_serial
    input Integer handle;
    output Integer stat_OK[3];
  	external stat_OK=status_serial(handle) annotation(Library="/home/souradip/OpenModelica/SerialComm.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  	annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>status_serial</b>(handle,byte_read,byte_write);
</pre></blockquote>
<h4>Description</h4>
<p>
Provides status of serial communication channel specified by \"handle\".
</p>
</html>"));
  	end status_serial;

  function cmd_digital_out
    input Integer h,pin_no,val;
    output Integer digital_w_OK;

    external digital_w_OK=cmd_digital_out(h,pin_no,val) annotation(Library="/home/souradip/OpenModelica/Digital.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  end cmd_digital_out;

  function cmd_digital_in
    input Integer h,pin_no;
    output Integer digital_in;

    external digital_in=cmd_digital_in(h,pin_no) annotation(Library="/home/souradip/OpenModelica/Digital.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  end cmd_digital_in;

  function cmd_analog_in
    input Integer h,pin_no;
    output Real val;
    external val=cmd_analog_in(h,pin_no) annotation(Library="/home/souradip/OpenModelica/Analog.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  end cmd_analog_in;

  function cmd_analog_out
    input Integer h,pin_no;
    input Real val;
    output Integer analog_w_OK;
    external analog_w_OK=cmd_analog_out(h,pin_no,val) annotation(Library="/home/souradip/OpenModelica/Analog.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  end cmd_analog_out;

    Integer OK(fixed = true),handle(fixed =true),port(fixed =true),baudrate(fixed =true),digital_wr(fixed = false),digital_rd(fixed =false),c_OK(fixed =false),w_OK(fixed =false);
    String rd(fixed = false);

  //equation
  algorithm
    handle:=1;
    port:=0;
    baudrate:=9600;
    OK:=open_serial(handle,port,baudrate);
    if(OK == 0) then
      //w_OK:=SerialCommunication.write_serial(1,"v",1);
      //rd:=SerialCommunication.read_serial(1,2);
      digital_rd:=SerialCommunication.cmd_digital_in(handle,12);
      digital_wr:=SerialCommunication.cmd_digital_out(handle,9,1);
      //analog_rd:=SerialCommunication.cmd_analog_in(handle,5);
      //analog_wr:=SerialCommunication.cmd_analog_out(handle,10,128);

    end if;
    c_OK:=close_serial(1);
end SerialCommunication;