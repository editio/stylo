# Para contruir el "paquete"

remotes::install_github("karthik/holepunch", force = TRUE)
# https://github.com/karthik/holepunch
library(holepunch)
write_compendium_description(package = "stylo course", 
                             description = "stylo scripts")
# to write a description, with dependencies listed 
# It's good practice to now go fill in the placeholder text.

write_dockerfile(maintainer = "editio.github.io")
# To write a dockerfile. It will automatically pick the date of the last modified file, match it to 
# that version of R and add it here. You can override this by passing r_date to some arbitrary date
# (but one for which a R version exists).

d = generate_badge()
# This generates a badge for your readme.

# At this time 🙌 push the code to GitHub 🙌
# If you're new to Git/GitHub, you can click the Git tab on Rstudio, then click commit to see
# all changed files/folders, including the hidden .binder folder. Give this a commmit message and push

# And click on the badge or use the function below to get the binder built ahead of time.
build_binder()
# 🤞🚀

# Now, run through analysis.R till you get to a plot

# Para el Error: Cannot write a Dockerfile without a Git remote. Connect this to a git remote before generating a Dockerfile
# https://github.com/karthik/binder-test/issues/2