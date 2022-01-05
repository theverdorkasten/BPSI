#!/bin/sh
accession=$1

module load bio/SRA-Toolkit/2.10.7-centos_linux64 bio/HISAT2/2.2.1-foss-2020a 

hisat2 -x genome --sra-acc ${accession} -S ${accession}.sam -p 16 --no-spliced-alignment

module unload bio/HISAT2/2.2.1-foss-2020a bio/SRA-Toolkit/2.10.7-centos_linux64
