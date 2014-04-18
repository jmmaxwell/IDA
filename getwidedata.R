## recasting data

load("ALLdata.Rda")

require(data.table)

dTIP = dcast.data.table(ALLdata, YR + FIPS ~ IC, value.var = "TIP")
dEMP = dcast.data.table(ALLdata, YR + FIPS ~ IC, value.var = "EMP")
dVAEMP = dcast.data.table(ALLdata, YR + FIPS ~ IC, value.var = "VAEMP")
dVAGOS = dcast.data.table(ALLdata, YR + FIPS ~ IC, value.var = "VAGOS")
dVAMPI = dcast.data.table(ALLdata, YR + FIPS ~ IC, value.var = "VAMPI")
dVATPI = dcast.data.table(ALLdata, YR + FIPS ~ IC, value.var = "VATPI")

nums = (1:440)

namer = function(num){
  name = paste("TIP", num, sep = '.')
  return(name)
}
names = sapply(nums, namer)
setnames(dTIP, 3:442, names)

namer = function(num){
  name = paste("EMP", num, sep = '.')
  return(name)
}
names = sapply(nums, namer)
setnames(dEMP, 3:442, names)

namer = function(num){
  name = paste("VAEMP", num, sep = '.')
  return(name)
}
names = sapply(nums, namer)
setnames(dVAEMP, 3:442, names)

namer = function(num){
  name = paste("VAGOS", num, sep = '.')
  return(name)
}
names = sapply(nums, namer)
setnames(dVAGOS, 3:442, names)

namer = function(num){
  name = paste("VAMPI", num, sep = '.')
  return(name)
}
names = sapply(nums, namer)
setnames(dVAMPI, 3:442, names)

namer = function(num){
  name = paste("VATPI", num, sep = '.')
  return(name)
}
names = sapply(nums, namer)
setnames(dVATPI, 3:442, names)

wide.dat = merge(dTIP, dEMP, by = c("YR", "FIPS"))
wide.dat = merge(wide.dat, dVAEMP, by = c("YR", "FIPS"))
wide.dat = merge(wide.dat, dVAGOS, by = c("YR", "FIPS"))
wide.dat = merge(wide.dat, dVAMPI, by = c("YR", "FIPS"))
wide.dat = merge(wide.dat, dVATPI, by = c("YR", "FIPS"))

save(wide.dat, file = "widedat.Rda")
