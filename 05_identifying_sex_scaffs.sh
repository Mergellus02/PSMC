# to extract the header lines 
grep -e ">" /Users/vinaykl/EBB/ref/ncbi_dataset/data/GCA_009812075.1/GCA_009812075.1_Ss_LA_1.0_genomic.fna > all_scaffs_header_Ss.txt

#to get only the scaffold name
cat all_scaffs_header_Ss.txt | awk '{print $1}' > all_scaffs_latest_Ss.txt

#subtract the Z and W hit from overall list
grep -v -w -f ./Blast_scaffolds_list_ZW_chr.txt all_scaffs_latest_Ss.txt > only_aut_scaff_list.txt

# add scaff length to only aut scaff list
grep -w -f only_aut_scaff_list.txt length_of_each_scaffold_of_Ss_ref.txt > only_aut_scaffs.txt

# create bed file with only aut chromosomes
sed 's,\t,\t0\t,' only_aut_scaffs.txt > aut_chrom_scaff_btg.bed

# for removing '>' from the above bed file
sed 's/^.//' aut_chrom_scaff_RWB.bed > autosomal_chromosome.bed
