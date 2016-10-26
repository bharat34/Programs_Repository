"""
This function takes a DNA string as input and finds all open reading frames.
It stores them in a list
Last modified by Bharat Lakhani (05/7/2015)
"""
def findorfs(dna):
    ORFlist = [] #List of ORFs as tuples (start position, length)

    for i in range(0,len(dna)-5): #Note: ORF must have six nucleotides including stop codon
        if dna[i:i+3] == 'ATG': #Start codon found
            start_pos = i
            end_pos = i+3
            ORF_found = False
            
            while not ORF_found and end_pos < len(dna)-2: #Search for stop codon
                if dna[end_pos:end_pos+3] in ['TAA','TAG','TGA']: #Stop found; add ORF to list
                    ORF_found = True
                    ORFlist.append((start_pos,end_pos-start_pos+3))
                end_pos = end_pos + 3

    #returns results
    return ORFlist

#2.
#This function takes a DNA string as input and returns the complementary string     
def complement(dna):
    #translates each nucleotide letter to its complement letter.
    dictComplement={'A':'T', 'T':'A', 'C':'G', 'G':'C'}
    #stores the complement DNA string
    strComplement=''

    #makes the complement DNA string
    for nucleotide in dna:
        strComplement+=dictComplement[nucleotide]

    #returns the complement DNA string
    return strComplement

#3.
#This function takes a DNA string as input and returns the reverse string.
def reverse(dna):
    #splices the dna string so that it is returned in reverse
    return dna[::-1]

#4.
#This function converts a DNA string to the corresponding RNA (where each ﾑTﾒ is replaced with ﾑUﾒ).
def transcribe(dna):
    #stores the RNA string that will be transcribed from dna
    strRNA=''

    #makes the RNA string
    for nucleotide in dna:
        #converts Ts to Us
        if nucleotide=='T':
            nucleotide='U'
        #adds each RNA nucleotide to the RNA string
        strRNA+=nucleotide

    #returns the RNA string
    return strRNA

#5.
#This function take an RNA sequence as input and outputs its protein translation
#starting at the first nucleotide.
def translate(rna):
    #This dictionary translates each 3 nucleotide RNA codon to its 
    #corresponding amino acid.
    translation = dict \
    (
            # Uxx

            UUU = 'F' ,
            UUC = 'F' ,
            UUA = 'L' ,
            UUG = 'L' ,

            UCU = 'S' ,
            UCC = 'S' ,
            UCA = 'S' ,
            UCG = 'S' ,

            UAU = 'Y' ,
            UAC = 'Y' ,
            UAA = '.' ,
            UAG = '.' ,

            UGU = 'C' ,
            UGC = 'C' ,
            UGA = '.' ,
            UGG = 'W' ,

            # Cxx

            CUU = 'L' ,
            CUC = 'L' ,
            CUA = 'L' ,
            CUG = 'L' ,

            CCU = 'P' ,
            CCC = 'P' ,
            CCA = 'P' ,
            CCG = 'P' ,

            CAU = 'H' ,
            CAC = 'H' ,
            CAA = 'Q' ,
            CAG = 'Q' ,

            CGU = 'R' ,
            CGC = 'R' ,
            CGA = 'R' ,
            CGG = 'R' ,

            # Axx

            AUU = 'I' ,
            AUC = 'I' ,
            AUA = 'I' ,
            AUG = 'M' ,

            ACU = 'T' ,
            ACC = 'T' ,
            ACA = 'T' ,
            ACG = 'T' ,

            AAU = 'N' ,
            AAC = 'N' ,
            AAA = 'K' ,
            AAG = 'K' ,

            AGU = 'S' ,
            AGC = 'S' ,
            AGA = 'R' ,
            AGG = 'R' ,

            # Gxx

            GUU = 'V' ,
            GUC = 'V' ,
            GUA = 'V' ,
            GUG = 'V' ,

            GCU = 'A' ,
            GCC = 'A' ,
            GCA = 'A' ,
            GCG = 'A' ,

            GAU = 'D' ,
            GAC = 'D' ,
            GAA = 'E' ,
            GAG = 'E' ,

            GGU = 'G' ,
            GGC = 'G' ,
            GGA = 'G' ,
            GGG = 'G' ,
    )

    # output to be issued for invalid codons:
    invalid_codon = '#'

    codon = ''
    output = ''

    #while loop that translates rna to protein
    i = 0
    while i < len(rna):
            codon = rna[i : i + 3]
            if(len(output)==80):
                output += "\n"              
            output += translation.get(codon.upper() , invalid_codon)
            i += 3

    #returns the protein output
    return output
