# Collaboration project
# Siavash Richard Moghadami
#------------------------------------------------------------------------------------------------
# Making an index file for Kallisto from Ensemble Genome Reference
#/Applications/kallisto/kallisto index -i /Volumes/HDD/PublicationsSequencingDatasets/Fu_Nature2021-PTB/BulkRNA-seq/cDNAref/Homo_sapiens.GRCh38.cdna.all.index /Volumes/HDD/PublicationsSequencingDatasets/Fu_Nature2021-PTB/BulkRNA-seq/cDNAref/Homo_sapiens.GRCh38.cdna.all.fa
#------------------------------------------------------------------------------------------------
for i in {10676909..10677171}
do
/Applications/sratoolkit/bin/fasterq-dump SRR$i -O /Volumes/collaboration/fastq -e 12
~/.local/bin/cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -m 20 -j 12 -o /Volumes/collaboration/trimmed_fastq/trimmed_SRR$i"_1".fastq -p /Volumes/collaboration/trimmed_fastq/trimmed_SRR$i"_2".fastq /Volumes/collaboration/fastq/SRR$i"_1".fastq /Volumes/collaboration/fastq/SRR$i"_2".fastq
fastqc /Volumes/collaboration/trimmed_fastq/*.fastq -t 12 --outdir=/Volumes/collaboration/qc
/Applications/kallisto/kallisto quant -i /Volumes/collaboration/ref/Homo_sapiens.GRCh38.cdna.all.index -o /Volumes/collaboration/kallistoOut/SRR$i -t 16 -b 100 /Volumes/collaboration/trimmed_fastq/trimmed_SRR$i"_1".fastq /Volumes/collaboration/trimmed_fastq/trimmed_SRR$i"_2".fastq &> /Volumes/collaboration/kallistoOut/SRR$i".log"
rm -r /Volumes/collaboration/fastq/SRR$i"_1".fastq
rm -r /Volumes/collaboration/fastq/SRR$i"_2".fastq
rm -r /Volumes/collaboration/trimmed_fastq/trimmed_SRR$i"_1".fastq
rm -r /Volumes/collaboration/trimmed_fastq/trimmed_SRR$i"_2".fastq
echo "sample number $i"
done
#------------------------------------------------------------------------------------------------
multiqc -d /Volumes/collaboration/ -o /Volumes/collaboration/report
