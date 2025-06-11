library(usethis)

# Function to initialize new repo
init_my_project <- function(path = ".", template_repo = NULL,
                            mode = c("full", "readme", "pr")) {
  mode <- match.arg(mode)

  # Load required packages
  if (!requireNamespace("usethis") | !requireNamespace("renv") | !requireNamespace("gitcreds")) {
    stop("Please install 'usethis', 'renv', and 'gitcreds' before running this function.")
  }

  path <- normalizePath(path, mustWork = FALSE)

  if (mode == "full") {
    # Step 1: Create new RStudio project
    usethis::create_project(path, open = FALSE)

    # Set working directory to new project
    old_wd <- setwd(path)
    on.exit(setwd(old_wd))  # Reset when done

    # Step 2: Initialize Git and GitHub
    usethis::use_git()
    if (is.null(gitcreds::gitcreds_get()$username)) {
      usethis::create_github_token()
      gitcreds::gitcreds_set()
    }
    usethis::use_github()

    # Step 3: Create folder structure
    folders <- c("data", "doc", "results", "scripts")
    invisible(lapply(folders, dir.create, showWarnings = FALSE))

    # Step 4: Create .gitignore
    usethis::use_git_ignore(c(".Rhistory", ".RData", ".Rproj.user/",
                              "renv/library/", "renv/staging/", ".DS_Store",
                              "data/", "doc/"))

    # Step 5: Initialize renv
    renv::init(bare = TRUE)
  }

  # Step 6: Copy templates from template_repo
  if (!is.null(template_repo)) {
    if (mode %in% c("full", "pr")) {
      pr_template <- file.path(template_repo, ".github")
      if (dir.exists(pr_template)) {
        file.copy(pr_template, file.path(path, ".github"), recursive = TRUE)
      }
    }

    if (mode %in% c("full", "readme")) {
      readme_template <- file.path(template_repo, "README_template.md")
      if (file.exists(readme_template)) {
        file.copy(readme_template, file.path(path, "README.md"))
      }
    }
  }

  message("✅ Mode '", mode, "' completed at: ", path)
}
