#!/bin/bash
#SBATCH -J APA
#SBATCH --mem=20G
#SBATCH --time=2:00:00
#SBATCH -N 1

module unload r
module load juicer/1.5

hic_file=$1
bedpes=$2
res=$3
inpdir=$4
object=$5
main_dir=$6
analysis=$7

bedpe=`echo $bedpes | awk -v n="${SLURM_ARRAY_TASK_ID}" '{print $n}'`
bedpe_path=$main_dir/bedpes/$bedpe

outname=`echo $bedpe | sed 's/.bedpe//g'`
outdir=$inpdir/APA/"$analysis"/"$outname"_"$object"

juicer_tools apa -r $res -n 5 -u $hic_file $bedpe_path $outdir
