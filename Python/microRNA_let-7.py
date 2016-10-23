# this program calculates the micro RNA pattern in a given
# RNA fasta file (last modified by bharat lakhani)
filehandle = open('sample.txt', "r")
import re
# regular expression matching operations
regex = re.compile('>')
let71=re.compile('(c|t)t(a|g)t(a|g)(c|t)(a|g)(a|g)(c|t)(c|t)...(c|t)t(a|g)(c|t)(c|t)t(c|t)')
dna=''

def searchMICROrnasPattern(header,DNAsequence):
    iterator = let71.finditer(DNAsequence)
    for match in iterator:
        print prev_header, match.span(), match.group()
    

# while loop will always be true
while 1:
    # reading each line from the file one by one
    line = filehandle.readline()
    # check if there is FASTA header line
    header = regex.findall(line)
    # exit the while loop we reached at the last line in the file
    if not line:
        searchMICROrnasPattern(prev_header,dna)
        break
    elif header:
		# if dna contains the whole sequence find the ORFs
        if dna:
            searchMICROrnasPattern(prev_header,dna)
        dna=''
		# strip the fasta header
        prev_header=line.strip()
	# else concatenate the whole sequence into dna variable until you reached fasta header
    else:
        dna += line.strip()

# close both the files
filehandle.close()
