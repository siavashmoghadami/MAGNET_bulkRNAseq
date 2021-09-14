# Download the fastq files using 72 threads
for i in {first accession number..last accession number}
do
/path/to/fasterq-dump SRR$i -O /path/to/output/fastq/files -e (number of threads)
done
