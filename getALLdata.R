## VA data summary stats

#Get Employment data

datalist = list()       # initialize list
source("getEMPorTIPdata.R")   # load function

for (i in 1:5){
  yr = 2006 + i
  datalist[[i]] = get.EMP.TIP.data(yr, "Employment")
}

EMPdata = rbindlist(datalist)


## get Industry data

datalist = list()       # initialize list
source("getEMPorTIPdata.R")   # load function

for (i in 1:5){
  yr = 2006 + i
  datalist[[i]] = get.EMP.TIP.data(yr, "Output")
}

INDdata = rbindlist(datalist)

EIdata = merge(INDdata, EMPdata, by = c("YR", "FIPS", "IC"))

ALLdata = merge(VAdata, EIdata, by = c("YR", "FIPS", "IC"))

save(ALLdata, file = "ALLdata.Rda")
