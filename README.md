Installation of required softwares

1) FastQC
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip
unzip fastqc_v0.12.1.zip

3) Trimmomatic
wget https://github.com/usadellab/Trimmomatic/files/5854859/Trimmomatic-0.39.zip
unzip Trimmomatic-0.39.zip

5) Burrows-Wheeler Aligner
git clone https://github.com/lh3/bwa.git
cd bwa; make

7) Samtools and htslib suit, You don’t hae to get the htslib separately.
wget https://github.com/samtools/samtools/releases/download/1.18/samtools-1.18.tar.bz2
tar -xvzf samtools-1.18.tar.bz2 && cd samtools-1.18
./configure --prefix=/your/soft/path/name/
make
make install
export PATH="/your/soft/path/name/samtools-1.18/bin:$PATH"

5) Picard Tools
git clone https://github.com/broadinstitute/picard.git
cd picard
./gradlew shadowJar

7) Bioawk
sudo git clone https://github.com/lh3/bioawk.git
cd bioawk/
sudo make
./bioawk

9) BCFTools
wget https://github.com/samtools/bcftools/releases/download/1.10.2/bcftools-1.10.2.tar.bz2
tar -xjvf bcftools-1.10.2.tar.bz2
cd bcftools-1.10.2
make
sudo make prefix=/usr/local/bin install
sudo ln -s /usr/local/bin/bin/bcftools /usr/bin/bcftools # you don't technically need to do this. And if you aren't a root user you may get a ``permission denied`` message - don't worry about it.

10) PSMC
git clone https://github.com/lh3/psmc.git
cd psmc
make
cd utils
make

11) R and R-Studio
Download R first - For Machttps://cran.r-project.org/bin/macosx/
For Windows : https://cran.r-project.org/bin/windows/base/

Now Download R-Studio. R-Studio is an IDE which helps you access R interactively. Alternatively you can use any other IDE like VS Code. Download the R-Studio - https://posit.co/download/rstudio-desktop/

#Subsample 10000 read pairs from two large paired FASTQ files (remember to use the same random seed to keep pairing):
  seqtk sample -s100 RWB_R1_paired.fq.gz 17200000 | gzip > RWB_R1_5g_1.fq.gz
  seqtk sample -s100 RWB_R2_paired.fq.gz 17200000 | gzip > RWB_R2_5g_1.fq.gz
  

#Trimming
java -jar /home/jagativishwa/softs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -phred33 -threads 40 -trimlog bof_trim.log -summary bof_summary.txt \
  BOF_R1.fastq.gz BOF_R2.fastq.gz \
  bof_R1_paired.fq.gz bof_R1_unpaired.fq.gz \
  bof_R2_paired.fq.gz bof_R2_unpaired.fq.gz \
  ILLUMINACLIP:/home/jagativishwa/softs/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36


#Sh_trimming (qsub/qdel/qstat/freenodes)
#PBS -N trim-1
#PBS -q iiser
#PBS -l select=1:ncpus=40,pmem=188
#PBS -V
#PBS -l walltime=128:00:00
#PBS -o bof_trim-1.o
#PBS -e bof_trim-1.err
#PBS -m abe
#PBS -M vishwajagati@labs.iisertirupati.ac.in

/home/app/jre1.8.0_241-amd64/bin/java -jar /home/jagativishwa/softs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
  -phred33 -threads 40 -trimlog /home/jagativishwa/raw/NS_trim.log -summary /home/jagativishwa/raw/NS_summary.txt \
  /home/jagativishwa/raw/NS_R1.fastq.gz /home/jagativishwa/raw/NS_R2.fastq.gz \
  /home/jagativishwa/raw/NS_R1_paired.fq.gz /home/jagativishwa/raw/NS_R1_unpaired.fq.gz \
  /home/jagativishwa/raw/NS_R2_paired.fq.gz /home/jagativishwa/raw/NS_R2_unpaired.fq.gz \
  ILLUMINACLIP:/home/jagativishwa/softs/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36


#Before we start mapping the data, we need to index the reference
/mnt/d/vishwa/psmc/softs/bwa/bwa index /mnt/e/psmc/mapping/RWB/RWB_ref.fna


#mapping
/mnt/d/vishwa/psmc/softs/bwa/bwa mem -M -t 20 -R "@RG\tID:JO_30x\tSM:JO_\tLB:IlluminaWGS\tPL:ILLUMINA" \
/mnt/e/psmc/mapping/RWB/RWB_ref.fna \
/mnt/e/psmc/mapping/RWB/RWB_subsets/5g_1/RWB_R1_5g_1.fq.gz \
/mnt/e/psmc/mapping/RWB/RWB_subsets/5g_1/RWB_R2_5g_1.fq.gz | \
/mnt/d/vishwa/psmc/softs/samtools-1.18/bin/samtools view -bh - | \
/mnt/d/vishwa/psmc/softs/samtools-1.18/bin/samtools sort -T tmp -o /mnt/e/psmc/mapping/RWB/RWB_5g_1_ref.bam


#filter based on quality filter
/mnt/d/vishwa/psmc/softs/samtools-1.18/bin/samtools view \
                 -bh \
                 -F 4 \
                 -q 30 \
                 -o RWB_5g_1_filtered.bam \
                 ./RWB_5g_1_ref.bam

#sort the filtered bam
/mnt/d/vishwa/psmc/softs/samtools-1.18/bin/samtools sort \
              -o RWB_5g_1_filtered_sorted.bam \
              -T RWB_5g_1_filtered_temp \
              ./RWB_5g_1_filtered.bam

#remove PCR Duplicates
java -jar -Xmx8g -jar /mnt/d/vishwa/psmc/softs/picard/build/libs/picard.jar MarkDuplicates \
    MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=900 \
    INPUT=RWB_5g_1_filtered_sorted.bam \
    OUTPUT=RWB_5g_1_filtered_sorted_rmdup.bam \
    ASSUME_SORTED=TRUE \
    REMOVE_DUPLICATES=true \
    METRICS_FILE=RWB_5g_1.rmdup.metrix.txt \
    TMP_DIR=./ \
    VALIDATION_STRINGENCY=SILENT


#Index the final bam
/mnt/d/vishwa/psmc/softs/samtools-1.18/bin/samtools index RWB_5g_1_filtered_sorted_rmdup.bam





