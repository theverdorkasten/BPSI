library(vulcan)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(aracne.networks)

vfile <- "vulcansheet-rename.csv"

message('importing ', vfile)

vobj <- vulcan.import(vfile)

saveRDS(object = vobj, file = "full_vobj.rds")

vobj <- readRDS("full_vobj.rds")

message('annotating vobj')

vobj$peakcounts[["Chr"]] <- paste("chr", vobj$peakcounts[["Chr"]], sep="")
vobj$peakrpkms[["Chr"]] <- paste("chr", vobj$peakrpkms[["Chr"]], sep="")
vobj_annotated<-vulcan.annotate(
	vobj,lborder=-10000,
	rborder=10000,
	method="sum",
	TxDb=TxDb.Hsapiens.UCSC.hg38.knownGene)
vobj_annotated<-vulcan.normalize(vobj_annotated)

saveRDS(object = vobj_annotated, file = "full_vobj_annotated.rds")

message('analysing vobj')

vobj_analysis_tcga <- vulcan(vobj_annotated,network=regulonbrca,contrast=c("Vehicle","E2"))

saveRDS(object = vobj_analysis_tcga, file = "full_vobj_analysis_tcga.rds")

metabric <- new.env()
load("metabric-regulon-tfs.rda", env=metabric)
vobj_analysis_metabric <- vulcan(vobj_annotated,network=metabric$regulon,contrast=c("Vehicle","E2"))

saveRDS(object = vobj_analysis_metabric, file = "full_vobj_analysis_metabric.rds")

message('completed execution')
