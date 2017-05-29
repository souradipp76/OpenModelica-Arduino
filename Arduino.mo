package Arduino
  extends Modelica.Icons.Package;
  
  package SerialCommunication "Serial Communication Package for Arduino"
    extends Modelica.Icons.Package;
    annotation (Documentation(info="<html>
<h4>Description</h4>
<p>
A serial communication package for hardware interfacing.
</p>
</html>"));
  
  import ModelicaReference.Operators ;
  
  function open_serial "Command to initialize the serial port which is connected to Arduino"
    extends Modelica.Icons.Function;
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
Establishes a serial communication using port number \"port\".To connect to the Arduino board, check the port number from the device manager or check it from the Arduino software.
</p>
</html>"));
  end open_serial;




  
  function read_serial "read characters from serial port"
    extends Modelica.Icons.Function;
    input Integer handle;
    input String buf;
    input Integer size;
    output Integer r_OK;  
    external r_OK=read_serial(handle, buf, size) annotation(
      Library = "/home/souradip/OpenModelica/SerialComm.so",
      LibraryDirectory = "/home/souradip/OpenModelica",
      Include = "#include \"/home/souradip/OpenModelica/headers/serial.h\"");
      annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>read_serial</b>(handle,size);
</pre></blockquote>
<h4>Description</h4>
<p>The translation setting of openserial can come in the way, affecting the number of characters effectively read. If that is the case, omitting the parameter n might be a bad idea, as scilab can hang. This would happen if the input stream contains CR or LF characters which are filtered out: in such cases serialstatus counts them, but readserial does not see them and keeps wating (if the blocking mode of openserial was true) until the total number is received.
</p>
</html>"));
  end read_serial;




  
  function write_serial "write to the serial port"
    extends Modelica.Icons.Function;
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
<p>No end of line character is appended to the string; the user might have to add it if the device being talked to requires it. The Tcl command puts -nonewline is used. In addition, the translation mode of openserial can come into way.
</p>
</html>"));
  end write_serial;


  	
  function close_serial "Command to close the serial port which is connected to Arduino"
    extends Modelica.Icons.Function;
    input Integer handle;
    output Integer c_OK;
    external c_OK=close_serial(handle) annotation(Library="/home/souradip/OpenModelica/SerialComm.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>close_serial</b>(handle);
</pre></blockquote>
<h4>Description</h4>
<p>Closes the port for serial communication specified by \"handle\".It is important to close the serial port after use, else the port would be busy and restart of Scilab might required to connect to it again.
</p>
</html>"));
  end close_serial;





  
  function status_serial "get status of the serial port"
    extends Modelica.Icons.Function;
    input Integer handle;
    output Integer stat_OK[3];
    external stat_OK=status_serial(handle) annotation(Library="/home/souradip/OpenModelica/SerialComm.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
  	annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>status_serial</b>(handle);
</pre></blockquote>
<h4>Description</h4>
<p>Provides status of serial communication channel specified by \"handle\".Get some information about the number of characters present in the input and output buffers of the serial port, and about the status lines (DTS, CTS, ecc.).The translation setting of openserial can come in the way. If the input stream contains CR or LF characters which are filtered out, openserial counts them but readserial does not see them.
</p>
</html>"));
  end status_serial;






  	
  function cmd_digital_out
    extends Modelica.Icons.Function;
    input Integer h,pin_no,val;
    output Integer digital_w_OK;    
    external digital_w_OK=cmd_digital_out(h,pin_no,val) annotation(Library="/home/souradip/OpenModelica/Digital.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>cmd_digital_in</b>(h,pin_no);
</pre></blockquote>
<h4>Description</h4>
<p>The Arduino board has a set of logical ports (digital) that are used for writing or reading data from a component.
To map a UNO, ports 2-13 are available (0 and 1 are used for serial transmission). For MEGA board, ports 2-53 are available. The port takes the low logic level (0) or logic high (1) which corresponds to the reference voltage.
</p>
</html>"));
  end cmd_digital_out;



  
  function cmd_digital_in "Command to read in digital signal from a connected Arduino board"
  extends Modelica.Icons.Function;
    input Integer h,pin_no;
    output Integer digital_in;    
    external digital_in=cmd_digital_in(h,pin_no) annotation(Library="/home/souradip/OpenModelica/Digital.so", LibraryDirectory="/home/souradip/OpenModelica", Include="#include \"/home/souradip/OpenModelica/headers/serial.h\"");
    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
SerialCommunication.<b>cmd_digital_in</b>(h,pin_no);
</pre></blockquote>
<h4>Description</h4>
<p>The Arduino board has a set of logical ports (digital) that are used for writing or reading data from a component.
To map a UNO, ports 2-13 are available (0 and 1 are used for serial transmission). For MEGA board, ports 2-53 are available. The port takes the low logic level (0) or logic high (1) which corresponds to the reference voltage.
</p>
</html>"));
  end cmd_digital_in;

       
  end SerialCommunication;  
end Arduino;
