#include <iostream>
using namespace std;

class Circle{
	double radius;
	public:
	Circle(double r) { radius = r;}
	double circum() { return 2*radius*3.14; }
	}; 

class Rectangle{
	public:
		double width, height;
		Rectangle() {};
		Rectangle(int , int );
		int Area() { return width*height; }
		Rectangle operator+ (const Rectangle&);
		bool operator==(const Rectangle&);
		};	


Rectangle::Rectangle(int a, int b){
		width=a;
		height=b;
				}

Rectangle Rectangle::operator+ (const Rectangle& parm){
		Rectangle temp;
		temp.width=this->width+parm.width;
		temp.height=this->height+parm.height;
		return temp;
				}
bool Rectangle::operator==(const Rectangle& parm){
		if(this->width==parm.width and this->height==parm.height) {
				return true;
					}
		else { 
			return false;
			}
		}

int main(){
	Circle foo (10.0);   
	Circle bar = 20.0;	

	cout << "foo's circumference: " << foo.circum() << '\n';
	
	Rectangle empty;
	Rectangle rect(1,4);
	Rectangle *foo1, *bar1, *baz1;
	foo1=&rect;
	
	bar1 = new Rectangle (5, 6);
  	baz1 = new Rectangle[2] { {2,5}, {3,6} };	
	
	empty =   bar1[0] +  baz1[0];
  	cout << "rect area: " << rect.Area() << endl;
  	cout << "foo1 area: " << foo1->Area() << endl;

  	cout << "bar1 area: " << bar1->Area() << endl;
 	cout << "baz1 area: " << baz1[0].Area() << endl;
 	cout << "baz1 area: " << baz1[1].Area() << endl;
 	cout << "empty area: " << empty.Area() << endl;

	if(bar1[0]==baz1[0]) {
				cout<<"bar1[0] is equal to baz1[0] True"<<endl;
				}	
	else{
				cout<<"bar1[0] is not equal to baz1[0] True"<<endl;
		}
	return 0;
	}
