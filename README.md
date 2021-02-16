

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4540232.svg)](https://doi.org/10.5281/zenodo.4540232)


# A sequence of programs to readin in County Business Pattern data from the US Census Bureau

These programs have been used since at least 2001 in order to read in raw [County Business Pattern](https://www.census.gov/programs-surveys/cbp.html) data from the US Census Bureau. They have been updated over the years, and may be functionally superseded by the more modern [Census Bureau API](https://www.census.gov/data/developers.html), but they still allow to readin several decades of data in bulk.

Written and maintained over the years by Lars Vilhuber, Cornell University.

## Caveat

The format of the raw data changed with the 2017 release, and will not work with the present code.

## Requirements

The programs are meant to be run on a Linux system with Stata installed, but are likely to run on any system with `bash` (untested). `bash` is only used for bulk download.

## Configuring the programs

The `config.do` has hard-coded the last year of data, allowing the user to control which data to pull. Edit it before starting.

You will need to adjust directory structure to suit your needs.

## Running programs

All programs are run from the `programs/` directory.

Download the ZIP files needed:

```{bash}
./01_get_data.sh YEAR
```
where YEAR = 19xx or 20xx (the actual four-digit year).

Read in the national, county, and MSA files, and concatenate into a single standardized file:

```{bash}
stata -b do 10_read_cbp.do
stata -b do 11_read_cbp_cty.do
stata -b do 12_read_cbp_msa.do
```

Optionally output to CSV and SAS format (requires SAS)

```{bash}
stata -b do 13_export_cbp.do
sas 19_convert_to_sas.sas
```


## License

These programs are provided as-is, with no warranty that they are right, meaningful, or useful. See [LICENSE](LICENSE).

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  
