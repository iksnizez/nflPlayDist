library(DBI)
library(RMySQL)
library(jsonlite)
####################
## FUNCTION TO CONNECT TO DB
####################
nflDbConnect <- function(){
    # hard coded function to connect to harvest data base
    # no inputs are necessary
    # outputs the db connection
    
    ## import credentials
    path <- '../../Notes-General/config.txt'
    creds<-readLines(path)
    creds<-lapply(creds,fromJSON)
    
    dbUser <- creds[[1]]$mysqlSurface$users[2]
    dbPw <- creds[[1]]$mysqlSurface$creds$data
    dbHost <- creds[[1]]$mysqlSurface$db$host
    dbName <- creds[[1]]$mysqlSurface$db$database
    
    #connect to MySQL db    
    conn = DBI::dbConnect(RMySQL::MySQL(),
                          dbname=dbName,
                          host=dbHost,
                          port=3306,
                          user=dbUser,
                          password=dbPw)
    remove(dbUser)
    remove(dbPw)
    remove(dbHost)
    remove(dbName)
    remove(creds)
    
    return(conn)
}
#####