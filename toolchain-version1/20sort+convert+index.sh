#!/bin/sh
accession=$1
module load bio/SAMtools/1.10-foss-2020a

samtools view -bS ${accession}.sam > ${accession}.bam
samtools sort ${accession}.bam -o ${accession}.sorted.bam
samtools index ${accession}.sorted.bam

module unload bio/SAMtools/1.10-foss-2020a
