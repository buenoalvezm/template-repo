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

The function supports three modes to fit your workflow:

| Mode     | What it does                                                                                          | When to use                       |
| -------- | ----------------------------------------------------------------------------------------------------- | --------------------------------- |
| `full`   | Creates a new R project with Git/GitHub, folders, renv, `.gitignore`, and copies README + PR template | When starting a brand new project |
| `readme` | Copies the `README_template.md` as `README.md` into any existing project folder                       | To add or update the README file  |
| `pr`     | Copies the `.github/pull_request_template.md` folder into the project                                 | To add or update the PR template  |


### 📋 Example usage

```r
source("path/to/init_my_project.R")

# Full new project initialization
init_my_project("path/to/new_project", template_repo = "path/to/template-repo")

# Copy only README_template.md to existing project
init_my_project("path/to/existing_project", template_repo = "path/to/template-repo", mode = "readme")

# Copy only PR template folder to existing project
init_my_project("path/to/existing_project", template_repo = "path/to/template-repo", mode = "pr")
```


## ✍️ Author

María Bueno Álvez | maria.bueno@scilifelab.se
