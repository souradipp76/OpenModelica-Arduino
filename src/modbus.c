#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include "headers/serial.h"
#include "headers/ieeesingle2num.h"
#include "headers/modbus.h"

char ascii_n(int num)
{
	return (char)num;
}

int ascii_c(char c)
{
	return (int)c;
}

double read_val(int addr_byte)
{	
	int h=open_serial(1,0,9600);
	char array1[20];
	if(addr_byte==86)
    {	
    	char arr[8]={ascii_n(1),ascii_n(3),ascii_n(15),ascii_n(86),ascii_n(00),ascii_n(2),ascii_n(39),ascii_n(15)};
    	int j;
    	for (j = 0; j < 8; ++j)
    	{
    		strcat(array1,arr[j]);
    	}
    	printf("Voltage(in V)=");
	}
    else if(addr_byte==88)
    {	
    	char arr[8]={ascii_n(1),ascii_n(3),ascii_n(15),ascii_n(88),ascii_n(00),ascii_n(2),ascii_n(70),ascii_n(204)};
    	int j;
    	for (j = 0; j < 8; ++j)
    	{
    		strcat(array1,arr[j]);
    	}
    	printf("Current(in A)=");
	}
    else if(addr_byte==78)
    {	
    	char arr[8]={ascii_n(1),ascii_n(3),ascii_n(15),ascii_n(78),ascii_n(00),ascii_n(2),ascii_n(167),ascii_n(8)};
    	int j;
    	for (j = 0; j < 8; ++j)
    	{
    		strcat(array1,arr[j]);
    	}
    	printf("Active Power(in W)=");
	}

	int wr=write_serial(1,array1,8);
	char buf[12];
	int rd=read_serial(1,buf,11);
	int b1=0,b2=0,b3=0,b4=0;
	int myresult[12];
	int i;
	for (i = 0; i < 11; ++i)
	{
		myresult[i]=ascii_c(buf[i]);
	}
	
	int a1=myresult[5];
	if (a1<16)
	{
		b1=1;
	}
	char* v1=dec2hex(a1);
	if (b1)
	{
		strcat("0",v1);
	}

	int a2=myresult[6];
	if (a2<16)
	{
		b2=1;
	}
	char* v2=dec2hex(a2);
	if (b2)
	{
		strcat("0",v2);
	}

	int a3=myresult[7];
	if (a3<16)
	{
		b3=1;
	}
	char* v3=dec2hex(a3);
	if (b3)
	{
		strcat("0",v3);
	}

	int a4=myresult[8];
	if (a4<16)
	{
		b4=1;
	}
	char* v4=dec2hex(a4);
	if (b4)
	{
		strcat("0",v4);
	}
	char* a5[4]={v3,v4,v1,v2};
	char a6[100];
	for (i = 0; i < 4; ++i)
	{
		strcat(a6,a5[i]);	
	}
	int cl=close_serial(1);
	double p=ieeesingle2num(a6);
	printf("%f",p);
	return p;
}

void read_voltage()
{
	int h=open_serial(1,0,9600);
	char acc[10];
    char arr[8]={ascii_n(1),ascii_n(3),ascii_n(15),ascii_n(86),ascii_n(00),ascii_n(2),ascii_n(39),ascii_n(15)};
    int j;
    for (j = 0; j < 8; ++j)
    {
    	strcat(acc,arr[j]);
    }
    //printf("%s\n",acc );
    int wr=write_serial(1,arr,8);
	char buf[12];
	int rd = read_serial(1,buf,11);
	int b1=0,b2=0,b3=0,b4=0;
	int myresult[12];
	int i;
	for (i = 0; i < 11; ++i)
	{
		myresult[i]=ascii_c(buf[i]);
	}
	
	int a1=myresult[5];
	if (a1<16)
	{
		b1=1;
	}
	char* v1=dec2hex(a1);
	if (b1)
	{
		strcat("0",v1);
	}

	int a2=myresult[6];
	if (a2<16)
	{
		b2=1;
	}
	char* v2=dec2hex(a2);
	if (b2)
	{
		strcat("0",v2);
	}

	int a3=myresult[7];
	if (a3<16)
	{
		b3=1;
	}
	char* v3=dec2hex(a3);
	if (b3)
	{
		strcat("0",v3);
	}

	int a4=myresult[8];
	if (a4<16)
	{
		b4=1;
	}
	char* v4=dec2hex(a4);
	if (b4)
	{
		strcat("0",v4);
	}
	char* a5[4]={v3,v4,v1,v2};
	char a6[100];
	for (i = 0; i < 4; ++i)
	{
		strcat(a6,a5[i]);	
	}
	int cl=close_serial(1);
	double p=ieeesingle2num(a6);
	printf("Voltage(in V)=%f",p);
}


