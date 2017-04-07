# mg_classifier
**Available soon**

Super-fast script for classifying metagenomic 16S/18S sequences.
### version 1.0.0

mg_classifier assigns a taxonomy to 16S or 18S sequences produced by PCR amplification of metagenomic DNA. It can classify the sequences with several public databases.

### Dependencies
You will need to install **vsearch**, to do so, please follow the instructions in the vsearch github [webpage](https://github.com/torognes/vsearch).

Other scripts are included, although you might want them to be in you [PATH](http://www.troubleshooters.com/linux/prepostpath.htm); you can do this by copying them to /usr/bin (you will need superuser authorization for this, example: `sudo cp fastagrep.pl /usr/bin`) after they have been made executable (see below).
- To cluster and classify sequences it relies on [vsearch](https://github.com/torognes/vsearch).
- [fastagrep](http://nebc.nerc.ac.uk/nebc_website_frozen/nebc.nerc.ac.uk//tools/code-corner/scripts/sequence-formatting-and-other-text-manipulation.html#-ace_split-pl) which is included in the `scripts/ ` subfolder.
- If you are processing many samples (usual stuff) the script needs another little perl script called compile_classifications.pl, also included in the `scripts/ ` subfolder.

### Download and install
The best way to get mg_classifier is to clone this repository directly to your linux:
1. Open a terminal and go to your prefered folder.
2. Type `git clone https://github.com/GenomicaMicrob/mg_classifier.git`, this will automatically download all basic files to a new folder called mg_classifier, except vsearch.
3. Make all scripts executable: `chmod +x mgclassifier/*.sh mgclassifier/scripts/*.pl`.
3. Download the databases; change to the created folder `cd mg_classifier` and execute the script to start the download of the three databases from figshare: `./download_dbs.sh`. The script will download a 445 MB file into the appropiate folder and uncompress it.

For the fast processing of data, mg_classifier has to have the database formatted in a certain way.

### Database format
The databases have to have the following format:

```
>accession:domain;phylum;class;order;family;genus;species
agtcgggcttaggtaaaaa
```
We have preformated some databases that are publicly available and can be also downloaded from [figshare](https://figshare.com/account/home#/projects/20254).

16S rRNA
- [SILVA](10.6084/m9.figshare.4814062) ver. 128, 48.3 MB (see original [source](https://www.arb-silva.de))
- [RDP](10.6084/m9.figshare.4814959) ver. 11.5, 311.5 MB (see original [source](http://rdp.cme.msu.edu/misc/resources.jsp))

18S rRNA
- [Protist](10.6084/m9.figshare.4814056) PR2 ver. 4.5, 20.4 MB (see original [source](https://figshare.com/articles/PR2_rRNA_gene_database/3803709))

We recommend getting the [EzBioCloud](http://www.ezbiocloud.net/resources/pipelines) curated database, but since it is not publicly available (although it is free for academia), we cannot distributed it. If you get it, then you´ll have to formatted accordingly. You can use our script [db_reformatter.sh](https://github.com/GenomicaMicrob/db_reformatter).

### Usage
Go to a folder where you have all your clean multifasta files of you samples and type:

`$ ./mg_classifier.ver1.4.sh *.fasta`

If you want to classify only one or some files, you can type them:

`$ ./mg_classifier.ver1.4.sh file1.fasta file2.fna`

Afterwards, it will present a menu where you can select a database to use. Since it is super fast, you probably don´t need to close the terminal, but i case you do, it will continue working as long as you do NOT cancel the process with `Crtl Z`. So, if you want to exit but leave it running, just close the terminal window.

### Output
mg_classifier will produce four files:
- **otus.tsv** A file containing the taxonomy and numbers of sequences per sample.
- **Bacteria_otus.spf** An file with only the sequences assigned to Bacteria that can be opened directly by [STAMP](http://kiwi.cs.dal.ca/Software/STAMP).
- **OTUs_taxon.tsv** Information of how many hits per taxonomic level per sample.
- **mgclassifier.log** A log file.

All files are separated by tab, so they can be also opened with Excel.

**Example** of the otus file:
```
%Id;domain;phylum;class;order;family;genus;species	F3D0	F3D9	mock
88.3;Bacteria;Firmicutes;Clostridia;Clostridiales;Clostridiaceae;Unclassified_g;Unclassified_s	2	0	0
88.5;Bacteria;Firmicutes;Bacilli;Bacillales;Staphylococcaceae;Unclassified_g;Unclassified_s	0	0	621
96.9;Bacteria;Firmicutes;Clostridia;Clostridiales;Ruminococcaceae;Pseudoflavonifractor;Unclassified_s	6	0	0
97>;Bacteria;Firmicutes;Bacilli;Bacillales;Bacillaceae;Bacillus;Bacillus_bingmayongensis	0	0	382
97>;Bacteria;Bacteroidetes;Bacteroidia;Bacteroidales;S24-7_f;FJ879262_g;EF100028_s	66	9	0

```
Three samples were classified; the first column has the percentage of similitud of the representative sequence from a cluster to the database; then the taxonomy assigned to that cluster, and finally the number of sequences in that cluster per sample. Samples are from P. Schloss [Miseq SOP webpage](https://www.mothur.org/wiki/MiSeq_SOP).

Threshold values for delimiting a taxon were taken from [Yarza et al. 2014. Nat Rev Microbiol 12:635-645](http://www.nature.com/nrmicro/journal/v12/n9/full/nrmicro3330.html).

### How fast?
18,882 16S V4 sequences (mean length 232.6 bases, 4.35 million bases) in 3 files were classified in a 64 core 128 GB RAM Dell PowerEdge R810 server with the following results:

| Database | DB size (MB) | Time |
| --- | ---: | ---:|
| EzBioCloud-1.5 | 96.6 | **7 sec** |
| SILVA_128 | 303.4 | **25 sec** |
| RDP_11.5 | 3,800.0 | **5:33 min** |

Time depends on many factors, most notably:
- **Size of the database**.
- Sequences per sample.
- Mean size of the sequences.
- Not so the number of samples, as samples are processed simultanously; the number of cores of the server is the limiting factor here.
