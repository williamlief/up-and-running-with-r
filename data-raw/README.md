# Raw Data

This is where the raw input data goes, think survey results from qualtrics,
student test scores, data files downloaded from department of education websites...

This file should be write-once / read only, meaning that once you add a file to 
this folder, you should never modify it. Instead, modification should happen in a 
cleaning script, and the new cleaned data should be saved to data-clean. This gives
you a reproducible history of you work.

## File Inventory:

Data used for this workshop comes from the [Stanford Education Data Archive](https://edopportunity.org).

- **seda_school_pool_gcs_v30.csv** - Datafile of school-level achievement variables
- **CORE_89_comp.csv** - Datafile of school-level covariates
- **seda_codebook_school_v30.xlsx** - Codebook for the school-level dataset
- **SEDA_documentation_v30_09212019.pdf** - Technical documentation for SEDA

