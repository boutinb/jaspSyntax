context("dataSetInfo in forms")

# Forms bind to the `dataSetInfo` context property, e.g. `max: dataSetInfo.rowCount`. The bridge
# replaces its Workspace (which owns that object) on every unnamed loadDataSet, so the property
# has to follow it: otherwise it reads as null and the form rejects valid values.

rowCountQml <- function() testthat::test_path("fixtures", "minimalModule", "inst", "qml", "RowCountAnalysis.qml")

parseLag <- function(lag) {
  st <- jaspSyntax::loadQmlAndParseOptionsStatus("minimalModule", "rowCountFunc", rowCountQml(),
                                                 as.character(jsonlite::toJSON(list(lag = lag), auto_unbox = TRUE)),
                                                 "1", TRUE)
  jsonlite::fromJSON(st$options)$lag
}

test_that("dataSetInfo.rowCount follows the dataset loaded last", {
  tryCatch(
    {
      jaspSyntax::clearNativeState()
      jaspSyntax::setParameter("verbose", "none")
    },
    error = function(e) {
      testthat::skip(paste0("Native SyntaxInterface bridge unavailable: ", conditionMessage(e)))
    }
  )
  on.exit(jaspSyntax::clearNativeState(), add = TRUE)

  jaspSyntax::loadDataSet(data.frame(x = 1:3))
  expect_equal(parseLag(3), 3)
  expect_error(parseLag(4), "lag")

  # a second load replaces the Workspace: the form sees the new row count, not a dangling object
  jaspSyntax::loadDataSet(data.frame(x = 1:6))
  expect_equal(parseLag(5), 5)
  expect_error(parseLag(7), "lag")
})
