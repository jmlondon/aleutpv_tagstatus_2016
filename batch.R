if (Sys.info()['sysname'] == "Linux") {
  Sys.setenv(RSTUDIO_PANDOC = "/home/ec2-user/.local/bin/pandoc")
}

if (Sys.info()['sysname'] == "Linux") {
  setwd('/home/ec2-user/aleutpv_tagstatus_2016')
}

deployments <- readr::read_csv('data/deploy.csv')

for(i in 1:nrow(deployments)) {
  speno <- deployments$speno[i]
  spot_deployid <- deployments$spot_deployid[i]
  splash_deployid <- deployments$splash_deployid[i]
rmarkdown::render("aleutpv2016_status_report_by_speno.Rmd", 
                  output_file = paste0("www-aleutpv-2016//reports//",speno, "_status_report.html"),
params = list(
  speno = speno,
  spot_deployid = spot_deployid,
  splash_deployid = splash_deployid
))
}

rmarkdown::render("deploy_length.Rmd", 
                  output_file = "www-aleutpv-2016//deploy_length.html")

system("aws s3 sync www-aleutpv-2016 s3://www-aleutpv-2016")
