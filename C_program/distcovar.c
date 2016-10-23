#include <list>
#include <cmath>
#include <string>
#include <assert.h>
#include <cstdlib>
#include <algorithm>
#include <map>
#include <time.h>
#include <iostream>

using namespace std;
int  getPdbSize(char* fileName);

typedef struct {
	float *x;
	float *y;
	float *z;
}StoreCoordlist;

int main(int argc,char **argv){

	list<StoreCoordlist> Coordlist;

	FILE *rfp;
	rfp = fopen(argv[1],"r");	
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
	int noOfTimeSeries=0;

	int noOfCa=atoi(argv[2]);
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
	cout<<"File Reading is done\n";

	int TotIter=0;

	list<StoreCoordlist>::iterator it1=Coordlist.begin();
	list<StoreCoordlist>::iterator it2=Coordlist.begin();

	for (int i = 0; i < noOfCa; i++) {
		cout<<i<<" resdue is done\n";
		for (int j = 0; j < noOfCa; j++) { 
			cout<<"resdue "<<i<<" and "<<j<<" combination is done\n";
			float S2A=0.0;
			float S2B=0.0;
			//cout<<"This is for the position: "<<i<<" "<<j<<endl;
					
					
			float S1[3];
			float S2[3];
			float S3[3];
			float BDCV[3];
			for (int u=0; u<3; u++) BDCV[u]=0.0;
			for (int y=0; y <3; y++) S1[y]=0.0; 
			for (int y=0; y <3; y++) S2[y]=0.0; 
			for (int y=0; y <3; y++) S3[y]=0.0; 

			for (int k = 0; k < noOfTimeSeries; k++) {
				it1 = Coordlist.begin();
				advance (it1,k);
				float AXJ = it1->x[i];
				float AYJ = it1->y[i];
				float AZJ = it1->z[i];

				float BXJ = it1->x[j];
				float BYJ = it1->y[j];
				float BZJ = it1->z[j];
				//cout<<" k -> pos i:- "<<k<<" "<<i<<endl;
				//cout<<" k -> pos j:- "<<k<<" "<<j<<endl;
				//cout<<AXJ<<" "<<AYJ<<" "<<AZJ<<endl;
				//cout<<BXJ<<" "<<BYJ<<" "<<BZJ<<endl;
				//cout<<"All Combinations are here: "<<endl;
				float DBS=0.0;
				float DAS=0.0;

					for (int l = 0; l < noOfTimeSeries; l++) {
						TotIter++;
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
						//cout<<" l -> pos i:- "<<l<<" "<<i<<endl;
						//cout<<" l -> pos j:- "<<l<<" "<<j<<endl;
						//cout<<AXK<<" "<<AYK<<" "<<AZK<<endl;
						//cout<<BXK<<" "<<BYK<<" "<<BZK<<endl;
								 	 	}
						S3[0]=S3[0]+DAS*DAS;
						S3[1]=S3[1]+DBS*DBS;
						S3[2]=S3[2]+DAS*DBS;
						//cout<<endl;
						 		 }
						S1[0]=S1[0]/noOfTimeSeries/noOfTimeSeries;
						S1[1]=S1[1]/noOfTimeSeries/noOfTimeSeries;
						S1[2]=S1[2]/noOfTimeSeries/noOfTimeSeries;

						S2[0]=(S2A*S2A)/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S2[1]=(S2B*S2B)/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S2[2]=(S2A*S2B)/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
					
					
						//cout<<S1[0]<<" " <<S1[1]<<" "<<S1[2]<<" "<<S3[0]<<" "<<S3[1]<<" "<<S3[2]<<endl;
						S3[0]=S3[0]/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S3[1]=S3[1]/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						S3[2]=S3[2]/noOfTimeSeries/noOfTimeSeries/noOfTimeSeries;
						//cout<<S1[0]<<" " <<S1[1]<<" "<<S1[2]<<" "<<S3[0]<<" "<<S3[1]<<" "<<S3[2]<<endl;
						//cout<<endl;
							for (int u=0; u<3; u++) { 
								//cout<<S1[u]<<" "<<S1[u]<<" "<<2*S3[u]<<endl;
								BDCV[u]=sqrt(S1[u]+S2[u]-2.0*S3[u]);
										}
						//cout<<BDCV[2]<<" "<<BDCV[0]<<" "<<BDCV[1]<<endl;
						cout<<(BDCV[2]/sqrt(BDCV[0]*BDCV[1]))<<" ";
					 	 				}
					cout<<endl;	
					 }
	
	it1=Coordlist.begin();
        while(it1!=Coordlist.end()){
                delete[] it1->x;
                delete[] it1->y;
                delete[] it1->z;
                ++it1;
        			   }
	//cout<<"Total Iterations are: "<<TotIter<<endl;
        return 0;
}
