# Day 5

### MAGs Quality Estimation

We wanted to visulized our Bins. Therefor we needed to generate a .html file.
```
nvi-estimate-genome-completeness -c ./contigs.db -p ./merged_profiles/PROFILE.db -C consolidated_bins
```
Than we visulized it:
```
 anvi-estimate-genome-completeness -p ./merged_profiles/PROFILE.db -c ./contigs.db --list-collections
 ```
 Than we needed to do the S-batch:
 ```
 srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --partition=all /bin/bash
 ```
 The node you getyou need to remember.
 After that we need the command:
 ```
 conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-interactive -p /PATH/TO/merged_profiles/PROFILE.db -c /PATH/TO/contigs.db -C YOUR_COLLECTION
```
You open a new Terminal were you log in with your sunam and the node:
```
ssh -L 8060:localhost:8080 sunam###@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node###
```
Than you can open your interactive interface.
![image](images/Screenshot%202023-01-27%20at%2010-24-05%20Collection%20'consolidated%20bins'%20for%20merged%20profiles.png)

We wanted to visulized our Bins. Therefor we needed to look which Collections we have.
```
 anvi-estimate-genome-completeness -p ./merged_profiles/PROFILE.db -c ./contigs.db --list-collections
 ```


Than we visulized it in a table:
```
anvi-estimate-genome-completeness -c ./contigs.db -p ./merged_profiles/PROFILE.db -C METABAT
```
To safe the table you use the command above in addition with:
```
> genome_completeness_dastool.txt
```


Im only looking at METABAT collection. There was no other.

Questions:
1) Which binning strategy gives you the best quality for the Archaea bins??
2) How many Archaea bins do you get that are of High Quality? 
3) How many Bacteria bins do you get that are of High Quality?

Answers:

1) no answer possible because I only could look at the Metabat


### Bin refinement

List your collections:
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
```
Than we use anvi-summarize as displayed below.
```
anvi-summarize -c ./contigs.db -p /work_beegfs/sunam234/Day5/5_anvio_profiles/merged_profiles/PROFILE.db -C consolidated_bins -o SUMMARY --just-do-it
```
We looked at the .html file to see which folders are the right for our archaea. We focus only on the archaea bins, so we made a new folder 
```
mkdir ../../ARCHAEA_BIN_REFINEMENT
```
and copied all of our archaea .fa files inside.
```
cp /PATH/TO/BIN_FOLDER_INFO_FROM_ERR_FILE/*.fa /PATH/TO/ARCHAEA_BIN_REFINEMENT/o-it
```
### Chimera detection in MAGs (GUNC)

We need to activated a special conda enviroment to use the GUNC:
```
conda activate /home/sunam226/.conda/envs/gunc
```
Than we used the loop:
```
for i in *.fa; do gunc run -i "$i" -r /home/sunam226/Databases/gunc_db_progenomes2.1.dmnd --out_dir GUNC --threads 10 --detailed_output; done
```
Questions:
1) Do you get archaea bins that are chimeric?
   
hint: look at the CSS score (explained in the lecture) and the column PASS GUNC in the tables outputs per bin in your gunc_output folder.

2) In your own words (2 sentences max), explain what is a chimeric bin.

Answers:

1) For the Bin_Bin_1_sub it is only on the taxonomic levels of kingdom, phylum and class chimeric (close to 1). Its non chimeric for us!

1.1) And for the Bin_METABAT_25 it is on all taxonomic levels from kingdom to species chimeric (close to 1).

2) chimeric bin shows how different the species in the sample are. If its closer to 1 qou have multiple species.

### Manual bin refinement

First we needed a new node, therefore we run this command:
```
srun --reservation=biol217 --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 /bin/bash
```
Than we needed to activate conda on the node:
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
```
and do this command:
```
anvi-refine -c ./contigs.db -C consolidated_bins -p ./5_anvio_profiles/merged_profiles/PROFILE.db --bin-id Bin_METABAT__25
```

Open a new Terminal an ther log into the caucluster with the node:
```
ssh -L 8060:localhost:8080 sunam###@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node###
```
Than we can open our bins and sort it by GC content and by coverage ![image](images/Screenshot%202023-01-27%20at%2014-33-36%20Refining%20Bin_METABAT__25%20from%20consolidated_bins.png)


Questions:
1) Does the quality of your archaea improve?

hint: look at completeness redundancy in the interface of anvio and submit info of before and after

2) how abundant are the archaea bins in the 3 samples? (relative abundance)

Answer:

1) The quality of the archaea improved a bit. The completeness before was at ~97 and after 93,4 

2) Bin_METABAT_25
- 1.76
- 1.14
- 0.58

Bin_Bin_1_sub
- 0.96
- 0.00
- 0.40

### Taxonomic assigment

```
anvi-run-scg-taxonomy -c ./contigs.db -T 20 -P 2
```

```
anvi-estimate-scg-taxonomy -c ./contigs.db --metagenome-mode
```
Questions

1) Did you get a species assignment to the archaea bins previously identified?
2) Does the HIGH-QUALITY assignment of the bin need revision?
   
hint: MIMAG quality tiers

Answers:

1) For Bin_Metabat_25 it is *Methanoculleus sp012797575* 
   
   And for Bin_Bin_1_sub it is *Methanosarcina flavescens* 
2) 
