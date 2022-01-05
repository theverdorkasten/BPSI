#!/bin/sh
accession=$1

module load bio/BEDTools/2.29.2-GCC-9.3.0

awk '{OFS="\t";} {print $1,$2-100,$3+100,$4,$5}' ${accession}_summits.bed \
        > ${accession}_summit_window.bed

cat ${accession}_summit_window.bed | sort -k1,1 -k2,2n | \
        awk '$2 >= 0' | \
        mergeBed -i stdin | \
        intersectBed -wa -v -a stdin -b hg38-blacklist.v2.bed > ${accession}_CAF_merged_peaks.bed

module unload bio/BEDTools/2.29.2-GCC-9.3.0
