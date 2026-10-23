# psrc.sharepoint

Read and write files in PSRC SharePoint site Documents drives with a small set
of functions built on `Microsoft365R`.

```r
read_msxl(site, filepath, sheet = NULL, ...)
read_txt(site, filepath, ...)
write_msxl(x, site, filepath, sheet = "Sheet1", overwrite = TRUE)
write_txt(x, site, filepath, overwrite = TRUE, ...)
```

Text-file delimiters follow the file extension: `.csv` and `.txt` use commas,
and `.tab` uses tabs. The package connects to the PSRC tenant and the site's
`Documents` drive automatically. Temporary local copies are removed when each
function finishes. Excel reads support `.xls` and `.xlsx` workbooks. Writes
replace an existing destination by default; set `overwrite = FALSE` to refuse
an upload when that destination already exists.
