~/softs/ncbi-blast-2.14.1+/bin/blastn -db /mnt/e/psmc-tutorial/4_sexchrfilter/ZF_all_chrom.db -query GCA_013186435.1_ASM1318643v1_genomic.fna -max_target_seqs 5 -max_hsps 1 -evalue 1e-10 -outfmt "7 qseqid sseqid pident length qcovs qlen qstart qend evalue bitscore" -out ./Blast_TSB_to_ZF_db.out.txt
