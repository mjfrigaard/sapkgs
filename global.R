install.packages('rsconnect')
pkgs <- rsconnect:::appDependencies()[['Package']]
install.packages(pkgs, quiet = TRUE)
