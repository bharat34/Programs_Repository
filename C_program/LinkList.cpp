#include <iostream>
using namespace std;

//List nodeclass
class Node {
	public:
		int data;
		Node* next;
};


//Linked list class
class List {
	public:
		List() { head = NULL; }
		~List() {}
		void addNode(int val);
		void reverse();
		void print();
	
	private:
		Node* head;
};

void List::addNode(int val){
	Node* temp=new Node();
	temp->data=val;
	temp->next=NULL;
	
	if (head == NULL) {
		head = temp;
	}
	else {
		Node* temp1= head;
		while(temp1->next != NULL)
			temp1 = temp1->next;
		temp1->next=temp;
	}
}


void List::reverse() {
	Node* n1 = head;
	Node* n2 = NULL;
	Node* n3 = NULL;
	int i=0;	
	while ( n1 != NULL)
	//while ( i !=1 )
	{
		head = n1;
		cout<<"head: "<<head->data<<" n1: "<<n1->data<<endl;
		n2 = n1->next;
		cout<<"n2: "<<n2->data<<endl;
		n1->next = n3;
		n3=n1;
		n1=n2;
		i++;
	}
}
	

void List::print()
{
    Node* temp = head;
    while ( temp != NULL ) {
        cout << temp->data << " ";         
        temp = temp->next;
    }
    cout << endl; 
} 

int main() {
	    List* list = new List();     
    	    list->addNode(100);
    	    list->addNode(200);
    	    list->addNode(300);
    	    list->addNode(400);
    	    list->addNode(500);
	    list->print();
	    list->reverse();
	    list->print();
	    delete list;
	}
