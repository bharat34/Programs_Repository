#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <assert.h>
#include <mpi.h>

#define WORKTAG 1
#define RESULTTAG 2
#define DIETAG 3
#define MAX_LEN 50
#define MIN_LEN 20



void master();
void slave(int rank);


using namespace std;

int main(int argc,char **argv){
        MPI::Init(argc, argv);

 	int myRank=MPI::COMM_WORLD.Get_rank();
	

        time_t t1, t2;

        time(&t1);

        if(!myRank) master();
        else slave(myRank);

        time(&t2);
        if(!myRank) cout<<"Time taken in Patching: "<<difftime(t2,t1)<<endl;

        MPI::Finalize();
        return 0;
                                }


void master(){


	int nTasks=MPI::COMM_WORLD.Get_size();
        MPI::Status status;
        MPI::Request req;

	
	FILE *f1,*f2;
	int  i=0;

	char input[MAX_LEN],store[MIN_LEN];
 
	f1=fopen("output","r"); assert(f1!=NULL);
	while(fgets(store,20,f1)!=NULL) i++;
        rewind(f1);
	
	typedef struct {
        	        char name[100];
              	 	}TEMPLATE;

	TEMPLATE *PDB = new TEMPLATE[i];

	i=0; 
	while(fgets(store,100,f1)!=NULL) { sscanf(store,"%s",store); strcpy(PDB[i].name,store); i++; }
	fclose(f1);
	
	int mynode=1;
	int getresult_mynode=1;
	int length;
	
	f2=fopen("directoryN","w");
	for(unsigned j=0; j < i; j++) {

				
				length = strlen(PDB[j].name);
				input[length]='\0';

	if(mynode != nTasks) {  
                        	req = MPI::COMM_WORLD.Isend(&length, 1, MPI::INT, mynode, WORKTAG); req.Wait(status);
				req = MPI::COMM_WORLD.Isend(&PDB[j].name, length, MPI::CHAR, mynode,WORKTAG); req.Wait(status);  
				mynode++; 
				getresult_mynode++; 
			     }
	else {
                 		int recvlentgh;
                 		MPI::COMM_WORLD.Recv(&recvlentgh, 1, MPI::INT, MPI::ANY_SOURCE, RESULTTAG, status);
                 		MPI::COMM_WORLD.Send(&length, 1, MPI::INT, status.Get_source(), WORKTAG);
				MPI::COMM_WORLD.Send(&PDB[j].name, length, MPI::CHAR, status.Get_source(), WORKTAG);
				getresult_mynode++;
	     }
				     }

	while(mynode != nTasks) {
                        	  	MPI::COMM_WORLD.Send(&length, 1, MPI::INT, mynode, DIETAG);
					MPI::COMM_WORLD.Send(&input, length, MPI::CHAR, mynode, DIETAG);
					mynode++;
				}
					 
	fclose(f2);
	
	if(getresult_mynode > nTasks) getresult_mynode = nTasks;
	mynode=1;
	while( mynode != getresult_mynode) {
			int recvlentgh=0;		
                        //MPI Communication
			MPI::COMM_WORLD.Recv(&recvlentgh, 1, MPI::INT, MPI::ANY_SOURCE, RESULTTAG, status);
			MPI::COMM_WORLD.Send(&length, 1, MPI::INT, status.Get_source(), DIETAG);
                        MPI::COMM_WORLD.Send(&input, length, MPI::CHAR, status.Get_source(), DIETAG);
                        mynode++;
                                  }
	cout<<"Master Node Completed:	"<<endl;	
}

void slave(int myRank) {
		
		MPI::Request reqRecv;
	        MPI::Request reqSend;
        	MPI::Status status;
		char excecute[200];
		char Penalty[200];
		excecute[0]='\0';
		int length = 0;

		int processed_str=0;

        	int nTasks=MPI::COMM_WORLD.Get_size();


                while(true){

		reqRecv = MPI::COMM_WORLD.Irecv(&length, 1, MPI::INT, 0, MPI::ANY_TAG);
                reqRecv.Wait(status);
		
		char input[length];
		input[length] = '\0';

		reqRecv = MPI::COMM_WORLD.Irecv(&input,length, MPI::CHAR, 0, MPI::ANY_TAG);
                reqRecv.Wait(status);
		

		if(status.Get_tag()==DIETAG){
				  cout<<"Structures processed by "<<myRank<<"th slave are: "<<processed_str<<endl;
                                  break;
                                            }
		sprintf(excecute,"/opt/Bio/stride/exe/stride -o %s | egrep \"^LOC\" | egrep -i \"Alpha|Stra\"  | awk '{print $2,$4,$7}' > ssInfo%s >& /dev/null", input, input);
		system (excecute);

 		//cout<<excecute<<endl;
		++processed_str;

		reqSend=MPI::COMM_WORLD.Isend(&length, 1, MPI::INT, 0, RESULTTAG);
                reqSend.Wait(status);
                            }
}

lena
dang
na
vietnam
middletwon
~
