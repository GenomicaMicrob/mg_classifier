# mg_classifier
Super fast script for classifying metagenomic 16S/18S sequences

mg_classifier assigns a taxonomy to 16S or 18S sequences produced by PCR amplification of metagenomic DNA. It can classify the sequences with several public databases.

### Dependencies
To cluster and classify sequences it relies on [vsearch](https://github.com/torognes/vsearch), you have to put it in your path.
Of course, you will also need a database, for the fast processing of data, mg_classifier has to have the database formatted accordingly.

### Databse format
The databses have to have the following format:
```
