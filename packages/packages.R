my_install <- function(package_name="", repo="https://cran.rstudio.com"){
  if(!require(package_name, character.only=TRUE)){
    install.packages(package_name, repos = repo)
  }
}

my_install("devtools")
my_install("knitr")
my_install("rmarkdown")
my_install("mclust")
my_install("testthat")
my_install("ClustOfVar")
my_install("RcppEigen")
my_install("doRNG")
my_install("parallel")
my_install("doParallel")
my_install("foreach")
my_install("xtable")
if(!require("pesel")){
  devtools::install_github("psobczyk/pesel")
}
if(!require("varclust")){
  devtools::install_github("psobczyk/varclust")
}
