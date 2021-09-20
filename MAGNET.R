# Introduction---- 
# magnet project bulk RNA-seq analysis pipeline by Siavash Richard Moghadami
# loading required packages----
# make sure to perform setRepositories() to install new packages
library(rhdf5)
library(tidyverse)
library(tximport)
library(ensembldb)
library(EnsDb.Hsapiens.v86)
library(datapasta)

# Reading MAGNET study design file ----
targets <- read_csv("magnet.txt") # reading metadata of MAGNET project
path <- file.path("/Volumes/GoogleDrive/Academics/Research/Independent/magnetProject/kallistoOut",targets$Run,"abundance.tsv") # path to kallisto output
all(file.exists(path)) # make sure that all abundance files exist. If the answer is false, check with which() to investigate
