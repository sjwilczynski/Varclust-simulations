my_install <- function(package_name="", repo="https://cran.rstudio.com"){
  if(!require(package_name, character.only=TRUE)){
    install.packages(package_name, repos = repo)
  }
}

my_install("devtools")
if(!require("viridis")){
	devtools::install_github("sjmgarnier/viridis")
}
my_install("Hmisc")
my_install("knitr")
my_install("rmarkdown")
my_install("mclust")
my_install("testthat")
my_install("ClustOfVar")
my_install("RcppEigen")
my_install("doMC")
my_install("iterators")
my_install("parallel")
my_install("doParallel")
my_install("foreach")
my_install("xtable")
if(!require("impute")){
	source("https://bioconductor.org/biocLite.R")
	biocLite("impute")
}
my_install("PMA")
if(!require("pesel")){
  devtools::install_github("psobczyk/pesel")
}
if(!require("varclust")){
  devtools::install_github("psobczyk/varclust")
}

