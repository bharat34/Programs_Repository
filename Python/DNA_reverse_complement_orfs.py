''' This program takes a DNA sequence calculates the reverse complement of the DNA, 
    and then calculates all the ORFs in both the input (+) DNA string and 
	the reverse complement (-) string'''

def all_indices(value, qlist):
    indices = []
    idx = -1
    while True:
        try:
            idx = qlist.index(value, idx+1)
            indices.append(idx)
        except ValueError:
            break
    return indices

def findorfs(DNA):
    orf=[]
    start_ATG=all_indices("ATG",DNA);
    end_TAA=all_indices("TAA",DNA);
    end_TAG=all_indices("TAG",DNA);
    end_TGA=all_indices("TGA",DNA);
    All_stop=sorted(end_TAA+end_TAG+end_TGA);
    
    for i in start_ATG:
        flag=0;
        for j in All_stop:
            if(flag==1):
                break
            elif(((((j+2)-i)+1)%3==0) and (j>i)):
                orf.append((i,j+3))
                flag=1;
    return orf

def complement(dna):
    swap={'A':'T','T':'A','G':'C','C':'G'};
    newdna='';
    for nu in dna:
        newdna+=swap[nu]
    return newdna;


def reverse(dna):
    return dna[::-1];

def transcribe(dna):
    return dna.replace('T','U');

def translate(rna):
    mRNA=(rna.upper()).replace('T','U');
    tr_mRNA='';
    dict={'UUU':'F', 'UCU':'S', 'UAU':'Y', 'UGU':'C', 'UUC':'F', 'UCC':'S', 
'UAC':'Y', 'UGC':'C', 'UUA':'L', 'UCA':'S', 'UAA':'.', 'UGA':'.', 'UUG':'L', 
'UCG':'S', 'UAG':'.', 'UGG':'W', 'CUU':'L', 'CCU':'P', 'CAU':'H', 'CGU':'R', 
'CUC':'L', 'CCC':'P', 'CAC':'H', 'CGC':'R', 'CUA':'L', 'CCA':'P', 'CAA':'Q', 
'CGA':'R', 'CUG':'L', 'CCG':'P', 'CAG':'Q', 'CGG':'R', 'AUU':'I', 'ACU':'U', 
'AAU':'N', 'AGU':'S', 'AUC':'I', 'ACC':'U', 'AAC':'N', 'AGC':'S', 'AUA':'I', 
'ACA':'U', 'AAA':'K', 'AGA':'R', 'AUG':'M', 'ACG':'U', 'AAG':'K', 'AGG':'R', 
'GUU':'V', 'GCU':'A', 'GAU':'D', 'GGU':'G', 'GUC':'V', 'GCC':'A', 'GAC':'D', 
'GGC':'G', 'GUA':'V', 'GCA':'A', 'GAA':'E', 'GGA':'G', 'GUG':'V', 'GCG':'A', 
'GAG':'E', 'GGG':'G',};
    for i in range(0,len(mRNA),3):
        tr_mRNA += dict[mRNA[i:i+3]];
    return tr_mRNA;




DNA=raw_input("Please input mRNA sequence ");
DNA_U=DNA.upper();

orfs=findorfs(DNA_U);
for i,j in orfs:
    print "+",i,translate(DNA_U[i:j-3]);

DNA_comp_rev=(reverse(complement(DNA_U)));
orfs=findorfs(DNA_comp_rev);
for i,j in orfs:
    print "-",i,translate(DNA_comp_rev[i:j-3]);
