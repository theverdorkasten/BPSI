setwd('/users/ter507/scratch/GSE117940-attempt2.1-macs2-broad/')
source("../analysis_init.R")
vcompairs <- list()
for (x in vobj$samples) {
    vcompairs[x] <- vulcan(vobj_annotated, network=regulonbrca, contrast=c("Vehicle", x))
    message('finished ', x)
}

saveRDS(file = 'vcompairs2.rds', object = vcompairs)
