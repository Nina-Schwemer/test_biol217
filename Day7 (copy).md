### Day 7
### RNA-Sew analysis (Transcriptomics)

***DataSet***

activate the enviroment
```
conda activate /home/sunam226/.conda/envs/grabseq
```
Open the Paper and search for the Data to download. Therfore use words like NCBI, accession or something. Look for the accession number and link. 
Next step is to find the SRR numbers. Therfore go to the SRA link. Open the links one after another and scroll down the pages There you find under run the SRR number. 

### SRR numbers:
- SRR4018516
- SRR4018515
- SRR4018514	
- SRR4018517

For download we used the 
```
fasterq-dump
```

### Quality Control
 Activate the enviroment
 ```
 module load fastqc
 ```
 and then run the command to check the quality of the reads
 ```
 fastqc -t 4 -o fastqc_output *.fastq
 ```
 To put alle the files together in one we use
 ```
 multiqc -d . -o multiqc_output 
 ```
 If you need to improve the quality of your run you use fastp
 ```
 for i in *.fastq.gz; do fastp -i $i -o ${i}_cleaned.fastq.gz -h ../qc_reports/${i}_fastp.html -j ${i}_fastp.json -w 4 -q 20 -z 4; done
 ```
 --html creates an .html report file in html format

-i input file name

-R report title, here ‘_report’ is added to each file

-o output_folder.fastq.gz output file

-t trim tail 1, default is 0, here 6 bases are trimmed

-q 20 reads with a phred score of <=20 are trimmed 
-zcompression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest, default is 4. (int [=4]) 

### READemption

activate enviroment
```
conda activate /home/sunam226/.conda/envs/reademption
```
Create a projectfolder
```
reademption create --project_path READemption_analysis --species salmonella="Salmonella Typhimurium"
```
Prepare the reference sequences and annotations
```
FTP_SOURCE=ftp://ftp.ncbi.nih.gov/genomes/archive/old_refseq/Bacteria/Salmonella_enterica_serovar_Typhimurium_SL1344_uid86645/
```
And download the files
```
wget -O READemption_analysis/input/salmonella_reference_sequences/NC_016810.fa $FTP_SOURCE/NC_016810.fna
wget -O READemption_analysis/input/salmonella_reference_sequences/NC_017718.fa $FTP_SOURCE/NC_017718.fna
wget -O READemption_analysis/input/salmonella_reference_sequences/NC_017719.fa $FTP_SOURCE/NC_017719.fna
wget -O READemption_analysis/input/salmonella_reference_sequences/NC_017720.fa $FTP_SOURCE/NC_017720.fna
```
Next we need the annotation file:
```
wget -P READemption_analysis/input/salmonella_annotations https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/210/855/GCF_000210855.2_ASM21085v2/GCF_000210855.2_ASM21085v2_genomic.gff.gz
```
And we needed to unzip it:
```
gunzip READemption_analysis/input/salmonella_annotations/GCF_000210855.2_ASM21085v2_genomic.gff.gz
```

Next step is to check the headers of our files, if they are start with the same. If not you can change it manual or with this command:
```
sed -i "s/>/>NC_016810.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_016810.fa
sed -i "s/>/>NC_017718.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_017718.fa
sed -i "s/>/>NC_017719.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_017719.fa
sed -i "s/>/>NC_017720.1 /" READemption_analysis/input/salmonella_reference_sequences/NC_017720.fa
```
Last step is to download the read files.
```
wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/InSPI2_R1.fa.bz2
wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/InSPI2_R2.fa.bz2
wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/LSP_R1.fa.bz2
wget -P READemption_analysis/input/reads http://reademptiondata.imib-zinf.net/LSP_R2.fa.bz2
```
We had to run the readumtion in a bash script.
```
#!/bin/bash
#SBATCH --job-name=reademption_
#SBATCH --output=reademption.out
#SBATCH --error=reademption.err
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --qos=long
#SBATCH --time=1-00:00:00
#SBATCH --partition=all
#SBATCH --export=NONE
#SBATCH --reservation=biol217

source ~/.bashrc

#activating conda
module load miniconda3/4.7.12.1
conda activate /home/sunam226/.conda/envs/reademption
reademption align --fastq -p 4 --poly_a_clipping --project_path READemption_analysis
reademption coverage -p 4 --project_path READemption_analysis
reademption gene_quanti -p 4 --features CDS,tRNA,rRNA --project_path READemption_analysis
reademption deseq -l sRNA_R1.fastq,sRNA_R2.fastq,wt_R1.fastq,wt_R2.fastq -c sRNA,sRNA,wt,wt -r 1,2,1,2 --libs_by_species methanosarcina=sRNA_R1,sRNA_R2,wt_R1,wt_R2 --project_path READemption_analysis
reademption viz_align --project_path READemption_analysis
reademption viz_gene_quanti --project_path READemption_analysis
reademption viz_deseq --project_path READemption_analysis
conda deactivate
jobinfo
```
