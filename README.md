#Trimming
java -jar /home/jagativishwa/softs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -phred33 -threads 40 -trimlog bof_trim.log -summary bof_summary.txt \
  BOF_R1.fastq.gz BOF_R2.fastq.gz \
  bof_R1_paired.fq.gz bof_R1_unpaired.fq.gz \
  bof_R2_paired.fq.gz bof_R2_unpaired.fq.gz \
  ILLUMINACLIP:/home/jagativishwa/softs/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36

#Sh_trimming (qsub)


#Subsample 10000 read pairs from two large paired FASTQ files (remember to use the same random seed to keep pairing):

  seqtk sample -s100 read1.fq 10000 > sub1.fq
  seqtk sample -s100 read2.fq 10000 > sub2.fq
