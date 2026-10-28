# Write a data frame to a delimited text file on SharePoint

The delimiter is inferred from the extension: `.csv` and `.txt` are
comma-delimited, and `.tab` is tab-delimited.

## Usage

``` r
write_txt(x, site, drive, filepath, overwrite = TRUE, ...)
```

## Arguments

- x:

  A data frame to write to the file.

- site:

  SharePoint site name used in the PSRC site URL.

- drive:

  SharePoint drive name.

- filepath:

  Destination path within the drive. The extension must be `.csv`,
  `.txt`, or `.tab`.

- overwrite:

  Replace the destination file if it already exists.

- ...:

  Additional arguments passed to
  [`readr::write_delim()`](https://readr.tidyverse.org/reference/write_delim.html).

## Value

`filepath`, invisibly.
