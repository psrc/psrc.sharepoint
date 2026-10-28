# Read a delimited text file from SharePoint

The delimiter is inferred from the extension: `.csv` and `.txt` are
comma-delimited, and `.tab` is tab-delimited.

## Usage

``` r
read_txt(site, drive, filepath, ...)
```

## Arguments

- site:

  SharePoint site name used in the PSRC site URL.

- drive:

  SharePoint drive name.

- filepath:

  Path to the file within the drive.

- ...:

  Additional arguments passed to
  [`readr::read_delim()`](https://readr.tidyverse.org/reference/read_delim.html).

## Value

A tibble containing the file data.
