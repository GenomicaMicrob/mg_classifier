# mg_classifier
**Available soon**

Super fast script for classifying metagenomic 16S/18S sequences
### version 1.4

mg_classifier assigns a taxonomy to 16S or 18S sequences produced by PCR amplification of metagenomic DNA. It can classify the sequences with several public databases.

### Dependencies
You will need the following scripts in you [PATH](http://www.troubleshooters.com/linux/prepostpath.htm); or just download them and move them to /usr/bin (you will need superuser authorization for this, example: `sudo mv vsearch /usr/bin`.
- To cluster and classify sequences it relies on [vsearch](https://github.com/torognes/vsearch).
- [fastagrep](http://search.cpan.org/~jwb/Bio-Gonzales-0.05/bin/fagrep).
- If you are processing many samples (usual stuff) the script needs another little perl script called compile_classifications.pl.

Of course, you will also need a database, for the fast processing of data, mg_classifier has to have the database formatted in a certain way.

### Database format
The databases have to have the following format:

```
>accession:domain;phylum;class;order;family;genus;species
agtcgggcttaggtaaaaa
```
We have preformated some databases that are publicly available and can be downloaded from figshare (**soon**):

16S rRNA
- [SILVA] ver. 128, 48.3 MB (see original [source](https://www.arb-silva.de))
- [RDP] ver. 11.5, 311.5 MB (see original [source](http://rdp.cme.msu.edu/misc/resources.jsp))

18S rRNA
- [Protist] PR2 ver. 4.5, 20.4 MB (see original [source](https://figshare.com/articles/PR2_rRNA_gene_database/3803709))
### Database download

1. Create a subdirectory `mkdir db` within the directory where mg_classifier is placed
2. Download the databases to db/ from figshare
3. Uncompress the databases `gzip -d database.gz`

We recommend getting the [EzBioCloud](http://www.ezbiocloud.net/resources/pipelines) curated database, but since it is not publicly available (although it is free for academia), we cannot distributed it. If you get it, then you´ll have to formatted accordingly. You can use our script [db_reformatter.sh](https://github.com/GenomicaMicrob/db_reformatter).

### Usage
Go to a folder where you have all your clean multifasta files of you samples and type:

`$ mg_classifier fasta`

You just have to type in the extension of you files (fasta or fna or fa, etc.) without the dot. It will present a menu where you can select a database to use. Since it is super fast, you probably don´t need to close the terminal, but i case you do, it will continue working as long as you do NOT cancel the process with Crtl Z. So, if you want to exit but leave it running, just close the terminal window.
