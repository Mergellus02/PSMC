bioawk -c fastx '{print ">" $name ORS length($seq)}' /mnt/e/psmc-tutorial/3_mapping/GCA_013186435.1_ASM1318643v1_genomic.fna | paste - - > length_of_each_scaffold_of_truf_ref.txt
