#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h> /* memset */
#include <stdio.h>
#include "serial.h"
#define MAXPORTS 5
static int fd;

int set_interface_attribs (int fd, int speed, int parity)
{
        struct termios tty;
        memset (&tty, 0, sizeof tty);
        if (tcgetattr (fd, &tty) != 0)
        {
                return -1;
        }
	int posix_baudrate=0;

switch(speed) {
case 115200: posix_baudrate = B115200; break;
//default: return ;
}
        cfsetospeed (&tty, posix_baudrate);
        cfsetispeed (&tty, posix_baudrate);

        tty.c_cflag = (tty.c_cflag & ~CSIZE) | CS8;     // 8-bit chars
        // disable IGNBRK for mismatched speed tests; otherwise receive break
        // as \000 chars
        tty.c_iflag &= ~IGNBRK;         // disable break processing
        tty.c_lflag = 0;                // no signaling chars, no echo,
                                        // no canonical processing
        tty.c_oflag = 0;                // no remapping, no delays
        tty.c_cc[VMIN]  = 0;            // read doesn't block
        tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout

        tty.c_iflag &= ~(IXON | IXOFF | IXANY); // shut off xon/xoff ctrl

        tty.c_cflag |= (CLOCAL | CREAD);// ignore modem controls,
                                        // enable reading
        tty.c_cflag &= ~(PARENB | PARODD);      // shut off parity
        tty.c_cflag |= parity;
        tty.c_cflag &= ~CSTOPB;
        tty.c_cflag &= ~CRTSCTS;

        if (tcsetattr (fd, TCSANOW, &tty) != 0)
        {
                return -1;
        }
        return 0;
}


void set_blocking (int b, int should_block)
{
        struct termios tty;
        memset (&tty, 0, sizeof tty);
        if (tcgetattr (b, &tty) != 0)
        {
                return;
        }

        tty.c_cc[VMIN]  = should_block ? 1 : 0;
        tty.c_cc[VTIME] = 5;            // 0.5 seconds read timeout
}

int open_serial(int handle,int port, int baudrate){
	char *portname;
        int OK;
		switch(port){
		case 0: portname = "//dev/ttyACM0";break;
		case 1: portname = "//dev/ttyACM1";break;
                case 2: portname = "//dev/ttyACM2";break;
                case 3: portname = "//dev/ttyACM3";break;
                case 4: portname = "//dev/ttyACM4";break;
                case 5: portname = "//dev/ttyACM5";break;
                case 6: portname = "//dev/ttyACM6";break;
                case 7: portname = "//dev/ttyACM7";break;
		//default : return;
	}
	OK = 0;
	fd = open (portname, O_RDWR | O_NOCTTY | O_SYNC);
	//fd = open (portname, O_RDWR | O_NOCTTY); //srikant
	if (fd < 0)
	{
		OK=2;
	}
	set_interface_attribs (fd, baudrate, 0);
	set_blocking (fd, 0);                // set no blocking
        printf("Program running with status : %d\n",OK);
        return OK;
}

int close_serial(int handle){
	close(fd);
        printf("Program closing....\n");
	return 0;
}
int write_serial(int handle, char str[],int size){
        printf("serial write started.\n");
	write(fd, str, size);
	usleep(size*100);
	return 0;
}


int status_serial(int handle,int nbread, int nbwrite){
	nbread = 2; 
	nbwrite = 2;
        printf("Getting status.....\n");
	return 0;
}

int read_serial(int handle,char buf[],int size){
	read(fd, buf, size);
        printf("Reading has commenced..\n");
        return 0;
}