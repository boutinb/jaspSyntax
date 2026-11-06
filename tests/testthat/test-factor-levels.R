context("factor levels")

test_that("a factor keeps the order of its levels in the bridge", {
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

  dataset <- data.frame(
    activity = factor(c("High", "Low", "Sedentary", "Medium", "High"), levels = c("Sedentary", "Low", "Medium", "High", "Unused")),
    letters  = c("b", "c", "a", "b", "a")
  )
  jaspSyntax::loadDataSet(dataset)

  loaded <- jaspSyntax::readLoadedDataset(normalize = FALSE)

  # levels without values do not become labels
  expect_identical(levels(loaded$activity), c("Sedentary", "Low", "Medium", "High"))
  expect_identical(as.character(loaded$activity), as.character(dataset$activity))
  # a column that is no factor still gets its labels ordered by value
  expect_identical(levels(loaded$letters), c("a", "b", "c"))
})
