# Raw Data

This is where the raw input data goes, think survey results from qualtrics,
student test scores, data files downloaded from department of education websites...

This file should be write-once / read only, meaning that once you add a file to 
this folder, you should never modify it. Instead, modification should happen in a 
cleaning script, and the new cleaned data should be saved to data-clean. This gives
you a reproducible history of you work.
