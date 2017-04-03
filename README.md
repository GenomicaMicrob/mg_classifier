# mg_classifier
Super fast script for classifying metagenomic 16S/18S sequences
### version 1.4

mg_classifier assigns a taxonomy to 16S or 18S sequences produced by PCR amplification of metagenomic DNA. It can classify the sequences with several public databases.

### Dependencies
You will need the following scripts in you path:
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
We have preformated some databases that are publicly available:

16S rRNA
- [SILVA](https://www.arb-silva.de) ver. 128
- [RDP](http://rdp.cme.msu.edu/misc/resources.jsp) ver. 11.5

18S rRNA
- [Protist](https://figshare.com/articles/PR2_rRNA_gene_database/3803709) PR2 ver. 4.5

We recommend getting the [EzBioCloud](http://www.ezbiocloud.net/resources/pipelines) curated database, but since it is not publicly available (although it is free for academia), we cannot distributed it. If you get it, then you´ll have to formatted accordingly.

### Usage
Go to a folder where you have all your clean multifasta files of you samples and type:

`$ mg_classifier fasta`

You just have to type in the extension of you files (fasta or fna or fa, etc.) without the dot. It will present a menu where you can select a database to use. Since it is super fast, you probably don´t need to close the terminal, but i case you do, it will continue working as long as you do NOT cancel the process with Crtl Z. So, if you want to exit but leave it running, just close the terminal window.
