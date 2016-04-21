#!/bin/sh
#number of cores to reserve for job
nthreads=8

#full s3 path where networks will go
s3="s3://metanetworks/Mayo/MCADGS/CBE/AD/"

#location of data file
dataFile="/shared/Mayo/MCADGS/mayoADarrayExpressionCBE.csv"

#location of metanetwork synapse scripts
pathv="/shared/metanetworkSynapse/"

#output path for temporary result file prior to pushing to s3/synapse
outputpath="/local/Mayo/MCADGS/CBE/AD/"

#path within s3
s3b="Mayo/MCADGS/CBE/AD"

#id of folder with networks to combine
networkFolderId="syn5968545"

#id of folder on Synapse that file will go to
parentId="syn5968545"

#path to csv file with annotations to add to file on Synapse
annotationFile="/shared/Mayo/MCADGS/CBE/AD/annoFile.txt"

provenanceFile="/shared/Mayo/MCADGS/CBE/AD/provenanceFile.txt"

#path to error output
errorOutput="/shared/Mayo/MCADGS/CBE/AD/Aggregationerror.txt"

#path to out output
outOutput="/shared/Mayo/MCADGS/CBE/AD/Aggregationout.txt"

#job script name
jobname="mayocbeaggregationAD"

qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile,networkFolderId=$networkFolderId -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildConsensus.sh
