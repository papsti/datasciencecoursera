################
## Question 1

## used tutorials:
## https://github.com/r-lib/httr/blob/master/demo/oauth2-github.r
## https://towardsdatascience.com/accessing-data-from-github-api-using-r-3633fb62cb08?gi=a3061ea7bd4

library(httr)

## Get OAuth settings for github
oauth_endpoints("github")

## Load keys
load("keys.Rdata")

## Access my app
myapp <- oauth_app("github",
                   key = key,
                   secret = secret)

## Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)


## Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
## Take action on http error
stop_for_status(req)

## Extract content from a request
json1 <- content(req)

## Convert to a data.frame
git_data <- jsonlite::fromJSON(jsonlite::toJSON(json1))

## Subset data.frame to get desired info
git_data[git_data$full_name == "jtleek/datasharing", "created_at"]

################
## Question 2

## Download file
csv_filename <- "communities-idaho.csv"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              csv_filename,
              method="curl")

## Read file
acs <- read.csv(csv_filename)

################
## Question 4

## Connect to the website
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")

## Read lines of html code from website
html_code <- readLines(con)

## Close connection
close(con)

## Set lines of interest
lines <- c(10, 20, 30, 100)
lapply(lines, function(line){nchar(html_code[line])})

################
## Question 5

## Download file
filename <- "fixedwidth.for"
# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",
#               filename,
#               method="curl")

## Read data
fw_data <- read.fwf(filename,
                    widths = c(10,rep(c(5,4,1,3),4)),
                    skip = 4)

## Remove separator cols
fw_data <- fw_data[,-c(2,4,6,8,10,12,14,16)]

## Sum 4th of 9 cols in tidy data
sum(fw_data[,4])
