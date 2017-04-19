# Databases

You need to have the preformatted databases in a subdirectory named `databases/`

Available databases are:
### 16S
- SILVA ver. 128
- RDP ver. 11.5
- RDP V3-V4 ver. 11.5
### 18S
- Protista ver. 4.5

We recommend getting the [EzBioCloud](http://www.ezbiocloud.net/resources/pipelines) curated database, but since it is not publicly available (although it is free for academia), we cannot distributed it. If you get it, then you´ll have to formatted accordingly. You can use our script [db_reformatter.sh](https://github.com/GenomicaMicrob/db_reformatter).

Since the RDP database is to big and consumes a lot of time and memory, we have only the V3-V4 regions cut out from the original db, this is a lot faster, of course it only works if your sequences are from the V3 and/or V4 16S rRNA regions. Also the RDP db has many sequences (362,293) duplicated, it is now dereplicated (only one sequence of the identical ones was kept).  
