#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h> /* memset */
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include "headers/serial.h"
#include "headers/analog.h"

/*double cmd_analog_in(int h,int pin_no)
{	
	char pin[3],v1[2];
	int wr;
	int* stat;
	sprintf(v1,"%d",pin_no);
	strcpy(pin,"A");
	strcat(pin,v1);
    wr=write_serial(h,pin,2);
    stat=status_serial(h);
    while (stat[1] < 2)
    	stat=status_serial(h);
    char* values=read_serial(h,2);

    int l=strlen(values);
    int temp[l+1];
    int i;
    for (i = 0; i < l; ++i)
    {
    	temp[i]=(int)values[i];
    }
    return (double)(256*temp[1]+temp[0]);
}*/

int cmd_analog_out(int h,int pin_no,double val)
{
	char v1[2],v2[2];
	if(val > 255)
    	val = 255;
    else if(val < 0)
        val = 0;
    char code_sent[10];
    strcpy(code_sent,"W");
    sprintf(v1,"%c",pin_no+48);
    sprintf(v2,"%d",abs(ceil(val)));
    strcat(code_sent,v1);
    strcat(code_sent,v2);
    return write_serial(h,code_sent,3);

}