# input filename
filename=raw_input("Please input sequences containing name of the FASTA file name\n")
# output filename
output=raw_input("Please input file name of the output file where the potential proteins are to appear\n")
#6
#This function calculates the reverse complement of the DNA,
#and then calculates all the ORFs in both the input (+) DNA string
#and the reverse complement (-) string. The calculated ORFs finally written
#in to user given output file.
#The ORF protein sequences will be included in the output.
foutput = open(output,"w")
def findallORFs(dna,header):
    #gets the reverse complement strand of DNA
    revCompDNA=reverse(complement(dna))
    #gets the RNA sequences for both strands of DNA
    rna=transcribe(dna)
    revCompRNA=transcribe(revCompDNA)
    #finds the ORFs in both DNA strands
    orfs=findorfs(dna)
    revCompORFs=findorfs(revCompDNA)
    #will be used to store the protein sequences
    #prints each ORF in the output format for the original DNA strand.
    protein='';
    for eachORF in orfs:
        #translates the protein from the RNA sequence
        #The RNA sequence goes from the start position to the end position-3.
        #Does not print the stop codons.
        protein=translate(rna[eachORF[0]:eachORF[0]+eachORF[1]-3])
        #prints each of the results
        #foutput.write(header,'\tAUG = '+str(eachORF[0])+'\t len_ORF = ',((eachORF[1]+3)-eachORF[0]),'\n'+protein);
        foutput.write('%s %s; AUG = %s len_ORF = %s \n%s\n' %(header[0],header[1:],str(eachORF[0]),str(eachORF[1]),protein))
    #prints each ORF in the output format for the reverse complement strand.
    for eachORF in revCompORFs:
        #translates the protein from the RNA sequence
        #The RNA sequence goes from the start position to the end position-3.
        #Does not print the stop codons.
        protein=translate(revCompRNA[eachORF[0]:eachORF[0]+eachORF[1]-3])
        #prints each of the results
        foutput.write('%s %s; AUG = -%s len_ORF = %s \n%s\n' %(header[0],header[1:],str(eachORF[0]),str(eachORF[1]),protein))
        #foutput.write(header,'\tAUG = -'+str(eachORF[0])+'\t len_ORF = ',((eachORF[1]+3)-eachORF[0]),'\n'+protein);




# This part reads the input file line by line
#start my getting user input for the DNA string.
filehandle = open(filename, "r")
import re
# regular expression matching operations
regex = re.compile('>')
dna=''
# while loop will always be true
while 1:
    # reading each line from the file one by one
    line = filehandle.readline()
    # check if there is FASTA header line
    header = regex.findall(line)
    # exit the while loop we reached at the last line in the file
    if not line:
		# before exiting find the orf for the last DNA sequence
        findallORFs(dna,prev_header)
        break
		# if its header
    elif header:
		# if dna contains the whole sequence find the ORFs
        if dna:
            findallORFs(dna,prev_header)
		# initialize the dna with null again	
        dna=''
		# strip the fasta header
        prev_header=line.strip()
	# else concatenate the whole sequence into dna variable until you reached fasta header
    else:
        dna += line.strip()

# close both the files
foutput.close()
filehandle.close()
