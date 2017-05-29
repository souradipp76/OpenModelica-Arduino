#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h> /* memset */
#include <stdio.h>
#include <stdlib.h>
#include "headers/serial.h"
#include "headers/digitaloutput.h"

int cmd_digital_out(int h,int pin_no,int val)
{
	int wr=2;
	char pin[5]="Da";
    char v[2],temp[2];
	sprintf(temp,"%d",pin_no);
	strcat(pin,temp);
	strcat(pin,"1");
    //printf("%s",pin);
  	wr=write_serial(h,pin,4);
  	if (val > 0.5)
    	val = 1;
  	else
    	val = 0;

	sprintf(v,"%d",val);
  	strcpy(pin,"Dw");
    strcat(pin,temp);
	strcat(pin,v);
    //printf("%s",pin);
  	wr=write_serial(h,pin,4);
    return wr;
}

int cmd_digital_in(int h,int pin_no)
{
    char pin[5]="Da";
    char v1[2],v2[2];
    int wr1, wr2;
    sprintf(v1,"%d",(pin_no));
    strcat(pin,v1);
    strcat(pin,"0");
    //printf("%s\n",pin);
    wr1=write_serial(h,pin,4);

    strcpy(pin,"Dr");
    sprintf(v2,"%d",(pin_no));
    strcat(pin,v2);
    wr2=write_serial(1,pin,3);
    //binary transfer
    int* stat;
    stat=status_serial(h);
    while(stat[1]<1)
        stat=status_serial(h);
    char* temp;
    return strtol(read_serial(h,1),&temp,10);
}