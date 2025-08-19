library(usethis)

# Function to initialize new repo (Positron-friendly, no .Rproj)
init_my_project <- function(path = ".", template_repo = NULL,
                            mode = c("full", "readme", "pr")) {
  mode <- match.arg(mode)

  # Load required packages
  if (!requireNamespace("usethis") | !requireNamespace("renv") | !requireNamespace("gitcreds")) {
    stop("Please install 'usethis', 'renv', and 'gitcreds' before running this function.")
  }

  path <- normalizePath(path, mustWork = FALSE)
  if (!dir.exists(path)) dir.create(path, recursive = TRUE)

  if (mode == "full") {
    # Step 1: Set working directory
    old_wd <- setwd(path)
    on.exit(setwd(old_wd))  # Reset when done

    # Step 2: Initialize Git and GitHub
    usethis::use_git()
    if (is.null(tryCatch(gitcreds::gitcreds_get()$username, error = function(e) NULL))) {
      usethis::create_github_token()
      gitcreds::gitcreds_set()
    }
    usethis::use_github()

    # Step 3: Create folder structure
    folders <- c("data", "doc", "results", "scripts")
    invisible(lapply(folders, dir.create, showWarnings = FALSE))

    # Step 4: Create .gitignore
    usethis::use_git_ignore(c(".Rhistory", ".RData", 
                              "renv/library/", "renv/staging/", ".DS_Store",
                              "data/", "doc/"))

    # Step 5: Initialize renv
    renv::init(bare = TRUE)
  }

  # Step 6: Copy templates from template_repo
  if (!is.null(template_repo)) {
    if (mode %in% c("full", "pr")) {
      pr_template <- file.path(template_repo, ".github")
      target_github <- file.path(path, ".github")
      
      if (dir.exists(pr_template)) {
        if (!dir.exists(target_github)) dir.create(target_github, recursive = TRUE)
        
        files_to_copy <- list.files(pr_template, all.files = TRUE, no.. = TRUE)
        for (f in files_to_copy) {
          from <- file.path(pr_template, f)
          to <- file.path(target_github, f)
          if (file.info(from)$isdir) {
            if (!dir.exists(to)) dir.create(to)
            file.copy(from, to, recursive = TRUE, overwrite = TRUE)
          } else {
            file.copy(from, to, overwrite = TRUE)
          }
        }
      }
    }
      
    if (mode %in% c("full", "readme")) {
      readme_template <- file.path(template_repo, "README_template.md")
      if (file.exists(readme_template)) {
        file.copy(readme_template, file.path(path, "README.md"), overwrite = TRUE)
      }
    }
  }

  message("✅ Mode '", mode, "' completed at: ", path)
}