#!/bin/sh
accession=GSE117940
module load bio/MACS2/2.2.7.1-foss-2019b-Python-3.7.4

macs2 callpeak -t ${accession}.sorted.bam -f BAM -n $accession \
         -g mm -B --call-summits --keep-dup 50 -q 0.05 -m 10 200

module unload bio/MACS2/2.2.7.1-foss-2019b-Python-3.7.4
module load bio/BEDTools/2.29.2-GCC-9.3.0

awk '{OFS="\t";} {print $1,$2-100,$3+100,$4,$5}' ${accession}_summits.bed \
        > ${accession}_summit_window.bed

cat ${accession}_summit_window.bed | sort -k1,1 -k2,2n | \
        awk '$2 >= 0' | \
        mergeBed -i stdin | \
        intersectBed -wa -v -a stdin -b mm10.blacklist.bed > CAF_merged_peaks.bed