void read_current()
{
	int h=open_serial(1,0,9600);
	char acc[100];
    char arr[8]={ascii_n(1),ascii_n(3),ascii_n(15),ascii_n(88),ascii_n(00),ascii_n(2),ascii_n(70),ascii_n(204)};
    int j;
    for (j = 0; j < 8; ++j)
    {
    	strcat(acc,arr[j]);
    }
        //printf("%s\n",acc );
    int wr=write_serial(1,arr,8);
	char buf[12];
	int rd=read_serial(1,buf,11);
	int b1=0,b2=0,b3=0,b4=0;
	int myresult[12];
	int i;
	for (i = 0; i < 11; ++i)
	{
		myresult[i]=ascii_c(buf[i]);
	}

	int a1=myresult[5];
	if (a1<16)
	{
		b1=1;
	}
	char* v1=dec2hex(a1);
	if (b1)
	{
		strcat("0",v1);
	}

	int a2=myresult[6];
	if (a2<16)
	{
		b2=1;
	}
	char* v2=dec2hex(a2);
	if (b2)
	{
		strcat("0",v2);
	}

	int a3=myresult[7];
	if (a3<16)
	{
		b3=1;
	}
	char* v3=dec2hex(a3);
	if (b3)
	{
		strcat("0",v3);
	}

	int a4=myresult[8];
	if (a4<16)
	{
		b4=1;
	}
	char* v4=dec2hex(a4);
	if (b4)
	{
		strcat("0",v4);
	}
	char* a5[4]={v3,v4,v1,v2};
	char a6[100];
	for (i = 0; i < 4; ++i)
	{
		strcat(a6,a5[i]);	
	}
	int cl=close_serial(1);
	double p=ieeesingle2num(a6);
	printf("Current(in A)=%f",p);
}

void read_active_power()
{
	int h=open_serial(1,0,9600);
	char acc[100];
    char arr[8]={ascii_n(1),ascii_n(3),ascii_n(15),ascii_n(78),ascii_n(00),ascii_n(2),ascii_n(167),ascii_n(8)};
    int j;
    for (j = 0; j < 8; ++j)
    {
    	strcat(acc,arr[j]);
    }
        //printf("%s\n",acc );
    int wr=write_serial(1,arr,8);
	char buf[12];
	int rd=read_serial(1,buf,11);
	int b1=0,b2=0,b3=0,b4=0;
	int myresult[12];
	int i;
	for (i = 0; i < 11; ++i)
	{
		myresult[i]=ascii_c(buf[i]);
	}
	
	int a1=myresult[5];
	if (a1<16)
	{
		b1=1;
	}
	char* v1=dec2hex(a1);
	if (b1)
	{
		strcat("0",v1);
	}

	int a2=myresult[6];
	if (a2<16)
	{
		b2=1;
	}
	char* v2=dec2hex(a2);
	if (b2)
	{
		strcat("0",v2);
	}

	int a3=myresult[7];
	if (a3<16)
	{
		b3=1;
	}
	char* v3=dec2hex(a3);
	if (b3)
	{
		strcat("0",v3);
	}

	int a4=myresult[8];
	if (a4<16)
	{
		b4=1;
	}
	char* v4=dec2hex(a4);
	if (b4)
	{
		strcat("0",v4);
	}
	char* a5[4]={v3,v4,v1,v2};
	char a6[100];
	for (i = 0; i < 4; ++i)
	{
		strcat(a6,a5[i]);	
	}
	int cl=close_serial(1);
	double p=ieeesingle2num(a6);
	printf("Active Power(in W)=%f",p);
}
