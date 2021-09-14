#Paired-end trimming with cutadapt
for i in {first accession number..last accession number}
cutadapt -a forward_adapter_sequence -A reverse_adapter_sequence -m minimum_acceptable_read_length -q minimum_acceptable_quality_score -j maximum_number_of_threads\
-o /path/to/output1/trimmed_SRR$i"_1".fastq -p /path/to/output1/trimmed_SRR$i"_2".fastq \
/path/to/fastq1/SRR$i"_1".fastq /path/to/fastq1/SRR$i"_2".fastq
done
