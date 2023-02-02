# Day-2
### Quality Control

Run anviscript
```
#!/bin/bash
#SBATCH --nodes=1
#SBATCH

module load miniconda3/4.7.12.1

alternative:
source activate

conda activate /home/sunam226/.conda /envs/anvio/
```
So #SBATCH for 
- job-name
- output
- error
  
you have to change specific

Than for the first step `fastqc` you need:
```
module load fastqc
cd /work_beegfs/sunam234/genomw/0_raw_reads
for i in *.gz; do fastqc $i; done
done
```

For `fastp` you use: 
```
cd /work_beegfs/sunam234/genomw/0_raw_reads
mkdir ../clean_folder

for i in `ls *R1.fastq.gz`;
do
    second=ècho ${i} | sed 's/_R1/_R2/g'`
    fastp -i ${i} -I ${second} -R_report -o ../clean_folder/"${i}" -0 ../clean_folder/"${second}" -t 6 -q 20
done
```
And for àssembly` you use:
```
megahit -1 sample1_R1.fastq.gz -1 sample2_R2.fastq.gz -2 sample1_R1.fastq.gz -2 sample2_R2.fastq.gz --min-contig-len 1000 --presets meta-large -m 0.85 -o ./3_coassembly/ -t 20
```

