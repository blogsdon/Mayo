#!/bin/sh
#number of cores to reserve for job
nthreads=8

#full s3 path where networks will go
s3="s3://metanetworks/Mayo/MCADGS/CBE/nonAD/"

#location of data file
dataFile="/shared/Mayo/MCADGS/mayononADarrayExpressionCBE.csv"

#location of metanetwork synapse scripts
pathv="/shared/metanetworkSynapse/"

#output path for temporary result file prior to pushing to s3/synapse
outputpath="/local/Mayo/MCADGS/CBE/nonAD/"

#path within s3
s3b="Mayo/MCADGS/CBE/nonAD"

#id of folder with networks to combine
networkFolderId="syn5968547"

#id of folder on Synapse that file will go to
parentId="syn5968547"

#path to csv file with annotations to add to file on Synapse
annotationFile="/shared/Mayo/MCADGS/CBE/nonAD/annoFile.txt"

provenanceFile="/shared/Mayo/MCADGS/CBE/nonAD/provenanceFile.txt"

#path to error output
errorOutput="/shared/Mayo/MCADGS/CBE/nonAD/Aggregationerror.txt"

#path to out output
outOutput="/shared/Mayo/MCADGS/CBE/nonAD/Aggregationout.txt"

#job script name
jobname="mayocbeaggregation"

qsub -v s3=$s3,dataFile=$dataFile,pathv=$pathv,outputpath=$outputpath,s3b=$s3b,parentId=$parentId,annotationFile=$annotationFile,provenanceFile=$provenanceFile,networkFolderId=$networkFolderId -pe orte $nthreads -S /bin/bash -V -cwd -N $jobname -e $errorOutput -o $outOutput $pathv/buildConsensus.sh
