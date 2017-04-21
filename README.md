# mg_classifier
## Available soon

Super-fast script for classifying metagenomic 16S/18S sequences.
### version 1.0.0

mg_classifier assigns a taxonomy to 16S or 18S sequences produced by PCR amplification of metagenomic DNA. It can classify the sequences with several public databases.

### Dependencies
All necessary scripts are included in the `scripts/ ` subfolder:
- To cluster and classify sequences it relies on [vsearch](https://github.com/torognes/vsearch).
- If you are processing many samples (usual stuff) the script needs another little perl script called compile_classifications.pl.

### Download and install
The best way to get mg_classifier is to clone this repository directly to your linux:
1. Open a terminal and go to your prefered folder.
2. Type `git clone https://github.com/GenomicaMicrob/mg_classifier.git`, this will automatically download all basic files to a new folder called mg_classifier, except vsearch.
3. Make the install script executable: `chmod +x install.sh`.
3. Execute the script as superuser: `sudo ./install.sh`

The script will download a big file (~445 MB) with the databases into the appropiate folder and uncompress it. It will also make symbolic links (in `/usr/local/bin`) to the necessary scripts.

For the fast processing of data, mg_classifier has to have the database formatted in a certain way.

### Database format
The databases have to have the following format:

```
>accession:domain;phylum;class;order;family;genus;species
agtcgggcttaggtaaaaa
```
We have preformated some databases that are publicly available and can be also downloaded from [figshare](https://figshare.com/account/home#/projects/20254).

16S rRNA
- [SILVA](10.6084/m9.figshare.4814062) ver. 128 (see original [source](https://www.arb-silva.de))
- [RDP](10.6084/m9.figshare.4814959) ver. 11.5 (see original [source](http://rdp.cme.msu.edu/misc/resources.jsp))

18S rRNA
- [Protist](10.6084/m9.figshare.4814056) PR2 ver. 4.5 (see original [source](https://figshare.com/articles/PR2_rRNA_gene_database/3803709))

We recommend getting the [EzBioCloud](http://www.ezbiocloud.net/resources/pipelines) curated database, but since it is not publicly available (although it is free for academia), we cannot distributed it. If you get it, then you´ll have to formatted accordingly. You can use our script [db_reformatter.sh](https://github.com/GenomicaMicrob/db_reformatter).

### Usage
Go to a folder where you have all your clean multifasta files of you samples and type:

`$ ./mg_classifier.ver1.4.sh *.fasta`

If you want to classify only one or some files, you can type them:

`$ ./mg_classifier.ver1.4.sh file1.fasta file2.fna`

Afterwards, it will present a menu where you can select a database to use. Since it is super fast, you probably don't need to close the terminal, but i case you do, it will continue working as long as you do NOT cancel the process with `Crtl Z`. So, if you want to exit but leave it running, just close the terminal window.

### Output
mg_classifier will produce four files:
- **otus.tsv** A file containing the taxonomy and numbers of sequences per sample.
- **otus.spf** A file that can be opened directly by [STAMP](http://kiwi.cs.dal.ca/Software/STAMP).
- **OTUs_taxon.tsv** Information of how many hits per taxonomic level per sample.
- **mgclassifier.log** A log file.

All files are separated by tab, so they can be also opened with Excel.

**Example** of the otus file:
```
%Id;domain;phylum;class;order;family;genus;species	F3D0	F3D150	F3D9	mock
88.5;Bacteria;Firmicutes;Bacilli;Bacillales;Staphylococcaceae;Unclassified_g;Unclassified_s	0	0	0	616
96.4;Bacteria;Firmicutes;Clostridia;Clostridiales;Lachnospiraceae;Clostridium_g24;Unclassified_s	0	3	0	0
96.9;Bacteria;Firmicutes;Clostridia;Clostridiales;Lachnospiraceae;Eisenbergiella;Unclassified_s	52	0	0	0
96.9;Bacteria;Firmicutes;Clostridia;Clostridiales;Lachnospiraceae;HM123979_g;Unclassified_s	0	2	0	0
97>;Bacteria;Actinobacteria;Actinobacteria_c;Propionibacteriales;Propionibacteriaceae;Propionibacterium;Propionibacterium_acnes	0	0	0	3
97>;Bacteria;Actinobacteria;Coriobacteriia;Coriobacteriales;Coriobacteriaceae;EF099352_g;EF099352_s	3	0	0	0


```
Four samples were classified; the first column has the percentage of similitud of the representative sequence from a cluster to the assigned sequences in the database; then the taxonomy assigned to that cluster, and finally the number of sequences in that cluster per sample. Samples are from P. Schloss [Miseq SOP webpage](https://www.mothur.org/wiki/MiSeq_SOP).

Threshold values for delimiting a taxon were taken from [Yarza et al. 2014. Nat Rev Microbiol 12:635-645](http://www.nature.com/nrmicro/journal/v12/n9/full/nrmicro3330.html).

### How fast?
22,267 16S V4 sequences (mean length 228.7 bases, 5.18 million bases) in 4 files were classified in a 64 core 128 GB RAM Dell PowerEdge R810 server with the following results:

| Database | DB size (MB) | Time (min) |
| --- | ---: | ---:|
| EzBioCloud_v1.5 | 96.6 | **0:22** |
| SILVA_v128 | 303.4 | **1:11** |
| RDP_v11.5 | 3,200.0 | **12:11** |
| RDP_v11.5 V3-V4 | 1,066.5 | **3:16** |

Time depends on many factors, most notably:
- **Size of the database**.
- Sequences per sample.
- Mean size of the sequences.
- Not so the number of samples, as samples are processed simultanously; the number of cores of the server is the limiting factor here.
- A big constrain might be the RAM memory available since it will upload to the memory the database, once per sample. So, if you process 10 samples with the 1 GB RDP_V3-V4 databse, you´ll need about 10 GB of RAM.
