library(usethis)

# Create R project
repo_path <- getwd()
usethis::create_project(repo_path)  # Change to your desired path

# Set up Git
usethis::use_git()        # Initializes Git and commits

# Set up GitHub
usethis::create_github_token()
gitcreds::gitcreds_set()
usethis::use_github()     # Creates GitHub repo and connects it (at least one commit is needed!)

# Create repo structure
folders <- c("doc", "scripts", "results", "data")
invisible(lapply(folders, dir.create, showWarnings = FALSE))

# Create gitignore file
usethis::use_git_ignore(c(".Rhistory", ".RData", ".Rproj.user/", "renv/library/", "renv/staging/", ".DS_Store", "data/", "doc/"))

# Initialize renv
renv::init()
