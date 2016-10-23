
#include <iostream>
#include <vector>
#include <algorithm>

int solution(std::vector<int> &A, std::vector<int> &B);
 
int main()
{
  
  std::vector<int> A(2);
  std::vector<int> B(2);
  
  A[0]=1; A[1]=3; A[2]=2; A[3]=1;
  B[0]=4; B[1]=2; B[2]=5; B[3]=3; B[4]=2;
  
   // A[0]=2; A[1]=1;
   // B[0]=3; B[1]=3;
  std::cout<<solution(A,B);
  return 0;
} 


int solution(std::vector<int> &A, std::vector<int> &B) { 
	
	int size=0;

	std::vector<int> v(A.size()+B.size());
  	std::vector<int>::iterator it;

	std::sort(A.begin(), A.end());
	std::sort(B.begin(), B.end());

	it=std::set_intersection (A.begin(), A.end(), B.begin(), B.end(), v.begin());

	v.resize(it-v.begin());

	if(v.size()>0) { return v[0]; }
	else { return -1; }
 }
