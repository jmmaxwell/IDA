load("VAdata.Rda")
load("ALLdata.Rda")

# function to calc GDP for total economy for a given year
getGDP = function(yr){
  GDP = sum(subset(VAdata, YR == yr, c(VAEMP, VAGOS, VAMPI, VATPI)))
  return(GDP)
}

#function to calc GDP for county for year
getGCP = function(fips, yr){
  GCP = sum(subset(VAdata, YR == yr & FIPS == fips, 
                   c(VAEMP, VAGOS, VAMPI, VATPI)))
  return(GCP)
}

# function to calc GDP for an industry in a county for a given year
getICP = function(fips, ic, yr){
  ICP = sum(subset(VAdata, YR == yr & IC == ic & FIPS == fips, 
                   c(VAEMP, VAGOS, VAMPI, VATPI)))
  return(ICP)
}

# function to get percent change in GDP
percentGDPchange = function(yr.initial, yr.final){
  percentchange = ((getGDP(yr.final)-getGDP(yr.initial))*100)/getGDP(yr.initial)
  
  return(percentchange)
}

# returns sum of va type for year, industry, all counties
#VA options: "VAEMP", "VAGOS", "VAMPI", "VATPI", "TIP", "EMP"
getVAforI = function(VA.type, yr, ic){
  VAforI = sum(subset(ALLdata, YR == yr & IC == ic, VA.type))
  return(VAforI)
}










