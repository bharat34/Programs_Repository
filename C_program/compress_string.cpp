#include <iostream>
using namespace std;


int main() {
	
 	char input[] = "aaabbcccddeeee";
	char empty=input[0];
	int counter=1;
	cout<<input<<endl;
	cout<<empty;
		
	for(int i=1; i<sizeof(input)-1; i++){

		if(input[i]!=empty) {
				cout<<counter;
				counter=0;
				empty=input[i];
				cout<<empty;
				counter++;
				}
		else {
			counter++;
			}

					}
	cout<<counter;
	return 0;

	}
