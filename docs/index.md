# psrc.sharepoint

Read and write files in PSRC SharePoint site drives with a small set of
functions built on `Microsoft365R`.

\
[`read_msxl`](https://psrc.github.io/psrc.sharepoint/reference/read_msxl.md)`(``site``, ``drive``, ``filepath``, sheet ``=`` ``NULL``, ``...``)`\
[`read_txt`](https://psrc.github.io/psrc.sharepoint/reference/read_txt.md)`(``site``, ``drive``, ``filepath``, ``...``)`\
[`write_msxl`](https://psrc.github.io/psrc.sharepoint/reference/write_msxl.md)`(``x``, ``site``, ``drive``, ``filepath``, sheet ``=`` ``"Sheet1"``, overwrite ``=`` ``TRUE``)`\
[`write_txt`](https://psrc.github.io/psrc.sharepoint/reference/write_txt.md)`(``x``, ``site``, ``drive``, ``filepath``, overwrite ``=`` ``TRUE``, ``...``)`

Text-file delimiters follow the file extension: `.csv` and `.txt` use
commas, and `.tab` uses tabs. The package connects to the PSRC tenant
and the specified drive in each site. Temporary local copies are removed
when each function finishes. Excel reads support `.xls` and `.xlsx`
workbooks. Writes replace an existing destination by default; set
`overwrite = FALSE` to refuse an upload when that destination already
exists.
