# Template repo for project initialization

This repository contains reusable resources to help me set up new R projects efficiently and reproducibly.

## 📦 Included

- `init_my_project.R`: script to initialize a project with my prefered folder structure, Git, GitHub, renv, and gitignore
- `.github/pull_request_template.md`: default pull request template
- `README_template.md`: markdown template for new project README files

## 🚀 How to Use

1. Clone this repo or download it locally
2. Source the `init_my_project.R` script in your R console
3. Run the function to create a new project

```r
source("path/to/init_my_project.R")
init_my_project(path = "my/new/project", template_repo = "path/to/template-repo")
```

This will:
- Create the project directory
- Set up Git/GitHub and folders
- Copy README and PR template
- Initialize renv

## ✍️ Author

María Bueno Álvez | maria.bueno@scilifelab.se