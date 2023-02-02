# Day4
### From bins to species and abundance estimation

First thing was, that we have to use a other anvio run. It is:
```
source activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1
```
We made an anvio contigs-db database with key information associated with sequences.
```
anvi-gen-contigs-database -f /work_beegfs/sunam234/Day_3/3_coassembly/contigs.anvio.fa -o /work_beegfs/sunam234/Day_3/5_anvio-profile/contigs.db -n 'biol217'
```

After that we need to run the command to performe an HMM:
```
anvi-run-hmms -c /work_beegfs/sunam234/Day_3/5_anvio-profile/contigs.db
```
To view the simple stats of your contigs database, we have to open a new Terminal at the super computer and do there:
```
srun --pty --mem=10G --nodes=1 --tasks-per-node=1 --cpus-per-task=1 --partition=all /bin/bash
```
to get a node and command
```
conda activate /home/sunam225/miniconda3/miniconda4.9.2/usr/etc/profile.d/conda.sh/envs/anvio-7.1

anvi-display-contigs-stats contigs.db
```
Than we open again a new Terminal to view the parameters:
```
ssh -L 8060:localhost:8080 sunam###@caucluster-old.rz.uni-kiel.de
ssh -L 8080:localhost:8080 node###
```
When you are logged in you can open the link to see your data.


### Binning with ANVIO

We put the whole Data in ANVIO now:
```
cd /work_beegfs/sunam234/Day_3/4_mapping/4_mapping/
for i in *.bam; do anvi-init-bam $i -o /work_beegfs/sunam234/Day_3/5_anvio-profile/"$i".sorted.bam; done
```
And created from all samples an ANVIO Profile
```
cd /work_beegfs/sunam234/Day_3/5_anvio-profile/
anvi-merge ./profiling/BGR_130305/PROFILE.db ./profiling//BGR_130527/PROFILE.db ./profiling//BGR_130708/PROFILE.db -o ./merged_profiles -c /work_beegfs/sunam234/Day_3/5_anvio-profile/contigs.db --enforce-hierarchical-clustering
```
Binning Metabat2 with the command:
```
anvi-cluster-contigs -p ./merged_profiles/PROFILE.db -c ./contigs.db -C METABAT --driver metabat2 --just-do-it --log-file log-metabat2


anvi-summarize -p ./merged_profiles/PROFILE.db -c ./contigs.db -o SUMMARY_METABAT -C METABAT
```
And binning with Concoct:
```
anvi-cluster-contigs -p ./merged_profiles/PROFILE.db -c ./contigs.db -C CONCOCT --driver concoct --just-do-it

anvi-summarize -p ./merged_profiles/PROFILE.db -c ./contigs.db -o SUMMARY_CONCOCT -C CONCOCT
```

# Questions
Number of Archaea bins you got from MetaBAT2?

Number of Archaea bins you got from CONCOCT?

Number of Archaea bins you got after consolidating the bins?

### Answer
1) 3 Archaea
2) 2 Archaea
3) 2 Archaea