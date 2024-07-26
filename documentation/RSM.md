# `RSM_streamline` branch
## Old Setup
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

## Improving m-orientation

Renaming the two distinct directions:
`cPar` instead of `306` and `cPerp` instead of `220`.

Modular Stages
1. `getRSMLattice(Id)`: parental plotting function comes with Id as **input** and wants to have all lattice information as **output**
    - for every Id there are several RSM measurements
    - check out which plane we have, then the expected output is clear (e.g. for m-orientation: two equivalent out-of-plane constants and two distinct in-plane constants)
    - it is also clear which planes are needed for calculation (e.g. c-in-plane needs 306 and 30-6 peaks)
    - check if these planes were measured and get data:
    2. `getRSMData(Id,plane)`
        - this function checks if `Id/XRD_RSM/` exists
            - otherwise: nan, nan
        - check if `Id/XRD_RSM/plane` exists
            - otherwise: nan, nan
        - `plane.txt`
            - contains in 1st row seperated substrate peak and in 2nd row seperated film peak
            - 1st row: `xSub ySub`
            - 2nd row: `xFilm yFilm`
        - **output** vectors of substrate, vectors of thin film
    - with the data, the tilt can be calculated and then the lattice constants, depending on orientation

