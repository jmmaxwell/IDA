library(RODBC)
library(data.table)
library(reshape2)

data = c()
for (i in 1:5){
  
  #last digit in year
  l.dig = i+6
  yr = c()
  if (l.dig > 9) {
    yr = paste("20", l.dig, sep = "")} else yr = paste("200", l.dig, sep = "")
  
  # set db file path
  db = file.path(paste("C:/Users/jmmaxwell/Desktop/Output/", yr, "Output.accdb", sep = ""))

  # connect to db
  channel = odbcConnectAccess2007(db)

  datalist = list()
  
  # use SQL command to fetch data
  datalist[[i]] = sqlQuery(channel, query = paste("SELECT DataYear as Year, ComboFIPS as FIPS, 
                NameTagPlace as County, StatePO as State, 
                IndustryName as Industry, 
                TotalIndustryOutput as Output
                FROM dbo_Output", yr, sep = ""))
  data = rbind(data, datalist[[i]])
  
  #close channel
  odbcClose(channel)
}


dat = data.table(dcast(data, Year+FIPS+County+State~Industry, value.var = "Output"))

namer = function(n){
  n = paste("ind.o", n)
  return(n)
}
nums = c(1:440)
names = sapply(X = nums, FUN = namer)
setnames(dat, 5:444, c(names))
