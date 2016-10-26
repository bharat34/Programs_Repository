import math
"""
the program calculates Mutual information between all 
 the N X N position in the protein family multiple sequence alignment
Written by Bharat Lakhani
Takes each sequence from an MSA file and adds it to a list

"""

def create_msa(msafile):
    msafile=open(msafile,'r')
    msa=[]
    AAs=''
    AA_count=[]
    for sequence in msafile:
        msa.append(sequence.strip())
    return msa

# This function calculates the occurrence of each amino acid at each sequence position 
def calculate_aa_probabilities(msa):
#First, I switched the order of the msa list so that the first elements of the list
#is a string that contains the amino acids that occur at the first position of the alignment and so on 
#this string is called AA_count
    AAs=''
    AA_count=[]
    for i in range(len(msa[0])):
        for sequence in msa:
            AAs+=sequence[i]
        AA_count.append(AAs)
        AAs=''
    aa=['I','L','V','F','M','C','A','G','P','T','S','Y','W','Q','N','H','E','D','K','R']
    position={}
#Created a dictionary called position, each key in the dictionary corresponds to
#a position in the sequence alignment, and initialized the values to zero
    
    for i in range(len(msa[0])):
        position[i]=0
#for each position in the alignment, I first create a dictionary called dict_AA
#that contains all the amino acid codes as keys and initialize the values to zero
    for i in range(len(position)):
        dictAA={}
        for n in aa:
            dictAA[n]=0.0
#counts the number of amino acids at position[i] and stores them in dictAA
        for x in AA_count[i]:
            if dictAA.has_key(x):
                dictAA[x]=dictAA[x]+1
#set the value of position[i] equal to dictAA
        position[i]={}
        position[i]=dictAA
    return position
    #print position
	
	
#Reading a sequence containing input file
#filename=raw_input("Please input the Filename\n")
filename="sampleMSA1.txt"
#create_msa function will return a sequence containing list type object named mySeq 
mySeq=create_msa(filename)
# open a file to write the output
fileW = open("result"+filename, "w")
# calculate_aa_probabilities function will return a dictionary of dictionary type object named AA_pos_dict
# AA_pos_dict contains occurrence of each amino acid for each position in the sequence
AA_pos_dict=calculate_aa_probabilities(mySeq)

# Initialize the variable i, j, AA_poss_comb (dictionary of dictionary)
# NoOfSeq (Total Number of sequence in the file), Seqlen (sequence length)
i=0;j=0;AA_poss_comb={};NoOfSeq=(len(mySeq));Seqlen=(len(mySeq[0]));

# while loop from i=0 to total sequence length
while(i<Seqlen):
    j=i+1
	# while loop from j=i to total sequence length since we want to make unique combination
    while(j<Seqlen):
        k=0
		# A dictionary of dictionary type variable which will store amino acids 
		# combination correspond to unique position in the sequence
        AA_poss_comb[i,j]={}
		# For any given position combination of i,j in the sequence 
		# we want to make a dictionary containing occurrence of amino acids combination
        while(k<NoOfSeq):
			# Skip if it has gap
            if((mySeq[k][j]!='-') and (mySeq[k][i]!='-')):
				# Append the AA combination
                my_AA=mySeq[k][i]+mySeq[k][j]
				# if the combination is already prettiness there increase the counter by 1
                if my_AA in AA_poss_comb[i,j].keys():
                    AA_poss_comb[i,j][my_AA]+=1.0
				# or else initialize the AA combination by 1
                else:
                    AA_poss_comb[i,j][my_AA]=1.0
            k+=1
        j+=1
    i+=1
   
# U1A MSA positions in the 1URN pdb file
#ResList=["12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","33","34",
#         "35","36","37","38","39","40","41","42","43","44","45","46","47","48","52","53","54","55","56",
#         "57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75",
#         "76","77","78","79","80","81","82","83","84"];

# PDZ MSA potions in the 1BE9 pdb file
#ResList=["303","304","305","306","307","308","309","310","311","312","313","314","315","316","317","318",
#         "319","320","321","322","323","324","325","326","327","328","329","330","331","332","334","335",
#         "336","337","338","339","340","341","342","343","344","345","346","347","348","349","350","351",
#         "353","354","355","356","357","358","359","360","361","362","363","364","365","366","367","368",
#         "369","370","371","372","373","374","375","376","377","378","379","380","381","382","383","384",
#         "385","386","387","388","389","390","391","392","393","394","395","396"];

i=0;j=0;

# Since we have occurrence of each AA for any given position in the sequence in our AA_pos_dict
# and combined AA occurrence for any given position Now we just to have run a while loop for 
# all unique position in the given sequence

# Run while loop from i=0 to total sequence length
while(i<Seqlen):
    j=i+1
    # run while loop from j = i to total sequence length
    while(j<Seqlen):
        #Initialize final variable with 0.0
        final = 0.0
        #Add MI for all occurred amino acids in concert with other amino acids for any
        #given position i and j
        for key, value in AA_poss_comb[i,j].iteritems():
            #plug-in the derived formula
            
            final += (float(value)/float(NoOfSeq))*math.log(((float(value)/float(NoOfSeq))/
                                                             ((float(AA_pos_dict[i][key[0]])/float(NoOfSeq))*(float(AA_pos_dict[j][key[1]])/float(NoOfSeq)))),2)
            print i+1,j+1,final,value,NoOfSeq,float(AA_pos_dict[i][key[0]]),float(AA_pos_dict[j][key[1]])
            break
            #write the final MI in the output file        
        fileW.write(' (%d,%d) => %f\n' %(i+1,j+1,final))
        #fileW.write(' (%s,%s) => %f\n' %(ResList[i],ResList[j],final))       
        
        j=j+1
    i=i+1
#close the file handle
fileW.close()
print "Please check the result"+filename," File for output"
