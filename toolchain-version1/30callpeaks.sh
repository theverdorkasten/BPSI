#!/bin/sh
accession=$1

module load bio/MACS2/2.2.7.1-foss-2019b-Python-3.7.4

macs2 callpeak -t ${accession}.sorted.bam -n $accession \
         -B --call-summits --keep-dup auto

module unload bio/MACS2/2.2.7.1-foss-2019b-Python-3.7.4
