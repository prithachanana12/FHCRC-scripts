#!/bin/bash
##run cellranger mkfastq

if [ $# != 3 ]; then
	echo "USAGE: bash CR_mkfastq.sh illumina_BCL_dir samplesheet_csv output_dir"
	exit 1
else
	echo `date`
	
	bcl=$1
	csv=$2
	outdir=$3
	
	module load cellranger/3.0.2
	cd $bcl
		
	/usr/bin/sbatch --workdir=${bcl} -J mkfastq --partition=largenode -n 1 -c 6 --mem=35G --mail-type=END,FAIL --mail-user=pchanana@fredhutch.org -o ${outdir}/%x.%j.out --wrap="cellranger mkfastq --run=${bcl} --csv=${csv} --qc --barcode-mismatches 0 --output-dir=${outdir}" 

fi
