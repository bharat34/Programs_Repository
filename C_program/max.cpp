
#include <iostream>
#include <vector>
#include <algorithm>

int solution(std::vector<int> &B);
 
int main()
{
  
  std::vector<int> B(6);
  
  //B[0]=1; B[1]=3; B[2]=-3;
  B[0]=4; B[1]=3; B[2]=2; B[3]=5; B[4]=1; B[5]=1;
  
  std::cout<<solution(B);
  return 0;
} 


int solution(std::vector<int> &B) { 
	
	int size=0;

	int size1=B.size()/2;
	int size2=B.size()/2+1;

	int a = *std::max_element(B.begin(), B.begin()+size1);
	int b = *std::max_element(B.begin()+size1, B.end());

	int c = *std::max_element(B.begin(), B.begin()+size2);
	int d = *std::max_element(B.begin()+size2, B.end());

	int e = abs(a-b);
	int f = abs(c-d);

	if(e>f) { return e; }
	else { return f; }	
 }
