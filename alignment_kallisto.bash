# Making an index file for Kallisto from Ensemble transcriptome Reference
#kallisto index -i /path/to/index/Homo_sapiens.GRCh38.cdna.all.index /path/to/transcriptome_ref/Homo_sapiens.GRCh38.cdna.all.fa

# Quantify the number of reads with kallisto for paired-end fastq files
for i in {first accession number..last accession number}
kallisto quant -i /path/to/index/Homo_sapiens.GRCh38.cdna.all.index -o /path/to/output/SRR$i -t number_of_threads --bias -b number_of_bootstraps \
/path/to/trimmed_fastq1/trimmed_SRR$i"_1".fastq /path/to/trimmed_fastq2/trimmed_SRR$i"_2".fastq &> /path/to/log/SRR$i".log"
done

# Make a report with multiqc
multiqc -d /path/to/project -o /path/to/output
