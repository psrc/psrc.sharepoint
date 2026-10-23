#' Connect to the site's Documents drive
#'
#' @param site SharePoint site name used in the PSRC site URL.
#'
#' @return A `microsoft365r` drive object.
#' @keywords internal
.get_documents_drive <- function(site) {
  site_url <- paste0("https://psrcwa.sharepoint.com/sites/", site)
  sharepoint_site <- Microsoft365R::get_sharepoint_site(
    site_url = site_url,
    tenant = "psrcwa.onmicrosoft.com"
  )
  sharepoint_site$get_drive("Documents")
}

#' Get a text file's delimiter from its extension
#'
#' CSV and TXT files are treated as comma-delimited; TAB files are treated as
#' tab-delimited.
#'
#' @param filepath SharePoint path to the file.
#'
#' @return A delimiter character.
#' @keywords internal
.text_delimiter <- function(filepath) {
  extension <- tolower(tools::file_ext(filepath))
  if (extension %in% c("csv", "txt")) {
    return(",")
  }
  if (identical(extension, "tab")) {
    return("\t")
  }
  stop("`filepath` must end in .csv, .txt, or .tab.", call. = FALSE)
}

#' Upload a file to the site's Documents drive
#'
#' @param drive SharePoint Documents drive.
#' @param src Local file path.
#' @param dest Destination path in the drive.
#' @param overwrite Replace the destination file if it already exists.
#'
#' @return The uploaded drive item, invisibly.
#' @keywords internal
.upload_file <- function(drive, src, dest, overwrite) {
  if (!is.logical(overwrite) || length(overwrite) != 1L || is.na(overwrite)) {
    stop("`overwrite` must be TRUE or FALSE.", call. = FALSE)
  }

  if (!overwrite) {
    remote_path <- gsub("\\\\", "/", dest)
    parent <- sub("/[^/]*$", "", remote_path)
    filename <- sub("^.*/", "", remote_path)
    if (!nzchar(parent) || identical(parent, remote_path)) {
      parent <- "/"
    }

    existing_files <- drive$list_items(path = parent, info = "name")
    if (tolower(filename) %in% tolower(existing_files)) {
      stop("Destination file already exists and `overwrite` is FALSE.",
        call. = FALSE
      )
    }
  }

  drive$upload_file(src = src, dest = dest)
}

#' Read an Excel workbook from SharePoint
#'
#' @param site SharePoint site name used in the PSRC site URL.
#' @param filepath Path to an `.xls` or `.xlsx` workbook within the site's
#'   Documents drive.
#' @param sheet Worksheet name or position; defaults to the first worksheet.
#' @param ... Additional arguments passed to [readxl::read_excel()].
#'
#' @return A tibble containing the worksheet data.
#' @export
read_msxl <- function(site, filepath, sheet = NULL, ...) {
  extension <- tolower(tools::file_ext(filepath))
  if (!extension %in% c("xls", "xlsx")) {
    stop("`filepath` must end in .xls or .xlsx.", call. = FALSE)
  }

  tmp <- tempfile(fileext = paste0(".", extension))
  on.exit(unlink(tmp), add = TRUE)

  .get_documents_drive(site)$get_item(filepath)$download(dest = tmp)
  readxl::read_excel(tmp, sheet = sheet, ...)
}

#' Read a delimited text file from SharePoint
#'
#' The delimiter is inferred from the extension: `.csv` and `.txt` are
#' comma-delimited, and `.tab` is tab-delimited.
#'
#' @param site SharePoint site name used in the PSRC site URL.
#' @param filepath Path to the file within the site's Documents drive.
#' @param ... Additional arguments passed to [readr::read_delim()].
#'
#' @return A tibble containing the file data.
#' @export
read_txt <- function(site, filepath, ...) {
  delim <- .text_delimiter(filepath)
  tmp <- tempfile(fileext = paste0(".", tolower(tools::file_ext(filepath))))
  on.exit(unlink(tmp), add = TRUE)

  .get_documents_drive(site)$get_item(filepath)$download(dest = tmp)
  readr::read_delim(file = tmp, delim = delim, ...)
}

#' Write a data frame to an Excel workbook on SharePoint
#'
#' @param x A data frame to write to the workbook.
#' @param site SharePoint site name used in the PSRC site URL.
#' @param filepath Destination path within the site's Documents drive.
#' @param sheet Worksheet name for `x`.
#' @param overwrite Replace the destination file if it already exists.
#'
#' @return `filepath`, invisibly.
#' @export
write_msxl <- function(x, site, filepath, sheet = "Sheet1", overwrite = TRUE) {
  tmp <- tempfile(fileext = ".xlsx")
  on.exit(unlink(tmp), add = TRUE)

  writexl::write_xlsx(stats::setNames(list(x), sheet), path = tmp)
  .upload_file(.get_documents_drive(site), tmp, filepath, overwrite)
  invisible(filepath)
}

#' Write a data frame to a delimited text file on SharePoint
#'
#' The delimiter is inferred from the extension: `.csv` and `.txt` are
#' comma-delimited, and `.tab` is tab-delimited.
#'
#' @param x A data frame to write to the file.
#' @param site SharePoint site name used in the PSRC site URL.
#' @param filepath Destination path within the site's Documents drive. The
#'   extension must be `.csv`, `.txt`, or `.tab`.
#' @param overwrite Replace the destination file if it already exists.
#' @param ... Additional arguments passed to [readr::write_delim()].
#'
#' @return `filepath`, invisibly.
#' @export
write_txt <- function(x, site, filepath, overwrite = TRUE, ...) {
  delim <- .text_delimiter(filepath)
  tmp <- tempfile(fileext = paste0(".", tolower(tools::file_ext(filepath))))
  on.exit(unlink(tmp), add = TRUE)

  readr::write_delim(x, file = tmp, delim = delim, ...)
  .upload_file(.get_documents_drive(site), tmp, filepath, overwrite)
  invisible(filepath)
}
