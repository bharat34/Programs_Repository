#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <math.h>
#include <assert.h>
#include <mpi.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <list>
#include <set>
#include<sys/stat.h>


#define WORKTAG 1
#define RESULTTAG 2
#define DIETAG 3
#define MAX_LEN 100
#define MIN_LEN 20


typedef struct {
	float *x;
	float *y;
	float *z;
}StoreCoordlist;

void master(char *,int noOfCa);
void slave(int rank,char *,int noOfCa);
char filename[MIN_LEN];
int jobinput_size=0;
int noOfTimeSeries=0;
using namespace std;


int main(int argc,char **argv){
        MPI::Init(argc, argv);

        int myRank=MPI::COMM_WORLD.Get_rank();

        time_t t1, t2;

        time(&t1);

	char jobID[MIN_LEN];
	strcpy(jobID,argv[1]);
	int noOfCa=atoi(argv[2]);

        if(!myRank) master(jobID,noOfCa);
        else slave(myRank,jobID,noOfCa);

        time(&t2);
	
	if(!myRank) cout<<"Time taken in clustalw2: "<<difftime(t2,t1)<<endl;

        MPI::Finalize();
        return 0;
		 			}

void master(char *filename,int noOfCa){

	int nTasks=MPI::COMM_WORLD.Get_size();
        MPI::Status status;
        MPI::Request req;

/*
	list<StoreCoordlist> Coordlist;

	FILE *rfp;
	rfp = fopen(filename,"r");	
	char line[200];

	if (rfp == NULL) {
		printf("Cannot open specified file in 'getPdbSize' function\n");
		exit(1);
			 }
	
	char type[50];	
	char data[50];	
	int precedingCount_Area=0;
	FILE *lfp;
	float x,y,z;

        while(fgets(line,120,rfp) != NULL) {
                noOfTimeSeries++;
                sscanf(line,"%s",type);
                lfp = fopen(type,"r");
                if (lfp == NULL)  { printf("Please check the %s File\n",type); exit(-1); }
                StoreCoordlist Coord;
                Coord.x=new float[noOfCa];
                Coord.y=new float[noOfCa];
                Coord.z=new float[noOfCa];
	int count=0;
	while(fgets(line,120,lfp) != NULL) {
			sscanf(line,"%s",data);
				if (strcmp(data,"ATOM" ) == 0) {
					sscanf(line, "%*s %*d %s %*s %*d %*f %*f %*f",  data);
						if(strcmp(data,"CA")==0) {
							sscanf(line, "%*s %*d %*s %*s %*d %f %f %f",  &x,&y,&z);
							Coord.x[count]=x;
							Coord.y[count]=y;
							Coord.z[count]=z;
							count++; 		 
									 }
								}
						   }
		fclose(lfp);
		Coordlist.push_back(Coord);
						}
	fclose(rfp);
*/	
	int mynode=1;
	bool firstIteration=true;
			int *sendpos=new int[2];
			double *RecRstpos=new double[3];

	double covar[noOfCa][noOfCa];

	for (int i = 0; i < noOfCa; i++) {
		for (int j = 0; j < noOfCa; j++) { 
			sendpos[0]=i;
			sendpos[1]=j;
			
			if(mynode != nTasks) {
                        req = MPI::COMM_WORLD.Isend(sendpos, 2, MPI::INT, mynode, WORKTAG); req.Wait(status);
			mynode++;
					     }
			else {
			MPI::COMM_WORLD.Recv(RecRstpos,3, MPI::DOUBLE, MPI::ANY_SOURCE, RESULTTAG, status);
			int index1=int(RecRstpos[0]);
			int index2=int(RecRstpos[1]);
			covar[index1][index2]=RecRstpos[2];
			MPI::COMM_WORLD.Send(sendpos, 2, MPI::INT, status.Get_source(), WORKTAG);
			
                             }
						}
					}
	mynode=1;
	for (mynode=1; mynode<nTasks; mynode++){
		MPI::COMM_WORLD.Recv(RecRstpos,3, MPI::DOUBLE, MPI::ANY_SOURCE, RESULTTAG, status);
		int index1=int(RecRstpos[0]);
		int index2=int(RecRstpos[1]);
		covar[index1][index2]=RecRstpos[2];
		//covar[RecRstpos[0]][RecRstpos[1]]=RecRstpos[2];
		MPI::COMM_WORLD.Send(sendpos, 2, MPI::INT, status.Get_source(), DIETAG);
			}
	for (int i = 0; i < noOfCa; i++) {
		for (int j = 0; j < noOfCa; j++) { 
					cout<<covar[i][j]<<" ";
						 }
					cout<<endl;
					}
/*	it1=Coordlist.begin();
        while(it1!=Coordlist.end()){
                delete[] it1->x;
                delete[] it1->y;
                delete[] it1->z;
                ++it1;
        			   }*/
}
				

