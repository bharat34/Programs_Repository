DNA='TCACGGTCTCAGATTGCCTCTTACTCATGCCAGCCAAATGCTAGCTTTTTTGGTGGAAAAAATAATAGAATAATACAAAAGGAATTTTCAGTTCTTTTCGTCGCTTTATTATTAAGAAGCGGTTACAAGTATTTTAGTGGTATGACCTAATAAATATTGGGAGTTCCAAATCAAAACATTCTTCGATCGCTACTAACTAAAAATGTGGCAGCTGGTCATCAACATGGTGGACATAAACTTGGAGTGCGTGCACCAGATCGAACCGAAGACCCGTTCTGCTGGTCAGCAGCAGCAGGAGCGAGGGTTAAAGGAAGCCTACCTGGAAGCGGTCCGCATTCTGTTAGTGCTGCTGGAGAACATCTTGGCGCAGCCGGAGAACTCCATGTTCCGCACCATACGGCAGGAAAACAAAGCTATTAAAGAAAAGCTGCTGTCCTTGCCCGGCTGTGAGAGGTTACTGGAAGCCATAGGCTTCGTACGCGCCCCCAGTTCCAACGCCTACACCTTGCCCACAGAGGTGTCACTGCAGCAGGTGAAGAAGTACAGAGATGCGCTGAGCGAGAGACGCACTGCCTGGCTTAACGGCACAGTGTCAAAAAGTCCTCCTCAACAAAGCACCACCAGCACCACGCCCTTGTTCATCAAGCCTTCTGTGGAATATCGCCATAGAATCGCCTTCCCCCGTGTATTGCGCACCAATAATAACTTTCTGCAGTCGCTAGAGCTTTATTCCGATGCAGTCATGCAGTACGAGGATAACCTGCTGCTGGCTACTGGCCGCACTCTGATTCCTGTGGAAGAGCTCACCGAAATGGCAAGCGAGAAACTGATAGACATCCAAGATCAAATTGCGTCGGGTGAGCGCCAGGAGAAGGAGCCATGTGTTCGCGACTTGCTGCTTGTGGAGCTGGTAAACTGGTTCAACACGCAGTTCTTCCAGTGGGTAAACAATATACCTTGCCGCGTGTGTGGGAGTGAAGAGAGCAGGCTGCGCCGCACTGAACGGGAAGGTGATATAAGGGTGGAAGTCACCGTTTGCTGCGGCCAGGAGAGCAAGTTCTACCGCTATAACGACATTTCCCAGCTCCTAGTTTCCCGTAAGGGCCGTTGCGGAGAATATGCCAATTGCTTCACATTCCTCTGTCGCGCCCTCGACTACGACGCCCGTATTGTCCACTCGCATTTTGATCACGTCTGGACCGAGGTGTACTCCGAGGCCCAGATGCGTTGGCTCCATGTTGACCCCTCCGAGAACGTTATAGATTCTCCGCTGATGTATCAGCATGGCTGGAAACGTCACATCGACTACATTCTTGCATACTCTAGGGACGACATCCAAGATGTGACTTGGCGCTATACTAATGACCACCAGAAGATTCTACACCTACGAAAGCTGTGCGGGGAAAAAGAAATGGTGCAAACGCTGGACGCGATTCGAGCAAAGCGGCGGCAAAATTGCACCGCCGATCGAAAGTTATTCCTCAGCCAGCGCAATATGTACGAGGTCATCGGCTTGACGCTAGAGCGTAAGCCGACAGAAAACGAGCTGAAGGGTCGGAGTTCGGGAAGTCTTTCTTGGCGGCAGTCACGTGGAGAGCATACTTTTACCAATATATTCGTTTTCAATCTAAGTGCAACCGAACTACAAAAAAGGCAACTTAATGTGCGTTACAGCTGTGCCACCGATACATACGAACGATATGCCAAAGAAGGAGAACACATCACTATTTTGGATAGCTATAAGACATGGCAAAAAGCGCAATTTTCCTCAAAGAACATATTTCGGAAAGTGGAACGCGATTGGAAAATGGCATATTTGGCTAGACTGGAGGATACCGATTGCGGAGAAATTGCCTGGACGTTTGATTTCAGCAAGACCAATTTAAAGGTTAAGTCTTACAACTTAGTTTTCGAGACAAAAACTTTTGGCGACGGAAAAATCAGCGTGACTGTCGATGCCACCGACGGAAGCGCTTCGGTTGAAAATGCCACTGGATTCAAAATAGTGGCCAAACTTACGGGTGGCAAGGGCGATGTAGCATGGCAACACACACAACTGTTCAGGCAGAGTCTTAATTCAAGAGACTATCCCTTCGATCTGCAAGTGCAACTACATTGAAGTCCTCAAAAAATATTTTGGAGAAATTAAAATGTAATTGTAAATAATATAAACGATTCCCAGTCTGGATGAAAATATAATAATTAAAAATGTATATTAAAAATTAAATAAAGGCACATAGTGTCGCTATATGTAAAAAAAAAAAAAAAAAAAAAA';


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


start_ATG=all_indices("ATG",DNA);
end_TAA=all_indices("TAA",DNA);
end_TAG=all_indices("TAG",DNA);
end_TGA=all_indices("TGA",DNA);
All_stop=sorted(end_TAA+end_TAG+end_TGA);

diff=0; start=0; end=0;
for i in start_ATG:
    flag=0;
    for j in All_stop:
            if(flag==1):
                break
            elif(((((j+2)-i)+1)%3==0) and (j>i) and ((j+2)-i)>diff):
                diff=((j+2)-i); start=i; end=j+2;
                flag=1;

print "The sequence contains ",len(start_ATG)," ORFs";
print "The longest ORF starts at position ",start," and is of length ",end-start," nucleotides and ",(end-start)/3," amino acids."
