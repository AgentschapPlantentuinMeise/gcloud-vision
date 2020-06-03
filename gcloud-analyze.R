swd()
library(tidyverse)

gcloudAnalyze <- function(xlsname) {
  size = readxl::excel_sheets(xlsname)
  
  summ = tibble(barcode = size)
  summ = summ[-1,]
  
  resu = list()
  for (i in 2:length(size)) {
    resu[[i-1]] = readxl::read_xlsx(xlsname,sheet=i)
  }
  
  #initialize
  summ$totalscore = NA #sum of all scores
  summ$n = NA #number of unignored lines
  summ$hn = NA #number of handwritten lines
  summ$tn = NA #number of types lines
  summ$htn = NA #number of combination of h and t
  summ$c0 = NA #number of zero scores
  summ$c05= NA #number of 0.5 scores
  summ$c1 = NA #number of 1 scores
  
  #calculate
  #use try as they may not always all be present on a sheet
  for (i in 1:dim(summ)[1]) {
    summ$totalscore[i] = sum(as.numeric(resu[[i]]$score),na.rm=T)
    summ$n[i] = filter(count(resu[[i]],ignored),is.na(ignored))$n
    ht = count(resu[[i]],ht)
    try(summ$hn[i] <- filter(ht,ht=="h")$n,silent=T)
    try(summ$tn[i] <- filter(ht,ht=="t")$n,silent=T)
    try(summ$htn[i] <- filter(ht,ht=="ht")$n,silent=T)
    sco = count(resu[[i]],score)
    try(summ$c0[i] <- filter(sco,score=="0")$n,silent=T)
    try(summ$c05[i] <- filter(sco,score=="0.5")$n,silent=T)
    try(summ$c1[i] <- filter(sco,score=="1")$n,silent=T)
  }
  
  #sum score divided by line nr as brute quality score
  summ$qual = 100*summ$totalscore/summ$n
  
  #set missing instances to zero
  summ[is.na(summ)] = 0
  
  #percentages of typed and handwritten lines
  summ$tp = summ$tn/summ$n
  summ$hp = summ$hn/summ$n
  
  return(summ)
}

data1 = gcloudAnalyze("analyze-ocr-results_Elke.xlsx")
data2 = gcloudAnalyze("analyze-ocr-results_Marijke.xlsx")
