context("Factor levels of a .jasp dataset")

# puppies.jasp of jaspAnova without its results: Dose is a nominal column whose levels are not in alphabetical order.
puppiesFixture <- function() {
  testthat::test_path("fixtures", "jasp-files", "puppies-levels.jasp")
}

doseLevels <- c("No puppies", "15 mins", "30 mins")

test_that("readDatasetFromJaspFile gives nominal columns as factors in the level order of the file", {
  dataset <- jaspSyntax::readDatasetFromJaspFile(puppiesFixture())

  expect_s3_class(dataset$Dose, "factor")
  expect_false(is.ordered(dataset$Dose))
  expect_identical(levels(dataset$Dose), doseLevels)
  expect_identical(as.character(dataset$Dose[c(1, 6, 11)]), doseLevels)
  expect_type(dataset$Happiness, "double")
})

test_that("a .jasp dataset keeps its level order when it is loaded again", {
  dataset <- jaspSyntax::readDatasetFromJaspFile(puppiesFixture())

  on.exit(jaspSyntax::clearNativeState(), add = TRUE)
  jaspSyntax::clearDatasetState()
  jaspSyntax::loadDataSet(dataset)

  expect_identical(levels(jaspSyntax::readLoadedDataset(normalize = FALSE)$Dose), doseLevels)
})
