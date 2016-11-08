#include <stdio.h>
#include <stdlib.h>

//QuadBitFloor function
void QuadBitFloor(int num1, int num2){
	
	//Variables
	char numberX[32];
	char numberY[32];
	int n=0, i=0, k=0;
	int t4=4, t5=16, t6=16;
	int flag=0;
	int a0, a1;
	
	//Store value for numberX in binary
	for (i = 31; i >= 0; i--){

		//Store into k
	    k = num1 >> i;
		 
		//Decide which number this value is
	    if (k & 1)
	      numberX[i]='1';
	    else
	      numberY[i]='0';
	
	}
	
	//Reset values
	k=0;
	
	//Store value for numberX in binary
	for (i = 31; i >= 0; i--){

		//Store into k	
	    k = num2 >> i;
			 
		//Decide which number this value is
	    if (k & 1)
	      numberY[i]='1';
	    else
	      numberY[i]='0';
		
	}
	
	//Calculation
	while (!flag){
		a0=num1/16;
		t5=num1%16;
		a1=num2/16;
		t6=num2%16;
		
		if(t5<t6){
			
			//Shift
			t1=t0*t4;
			t5<<t1;
			t2+=t5
			
		}
		
		//Shift
		t1=t0*t4;
		t5<<t1;
		t2+=t5
		
		//Reset Values
		t5=16;
		t6=16;
		t0++;
		
		//Sets flag to breakout if needed
		if(t0==8)
			flag=1;
		
	}
	
	//Print
	printf("QuadBitFloor= %d\n", a0);
}

//QuadBitFloor function
void PackedDigitCipher(int num1, int num2){
	
	//Variables
	char numberX[32];
	char numberY[32];
	int n=0, i=0, k=0;
	int t0=0, t1, a2;
	char arrayA[];
		
	//Store value for numberX in binary
	for (i = 31; i >= 0; i--){

		//Store into k
	    k = num1 >> i;
			 
		//Decide which number this value is
	    if (k & 1)
	      numberX[i]='1';
		    else
	      numberY[i]='0';
		
	}
		
	//Reset values
	k=0;
	flag=0;
		
	//Store value for numberX in binary
	for (i = 31; i >= 0; i--){

		//Store into k	
	    k = num2 >> i;
			 
		//Decide which number this value is
	    if (k & 1)
	      numberY[i]='1';
	    else
	      numberY[i]='0';
			
	}
		
	//Calculation
	t1=a2;
	t5=15;
	
	while (!flag){

		//Set values
		t1=a2/16;
		t6+=t3;
		
		//Move location
		t3=numberX[t6];
		
		//Change value and store
		numberX[t6]=t3++;
		
		//Counter increments
		t0++;
		
		//Sets flag to breakout if needed
		if(t0==8)
			flag=1;
	}
	
	//Print
	printf("PackageDigitCipher= ");
	
	//Set values
	t0=0;
	t6+=16;
	flag=0;
	
	while (!flag){

		//Move location
		a0=numberX[t6];
			
		//Change value and store
		printf("%d", a0);
			
		//Move byte location
		t6--;
			
		//Counter increments
		t0++;
		
		//Sets flag to breakout if needed
		if(t0==8)
			flag=1;
	}
	
}

//Main 
int main() {
	
	//Variables
	int x, y, resultQBF, resultPDC;
	
	//Take user input for x
	printf("%s", "X: ");
	scanf("%d", &x);

	//Take user input for y
	printf("%s", "Y: ");
	scanf("%d", &y);
	
	//Calls functions on values and returns results
	QuadBitFloor(x,y);
	PackedDigitCipher(x,y);
	
	//Return
	return 0;
	
}