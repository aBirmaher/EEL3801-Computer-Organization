// Alan Birmaher
// Project 2, C prototype code
// EEL3801C
// 10/22/14
// Part A:Read in string of words ending in a period.
// For any word with a valid Hex value replace it with
// the decimal representation of that hex value and print.
// Part B: Determine and print the string's String Digit
// Score. This is determined by the table provided in 
// seciton 1.0) Project Description above.

//Imports
#include <stdio.h>

//Main
int main(int argc, char *argv[]) {
	
	//Setup Variables
	int temp=0, i=0, max=0xFFFFFFF, strength=0, start, end, hexWord;
	char toProcess[101];
	
	//Read in string to process
	while(i < 100){
	
		//Scan in character by character
		scanf("%c", &toProcess[i]);
		
		//If end of line
		if(toProcess[i] == 10){
		
			//Sets the next value to 0 to show its over
			toProcess[i+1]= 0;
			
			//String is over so we break out of the loop
			break;
		
		}
		
		//Increment counter
		i+=1;
	
	}
	
	//Reset i value
	i=0;

	//While the value if not a period indicating the string is over
	while(toProcess[i] != 46){
		
		//If there is a space
		if(toProcess[i] == 32){
		
			//Prints the value of the char at that location
			printf("%c", toProcess[i]);
			
			//Incremement Counter
			i++;
		
		}
		
		//Set start and end values
		start= i;
		end= i;
		
		//Reset hexWord value to zero
		hexWord=0;
		
		//While the value at i is not a space or a period
		while(toProcess[i]!=32 && toProcess[i] != 46){
		
			//
			if(!((toProcess[i] >= 48 && toProcess[i] <= 57) || (toProcess[i] >= 65 && toProcess[i] <= 70))){
			
				////Set hexWorld flag value to 1
				hexWord=1;
			
			}
		
			//Incrememnt counter
			i++;
			
			//Incrememnt end
			end++;
		
		
		}
		
		//If the flag for hexWord has been triggered
		if(hexWord==1){
		
			//While start value is less than end value
			while(start<end){
			
				//Print out the characters
				printf("%c", toProcess[start]);
				
				//Increment start count
				start++;
			
			}
		
		}
		
		// If flag was not set
		if(hexWord==0){
		
			//Reset temp value
			temp=0;
			
			//While start is less than end
			while(start<end){
			
				//Fix temp value
				temp= temp<<4;
				
				// If falls into the first category, set value
				if(toProcess[start] >= 65 && toProcess[start] <= 70)
					temp= temp + toProcess[start] - 55;
				
				// If falls into the second category, set value
				if(toProcess[start] >= 48 && toProcess[start] <= 57)
					temp= temp + toProcess[start] - 48;
				
				// If falls into the third category, set value
				if(temp > strength)
					strength= temp;
			
				//Incrememnt start count	
				start++;
			
			}
			
			//Print temp value
			printf("%d", temp);
		
		}
			
	}
	
	//Prints values
	printf("%c\n", toProcess[i]);
	
	//If the value is sparse, print
	if(strength >= 0x00 && strength <= 0xFF)
		printf("Sparse\n");
	
	//If the value is Intermediate, print
	if(strength>= 0x100 && strength <= 0xFFFF)
		printf("Intermediate\n");
		
	//If the value is plentiful, print
	if(strength >= 0x10000 && strength <= 0xFFFFFFF)
		printf("Plentiful\n");
		
	//Return
	return 0;
	
}