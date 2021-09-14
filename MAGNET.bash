# Magnet project
# Siavash Richard Moghadami
#------------------------------------------------------------------------------------------------
# Making an index file for Kallisto from Ensemble Genome Reference
#kallisto index -i /home/simoghad/genome_ref/genome/index/kallistoTX_homoSapien/Homo_sapiens.GRCh38.cdna.all.index /home/simoghad/genome_ref/genome/reference/homoSapien/Homo_sapiens.GRCh38.cdna.all.fa
#------------------------------------------------------------------------------------------------
# Download the fastq files
for i in {10676839..10677171}
do
/home/simoghad/sratoolkit.2.11.1-centos_linux64/bin/fasterq-dump-orig.2.11.1 SRR$i -O /oasis/tscc/scratch/simoghad/magnet/fastq -e 72

# Trim the fastq files
python3 /home/simoghad/.local/bin/cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -m 35 -q 15 -j 0 -o /oasis/tscc/scratch/simoghad/magnet/trimmed_fastq/trimmed_SRR$i"_1".fastq -p /oasis/tscc/scratch/simoghad/magnet/trimmed_fastq/trimmed_SRR$i"_2".fastq /oasis/tscc/scratch/simoghad/magnet/fastq/SRR$i"_1".fastq /oasis/tscc/scratch/simoghad/magnet/fastq/SRR$i"_2".fastq

# Quality check of the trimmed fastq files
/home/simoghad/FastQC/fastqc /oasis/tscc/scratch/simoghad/magnet/trimmed_fastq/*.fastq -t 72 --outdir=/home/simoghad/projects/magnet/qc

# Quantify the number of reads with kallisto
/home/simoghad/kallisto/kallisto quant -i /home/simoghad/genome_ref/genome/index/kallistoTX_homoSapien/Homo_sapiens.GRCh38.cdna.all.index -o /home/simoghad/projects/magnet/kallistoOut/SRR$i -t 72 --bias -b 100 /oasis/tscc/scratch/simoghad/magnet/trimmed_fastq/trimmed_SRR$i"_1".fastq /oasis/tscc/scratch/simoghad/magnet/trimmed_fastq/trimmed_SRR$i"_2".fastq &> /home/simoghad/projects/magnet/kallistoOut/SRR$i".log"

# Remove the fastq files
rm -r /oasis/tscc/scratch/simoghad/magnet/fastq/SRR$i"_1".fastq
rm -r /oasis/tscc/scratch/simoghad/magnet/fastq/SRR$i"_2".fastq
rm -r /oasis/tscc/scratch/simoghad/magnet/trimmed_fastq/trimmed_SRR$i"_1".fastq
rm -r /oasis/tscc/scratch/simoghad/magnet/trimmed_fastq/trimmed_SRR$i"_2".fastq

# Print the last sample accession number
echo "sample number $i is done!"
done
#------------------------------------------------------------------------------------------------
# Make a report
multiqc -d /home/simoghad/projects/magnet -o /home/simoghad/projects/magnet/report
