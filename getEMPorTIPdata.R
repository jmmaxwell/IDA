## function for getting EMP and OUT data for each year
## When all are loaded of both it's about 264 MBs

get.EMP.TIP.data = function(yr, VA.type){
  
  require(RODBC)
  require(data.table)
  
  # set db file path
  db = file.path(paste("C:/Users/jmmaxwell/Desktop/IMdata/", yr, ".accdb", sep = ""))
  
  # connect to db
  channel = odbcConnectAccess2007(db)
  
  table  = paste("dbo_", VA.type, yr, sep = "")
  if (VA.type == "Output"){
    value.var = "TotalIndustryOutput as TIP"
  } else value.var = "Employment_Value as EMP"
  
  SQL.q1 = paste("SELECT DataYear as YR, ComboFIPS as FIPS, IndustryCode as IC, "
                 ,value.var, " FROM ",table, sep = "")

  # use SQL command to fetch data
  dt = data.table(sqlQuery(channel, query = SQL.q1))

  #close channel
  odbcClose(channel)
  
  return(dt)
}