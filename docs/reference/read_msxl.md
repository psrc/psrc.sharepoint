# Read an Excel workbook from SharePoint

Read an Excel workbook from SharePoint

## Usage

``` r
read_msxl(site, drive, filepath, sheet = NULL, ...)
```

## Arguments

- site:

  SharePoint site name used in the PSRC site URL.

- drive:

  SharePoint drive name.

- filepath:

  Path to an `.xls` or `.xlsx` workbook within the drive.

- sheet:

  Worksheet name or position; defaults to the first worksheet.

- ...:

  Additional arguments passed to
  [`readxl::read_excel()`](https://readxl.tidyverse.org/reference/read_excel.html).

## Value

A tibble containing the worksheet data.
