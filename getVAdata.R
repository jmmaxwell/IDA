## function for getting VA data for each year
## careful! when all 5 are loaded it's about 290 MBs

get.VAdata = function(yr){
  
  require(RODBC)
  require(data.table)
  
  # set db file path
  db = file.path(paste("C:/Users/jmmaxwell/Desktop/IMdata/", yr, ".accdb", sep = ""))
  
  # connect to db
  channel = odbcConnectAccess2007(db)
  
  table  = paste("dbo_ValueAdded", yr, sep = "")
  
  SQL.q2 = paste("SELECT 
                 VAEMP.DataYear as YR, 
                 VAEMP.ComboFIPS as FIPS, 
                 VAEMP.IndustryCode as IC, 
                 VAEMP.VA_Amount as VAEMP, 
                 VAGOS.VA_Amount as VAGOS,
                 VAMPI.VA_Amount as VAMPI, 
                 VATPI.VA_Amount as VATPI
                 FROM ((((SELECT DataYear, ComboFIPS, IndustryCode, VA_Amount FROM ", table," VA WHERE VA_Type = 'PoW Employee Compensation') as VAEMP)
                        INNER JOIN (SELECT ComboFIPS, IndustryCode, VA_Amount FROM ", table," VA WHERE VA_Type = 'PoW Gross Operating Surplus (Other Property Income)') as VAGOS
                        ON VAEMP.ComboFIPS = VAGOS.ComboFIPS and VAEMP.IndustryCode = VAGOS.IndustryCode)
                       INNER JOIN (SELECT ComboFIPS, IndustryCode, VA_Amount FROM ", table," VA WHERE VA_Type = 'PoW Mixed (Proprietary) Income') VAMPI
                       ON VAEMP.ComboFIPS = VAMPI.ComboFIPS and VAEMP.IndustryCode = VAMPI.IndustryCode)
                 INNER JOIN (SELECT ComboFIPS, IndustryCode, VA_Amount FROM ", table," VA WHERE VA_Type = 'Taxes on Production and Imports (Indirect Business Taxes)') VATPI
                 ON VAEMP.ComboFIPS = VATPI.ComboFIPS and VAEMP.IndustryCode = VATPI.IndustryCode", sep = "")
  
  # use SQL command to fetch data
  dt = data.table(sqlQuery(channel, query = SQL.q2))
  
  #close channel
  odbcClose(channel)
  
  return(dt)
}