# Project 4: Medieval / Iberian admixture

## Modify names to match your dataset!

#### Load packages:
library(admixtools)
library(tidyverse)

#### Get f2_blocks. Only once for the entire project

target4 <- c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG") 
source4 <- c("Spain_MLN.AG", "Morocco_EN.WGC.SG", "Yoruba.DG") 
outgroup4 <- c("Ethiopia_4500BP.SG", "Han.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG")


all_pops <- c(target4, source4, outgroup4)
prefix <- "v62.0_1240k_public"
outdir <- "aadr_1000G_f2_proyect4"

extract_f2(pref = prefix,
           outdir = outdir,
           pops = all_pops,          # only populations to analyze
           overwrite = TRUE,
           blgsize = 0.05,            # block size in Morgans (default fine)
           verbose = TRUE)

#### Load f2_blocks
f2_blocks <- f2_from_precomp(outdir)

#### Outgroup-f3: shared drift between target and sources
#pop1=outgroup; pop2=target groups or populations; pop3=the ones to test shared drift with

f3_results <- f3(f2_blocks, pop1="Ethiopia_4500BP.SG", pop2=target4, pop3=source4)


#### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population


f4_results_1 <- f4(f2_blocks, pop1="Spain_Islamic.AG", pop2= c("Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_2 <- f4(f2_blocks, pop1="Spain_Medieval.AG", pop2= c("Spain_Islamic.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_3 <- f4(f2_blocks, pop1="Spain_NazariPeriod_Muslim.AG", pop2= c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_Islamic_Zira.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_4 <- f4(f2_blocks, pop1="Spain_Islamic_Zira.AG", pop2= c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Visigoth_Granada.AG"), pop3=source4, pop4="Mbuti.DG")
f4_results_5 <- f4(f2_blocks, pop1="Spain_Visigoth_Granada.AG", pop2= c("Spain_Islamic.AG","Spain_Medieval.AG","Spain_NazariPeriod_Muslim.AG","Spain_Islamic_Zira.AG"), pop3=source4, pop4="Mbuti.DG")


#### qpWave: test rank (how many ancestry streams are needed). Run one per each target population
wave_1 <- qpwave(f2_blocks,
                left = c(target4[1:2], source4),
                right = outgroup4)

wave_2 <- qpwave(f2_blocks,
                 left = c(target4[2], source4),
                 right = outgroup4)
wave_3 <- qpwave(f2_blocks,
                 left = c(target4[3], source4),
                 right = outgroup4)
wave_4 <- qpwave(f2_blocks,
                 left = c(target4[4], source4),
                 right = outgroup4)
wave_5 <- qpwave(f2_blocks,
                 left = c(target4[5], source4),
                 right = outgroup4)

wave_1
wave_2
wave_3
wave_4
wave_5

#### qpAdm: 2 or 3-way mixture models. Run one per each target populations
admix_2way_1 <- qpadm(f2_blocks, left = c(target4[1], source4[1:2]), right = outgroup4, target=target4[1])
admix_2way_2 <- qpadm(f2_blocks, left = c(target4[2], source4[1:2]), right = outgroup4, target=target4[2])
admix_2way_3 <- qpadm(f2_blocks, left = c(target4[3], source4[1:2]), right = outgroup4, target=target4[3])
admix_2way_4 <- qpadm(f2_blocks, left = c(target4[4], source4[1:2]), right = outgroup4, target=target4[4])
admix_2way_5 <- qpadm(f2_blocks, left = c(target4[5], source4[1:2]), right = outgroup4, target=target4[5])

View(admix_2way_1$weights)
View(admix_2way_2$weights)
View(admix_2way_3$weights)
View(admix_2way_4$weights)
View(admix_2way_5$weights)
admix_2way_1
admix_2way_2
admix_2way_3
admix_2way_4
admix_2way_5

admix_3way_1 <- qpadm(f2_blocks, left = c(target4[1], source4), right = outgroup4, target=target4[1])
admix_3way_2 <- qpadm(f2_blocks, left = c(target4[2], source4), right = outgroup4, target=target4[2])
admix_3way_3 <- qpadm(f2_blocks, left = c(target4[3], source4), right = outgroup4, target=target4[3])
admix_3way_4 <- qpadm(f2_blocks, left = c(target4[4], source4), right = outgroup4, target=target4[4])
admix_3way_5 <- qpadm(f2_blocks, left = c(target4[5], source4), right = outgroup4, target=target4[5])

View(admix_3way_1$weights)
View(admix_3way_2$weights)
View(admix_3way_3$weights)
View(admix_3way_4$weights)
View(admix_3way_5$weights)

admix_3way_1
admix_3way_2
admix_3way_3
admix_3way_4
admix_3way_5