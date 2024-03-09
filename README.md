#Trimming
java -jar /home/jagativishwa/softs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -phred33 -threads 40 -trimlog bof_trim.log -summary bof_summary.txt \
  BOF_R1.fastq.gz BOF_R2.fastq.gz \
  bof_R1_paired.fq.gz bof_R1_unpaired.fq.gz \
  bof_R2_paired.fq.gz bof_R2_unpaired.fq.gz \
  ILLUMINACLIP:/home/jagativishwa/softs/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36

#Sh_trimming (qsub)


#Subsample 10000 read pairs from two large paired FASTQ files (remember to use the same random seed to keep pairing):
  seqtk sample -s100 RWB_R1_paired.fq.gz 17200000 | gzip > RWB_R1_5g_1.fq.gz
  seqtk sample -s100 RWB_R2_paired.fq.gz 17200000 | gzip > RWB_R2_5g_1.fq.gz
