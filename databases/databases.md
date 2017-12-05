# Databases

You need to have the preformatted databases in a subdirectory named `/mg_pipeline/databases/`

Available databases are:
### 16S
- SILVA ver. 128
- RDP ver. 11.5
- RDP V3-V4 ver. 11.5
### 18S
- Protista ver. 4.5

We recommend getting the [EzBioCloud](http://www.ezbiocloud.net/resources/pipelines) curated database, but since it is not publicly available (although it is free for academia), we cannot distributed it. If you get it, then you´ll have to formatted accordingly. You can use our script [db_reformatter.sh](https://github.com/GenomicaMicrob/db_reformatter)

Since the RDP database is to big and consumes a lot of time and memory, we have only the V3-V4 regions cut out from the original db, this is a lot faster, of course it only works if your sequences are from the V3 and/or V4 16S rRNA regions. Also the RDP db has many sequences (362,293) duplicated, it is now dereplicated (only one sequence of the identical ones was kept).  

A much quicker analysis is done if the databases are converted to [UDB](https://www.drive5.com/usearch/manual/udb_files.html) format (a UDB file is a database file that contains the sequences and a [k-mer index](https://en.wikipedia.org/wiki/K-mer) for those sequences). These type of databases a considerably bigger than the fasta file used to generate it (56 Mb vs. 471 Mb for the SILVA-128 db), therefore, it is best to download the fasta file and then convert it.

To convert the fasta file with vsearch 2.5.0 just type:
`vsearch --makeudb_usearch file.fasta --output file.udb`

Keep both the fasta and the udb files, since mg_classifer can use both, but chimera_detector only the fasta file. This inconvenience has to be with the algorithm that vsearch uses to identify chimeric sequences.
