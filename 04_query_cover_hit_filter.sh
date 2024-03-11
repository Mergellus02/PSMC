awk '$6 ~ /NC_044241.2/ {print $1}' Blast_summary.txt > Blast_scaffolds_list_Z_chr.txt

awk '$6 ~ /NC_045028.1/ {print $1}' Blast_summary.txt > Blast_scaffolds_list_W_chr.txt

cat Blast_scaffolds_list_Z_chr.txt Blast_scaffolds_list_W_chr.txt > Blast_scaffolds_list_ZW_chr.txt
