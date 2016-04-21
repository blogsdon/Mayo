require(synapseClient)
library(dplyr)
library(utilityFunctions)
library(bit64)
synapseLogin()

#cerebellum
covariatesObj <- synGet('syn5605695')
residualExpressionObj <- synGet('syn5605698')

library(data.table)

mayoCovariates <- fread(covariatesObj@filePath,data.table=F,stringsAsFactors=F)
mayoExpression <- fread(residualExpressionObj@filePath,data.table=F,stringsAsFactors=F)

mayoExpression2 <- t(mayoExpression[,-c(1:2)])
colnames(mayoExpression2) <- mayoExpression$illumina_humanht_12_v4

#mayoCovariates <- mayoCovariates[,-136]

#Bipolar
#BipolarCov <- dplyr::filter(mayoCovariates,Dx=='AFF')

mayoExpression2[dplyr::filter(mayoCovariates,Dxn==1)$ID,] %>%
  apply(2,utilityFunctions::winsorize) %>%
  scale %>%
  write.csv(file='mayoADarrayExpressionCBE.csv',quote=F)

#MCI
mayoExpression2[dplyr::filter(mayoCovariates,Dxn==0)$ID,] %>%
  apply(2,utilityFunctions::winsorize) %>%
  scale %>%
  write.csv(file='mayononADarrayExpressionCBE.csv',quote=F)


mayoExpression2 <- apply(mayoExpression2,2,utilityFunctions::winsorize)
mayoExpression2 <- scale(mayoExpression2)

write.csv(mayoExpression2,file='mayoarrayExpressionCBE.csv',quote=F)