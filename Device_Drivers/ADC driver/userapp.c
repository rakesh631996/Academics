#include<stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<linux/ioctl.h>


#define MAGIC_NUMBER 'A'
#define CHANNEL_SELECT_SRLNO 0x01
#define RESULT_ALIGNMENT_SRLNO 0x02

#define CHANNEL_SELECT _IOW(MAGIC_NUMBER, CHANNEL_SELECT_SRLNO, unsigned long)
#define RESULT_ALIGNMENT _IOW(MAGIC_NUMBER, RESULT_ALIGNMENT_SRLNO, unsigned long)


unsigned int channel;
unsigned int align;
unsigned int result;

int main(int arg,char *files[])
{
	int devicefile, userfile;
	if(arg != 2)
	{
		printf("Usage : copy <oldfile> <newfile>\n");
		exit(1);
	}

	devicefile = open(files[1], O_RDONLY);

	if(devicefile == -1)
	{
		printf("cannot open source file\n");
		exit(1);
	}

	printf("Enter a Channel number of ADC(0-7) : \n");
        scanf("%d",&channel);       
        ioctl(devicefile, CHANNEL_SELECT, &channel); 
 
        printf("Enter the Required Allignment(0/1) : \n");
	scanf("%d",&align); 
        ioctl(devicefile, RESULT_ALIGNMENT, &align);
       
 
        printf("value of ADC is...\n");
	read(devicefile, &result, 2);
	printf("Value read from ADC - %d \n", result);
        close(devicefile);
	exit(0);
}