void slave(int myRank,char *filename,int noOfCa) {

	MPI::Request reqRecv;
        MPI::Request reqSend;
 	MPI::Status status;
	list<StoreCoordlist> Coordlist;
	list<StoreCoordlist>::iterator it1=Coordlist.begin();
	list<StoreCoordlist>::iterator it2=Coordlist.begin();

	FILE *rfp;
	rfp = fopen(filename,"r");	
	char line[200];

	if (rfp == NULL) {
		printf("Cannot open specified file in 'getPdbSize' function\n");
		exit(1);
			 }
	
	char type[50];	
	char data[50];	
	int precedingCount_Area=0;
	FILE *lfp;
	float x,y,z;

        while(fgets(line,120,rfp) != NULL) {
                noOfTimeSeries++;
                sscanf(line,"%s",type);
                lfp = fopen(type,"r");
                if (lfp == NULL)  { printf("Please check the %s File\n",type); exit(-1); }
                StoreCoordlist Coord;
                Coord.x=new float[noOfCa];
                Coord.y=new float[noOfCa];
                Coord.z=new float[noOfCa];
	int count=0;
	while(fgets(line,120,lfp) != NULL) {
			sscanf(line,"%s",data);
				if (strcmp(data,"ATOM" ) == 0) {
					sscanf(line, "%*s %*d %s %*s %*d %*f %*f %*f",  data);
						if(strcmp(data,"CA")==0) {
							sscanf(line, "%*s %*d %*s %*s %*d %f %f %f",  &x,&y,&z);
							Coord.x[count]=x;
							Coord.y[count]=y;
							Coord.z[count]=z;
							count++; 		 
									 }
								}
						   }
		fclose(lfp);
		Coordlist.push_back(Coord);
						}
	fclose(rfp);
	
	double *SendRstpos=new double[3];
	int *Recvpos=new int[2];
	int iterationCount=0;


	while(true){
		reqRecv=MPI::COMM_WORLD.Irecv(Recvpos, 2, MPI::INT, 0, MPI::ANY_TAG);
		reqRecv.Wait(status);
		if(status.Get_tag()==DIETAG){
			break;
		
					    }
	 		it1=Coordlist.begin();
	 		it2=Coordlist.begin();
			int i=Recvpos[0];
			int j=Recvpos[1];
		
			float S2A=0.0;
			float S2B=0.0;
					
			float S1[3];
			float S2[3];
			float S3[3];
			float BDCV[3];
			for (int u=0; u<3; u++) BDCV[u]=0.0;
			for (int y=0; y <3; y++) S1[y]=0.0; 
			for (int y=0; y <3; y++) S2[y]=0.0; 
			for (int y=0; y <3; y++) S3[y]=0.0; 

			//for (int k = 0; k < noOfTimeSeries; k++) {
			for (int k = 0; k < 5; k++) {
				it1 = Coordlist.begin();
				advance (it1,k);
				float AXJ = it1->x[i];
				float AYJ = it1->y[i];
				float AZJ = it1->z[i];

				float BXJ = it1->x[j];
				float BYJ = it1->y[j];
				float BZJ = it1->z[j];
				float DBS=0.0;
				float DAS=0.0;

					//for (int l = 0; l < noOfTimeSeries; l++) {
					for (int l = 0; l < 5; l++) {
						it2 = Coordlist.begin();
						advance (it2,l);
						float AXK = it2->x[i];
						float AYK = it2->y[i];
						float AZK = it2->z[i];

						float BXK = it2->x[j];
						float BYK = it2->y[j];
						float BZK = it2->z[j];

						float ADX = AXJ - AXK;
						float ADY = AYJ - AYK;
						float ADZ = AZJ - AZK;
						float BDX = BXJ - BXK;
						float BDY = BYJ - BYK;
						float BDZ = BZJ - BZK;
					
						float DAK = sqrt(ADX*ADX+ADY*ADY+ADZ*ADZ);
						float DBK = sqrt(BDX*BDX+BDY*BDY+BDZ*BDZ);
					
						S1[0] = S1[0] + DAK * DAK;
						S1[1] = S1[1] + DBK * DBK;
						S1[2] = S1[2] + DAK * DBK;
						S2A = S2A + DAK;
						S2B = S2B + DBK;
						DAS = DAS + DAK;
						DBS = DBS + DBK;
								 	 	}
						S3[0]=S3[0]+DAS*DAS;
						S3[1]=S3[1]+DBS*DBS;
						S3[2]=S3[2]+DAS*DBS;
						 		 }
						S1[0]=S1[0]/noOfTimeSeries/noOfTimeSeries;
						S1[1]=S1[1]/noOfTimeSeries/noOfTimeSeries;
						S1[2]=S1[2]/noOfTimeSeries/noOfTimeSeries;

						S2[0]=(S2A*S2A)/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S2[1]=(S2B*S2B)/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S2[2]=(S2A*S2B)/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
					
					
						S3[0]=S3[0]/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S3[1]=S3[1]/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S3[2]=S3[2]/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
							for (int u=0; u<3; u++) { 
								BDCV[u]=sqrt(S1[u]+S2[u]-2.0*S3[u]);
										}
						double covar=(BDCV[2]/sqrt(BDCV[0]*BDCV[1]));
	
		SendRstpos[0]=i; SendRstpos[1]=j; SendRstpos[2]=covar;
		reqSend=MPI::COMM_WORLD.Isend(SendRstpos, 3, MPI::DOUBLE, 0, RESULTTAG);
		reqSend.Wait(status);

		++iterationCount;
	}


	//cout<<"Structures processed by "<<myRank<<"th slave are: "<<iterationCount-1<<endl;
	it1=Coordlist.begin();
        while(it1!=Coordlist.end()){
                delete[] it1->x;
                delete[] it1->y;
                delete[] it1->z;
                ++it1;
        			   }
	delete[] SendRstpos;
	delete[] Recvpos;
	
}
