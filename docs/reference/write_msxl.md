# Write a data frame to an Excel workbook on SharePoint

Write a data frame to an Excel workbook on SharePoint

## Usage

``` r
write_msxl(x, site, drive, filepath, sheet = "Sheet1", overwrite = TRUE)
```

## Arguments

- x:

  A data frame to write to the workbook.

- site:

  SharePoint site name used in the PSRC site URL.

- drive:

  SharePoint drive name.

- filepath:

  Destination path within the drive.

- sheet:

  Worksheet name for `x`.

- overwrite:

  Replace the destination file if it already exists.

## Value

`filepath`, invisibly.
