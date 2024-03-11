
#TOTAL SCAFFOLDS BLASTED

TOT_SCAFS=`grep "Query" Blast_RWB_to_ZF_db.out.txt | wc -l`

#QUERIES THAT FOUND ONE OR MORE HITS

HIT_SCAFS=`grep -v ^"#" Blast_RWB_to_ZF_db.out.txt | awk '{print $1}' | sort -n | uniq | wc -l`

echo "Total Queries BLASTED is -" ${TOT_SCAFS} "; Queries with at least 1 hit are -" ${HIT_SCAFS} >> Blast_summary.txt

echo "Specifics for queries with hits -" >> Blast_summary.txt

echo "All top hit values are only given for Pident >=80" >> Blast_summary.txt

echo "NC_SCAF" "Q_LEN" "NUM_HITS" "HITS_>80_P-IDENT" "BEST_HIT_By_P-IDENT" "BEST_HIT_By_QCov" "BEST_HIT-BY_QCov_QCov" "BEST_HIT-BY_QCov_LEN" "SAME_BEST_HIT-Y/N" "DIFF_NEXT_BEST_P-IDENT"  >> Blast_summary.txt

# This next bit will be done for each unique query in the concatenated BLAST output file

for SCAF in `cut -f1 Blast_RWB_to_ZF_db.out.txt | grep -v ^"#" | sort -n | uniq`
do
	hits=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | wc -l`
	Qlen=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | cut -f6 | awk 'NR==1'`
	Hits_80_PI=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | awk '$3>=80' | wc -l` 
        Best_Hit_By_Pident=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | awk '$3>=80' | sort -rnk3,3 | awk '{if(NR==1) print $2 }'`
        Best_Hit_By_QCov=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | awk '$3>=80' | sort -rnk5,5 | awk '{if(NR==1) print $2 }'`
	Best_Hit_By_QCov_QCov=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | awk '$3>=80' | sort -rnk5,5 | awk '{if (NR==1) print $5}'`
	Best_Hit_By_QCov_Len=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | awk '$3>=80' | sort -rnk5,5 | awk '{if (NR==1) print $4 }'`

        if [[ $Best_Hit_By_Pident == $Best_Hit_By_QCov ]]; then SAME=Y; else SAME=N; fi

	NEXT_BEST_Pident=`grep -w ^${SCAF} Blast_RWB_to_ZF_db.out.txt | awk '$3>=80' | sort -rnk3,3 | cut -f3 | awk '{if (NR==2) {print $1-a} a=$1}'`
        echo ${SCAF} ${Qlen} ${hits} ${Hits_80_PI} ${Best_Hit_By_Pident} ${Best_Hit_By_QCov} ${Best_Hit_By_QCov_QCov} ${Best_Hit_By_QCov_Len} ${SAME} ${NEXT_BEST_Pident} >> Blast_summary.txt
done
