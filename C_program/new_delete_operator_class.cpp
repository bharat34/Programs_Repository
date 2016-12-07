#include <iostream>
using namespace std;

class MyClass {
	public:
		MyClass() { cout<<" In constructor"<<endl; }
		~MyClass() { cout<<"In Destructor"<<endl;}
};

#include <iostream>
using namespace std;

class MyCLass {
    public:

    // Overloaded new
    void* operator new (size_t sz) {
		
		cout << "Object Created" << endl;
		// Invoke the default new operator
		return ::new MyCLass();
				    }
    
    // Overloaded delete
    void operator delete(void* ptr) {
		
		cout << "Object Destroyed" << endl;
		// Invoke the default delete operator
		::delete ptr;
					}
	};
	
class Rect{
	
	public:
		int a,b;
		Rect() { };
		Rect(int c,int d) { a=c; b=d; }
		Rect operator+(const Rect&);
		~Rect() { cout<<"In Destructor"<<endl;}
	};

Rect Rect::operator+(const Rect& rect2){
		Rect temp2;
		temp2.a=this->a+rect2.a;
		temp2.b=this->b+rect2.b;
		return temp2;
				}
   
int main() {
	MyClass obj;
	MyClass* obj1 = new MyClass;
	delete obj1;
	
	int* pointer=new int[10];
	delete[] pointer;

	MyCLass* obbj = new MyCLass();
   	delete obbj;
	
	Rect rect1(4,5);
	Rect rect2(40,50);
	Rect rect3=rect1+rect2;


	cout<<rect3.a<<" "<<rect3.b<<endl;

	return 0;
	   }
