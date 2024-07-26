# Old Setup
Only a- and m- oriented samples:
- 3 scans for 2 different azimuths
- one file for 1st three scans; another file for 2nd three scans; 3rd file for combining both
- for every scan, there are the film and substrate positions extracted
- each file can be run on its own and by the "parent" (3rd) file, which then deactivates some function features

Wanted _Improvements_:
- Deconvolute value extraction and plotting the RSM's
    - external file?
- why is 1st input of `correctReciprocalData` not a vector?
- {no Prio} functionize the 2x3-axes plotting