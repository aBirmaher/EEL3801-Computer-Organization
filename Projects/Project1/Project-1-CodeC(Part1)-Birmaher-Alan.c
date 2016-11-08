//Alan Birmaher
//Project 1
//Solve the following equation with no use of multiplication functions and print 
//the output in decimal and binary:
//f= [a+(a*b)+(a*b*c)]
//Also solve the following equation with a quotient and remainder value to print
//in decimal:
//g= [a+(a*b)+(a*b*c)]/max(a, b, c)

//Libraries
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//Max function
int max(int a, int b, int c){
	
	//Variables
	int max=0;
	
	//Return
	return max;
	
}

//Main
int main(int argc, char *argv[]) {
	
	//Instantiating Variables
	int a=0, b=0, c=0, sum=0, quotient=0, remainder=0, temp=0, max=0;
	
	//Prompt user for input
	printf("Enter 3 integers for a, b, c respectively:\n");
	
	//Scan in user values
	scanf("%d %d %d", &a, &b, &c);
	
	//Calculate parts of equation to add for part A
	//Part 1
	sum+= a;
	
	//Part 2
	for(int i=0; i<b; i++){
		sum+= a;	
	}
	
	//Store temp value
	temp=sum;
	
	//Part 3
	for(int i=0;i<c;i++){
		for(int j=0;j<b;j++){
			sum+= a;
		}
	}

	//Print the sum in decimal
	printf("f_ten = %d\nf_two = ", sum);
	
	//Print the sum in binary
	for(int i=31;i>=0;i--){
		putchar('0' + ((sum>>i) & 1));
	}
	
	//Part B
	//Find max value for subtraction
	//If a is greater than b then store a, otherwise b
	if(a>b)
		max=a;
		
	else
		max=b;
		
	//If c is greater than max then replace max value with c
		if(c>max)
			max=c;
	
	//Find quotient
	while(sum>max){
	
		quotient++;
		sum-=max;
		
	}
	
	//Print value in decimal
	printf("\ng_quotient = %d\ng_remainder = %d / %d", quotient, sum, max);
	
	//Return
	return 0;
	
}