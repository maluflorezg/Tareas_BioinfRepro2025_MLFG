# Project 3: Peopling of the Americas

#### Load packages:
library(tidyverse)
library(admixtools)

#### Get f2_blocks. Only once for the entire project

target3 <- c("Pima.DG", "CLM.DG", "Karitiana.DG","Chile_LosRieles_12000BP.AG") #check for other ancient or present-day groups in the Americas.
source3 <- c("USA_Anzick_realigned.SG","USA_Ancient_Beringian.SG","USA_Nevada_SpiritCave_11000BP.SG")
outgroup3 <- c("Mbuti.DG", "CHB.DG", "Papuan.DG", "Russia_UstIshim_IUP.DG", "Denisova.DG")


all_pops <- c(target3, source3, outgroup3, "India_GreatAndaman_100BP.SG")
prefix <- "v62.0_1240k_public"
outdir <- "aadr_1000G_f2_proyect3"

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

f3_results <- f3(f2_blocks, pop1="Mbuti.DG", pop2=target3, pop3=source3)


#### f4 tests: asymmetry checks. Are target populations closer to any of the potential sources?. Run one per each target population
target3 <- c("Pima.DG", "CLM.DG", "Karitiana.DG","Chile_LosRieles_12000BP.AG") #check for other ancient or present-day groups in the Americas.

f4_results_1 <- f4(f2_blocks, pop1="Pima.DG", pop2= c("CLM.DG", "Karitiana.DG","Chile_LosRieles_12000BP.AG"), pop3=source3, pop4="Mbuti.DG")
f4_results_2 <- f4(f2_blocks, pop1="CLM.DG", pop2= c("Pima.DG", "Karitiana.DG", "Chile_LosRieles_12000BP.AG"), pop3=source3, pop4="Mbuti.DG")
f4_results_3 <- f4(f2_blocks, pop1="Karitiana.DG", pop2= c("Pima.DG", "CLM.DG", "Chile_LosRieles_12000BP.AG"), pop3=source3, pop4="Mbuti.DG")
f4_results_4 <- f4(f2_blocks, pop1="Chile_LosRieles_12000BP.AG", pop2= c("Pima.DG", "CLM.DG", "Karitiana.DG"), pop3=source3, pop4="Mbuti.DG")


#### qpWave: test rank (how many ancestry streams are needed). Run one per each target population
wave_1 <- qpwave(f2_blocks,
                left = c(target3[1], source3),
                right = outgroup3)

wave_2 <- qpwave(f2_blocks,
                  left = c(target3[2], source3),
                  right = outgroup3)

wave_3 <- qpwave(f2_blocks,
                  left = c(target3[3], source3),
                  right = outgroup3)

wave_4 <- qpwave(f2_blocks,
                  left = c(target3[4], source3),
                  right = outgroup3)

wave_5 <- qpwave(f2_blocks,
                left = c(target3[1],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                right = outgroup3)

wave_6 <- qpwave(f2_blocks,
                 left = c(target3[2],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                 right = outgroup3)

wave_7 <- qpwave(f2_blocks,
                 left = c(target3[3],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                 right = outgroup3)

wave_8 <- qpwave(f2_blocks,
                 left = c(target3[4],"USA_Ancient_Beringian.SG","India_GreatAndaman_100BP.SG"),
                 right = outgroup3)

wave_1
wave_2
wave_3
wave_4
wave_5
wave_6
wave_7
wave_8

#### qpAdm: 2 or 3-way mixture models. Run one per each target populations
admix_2way_1 <- qpadm(f2_blocks, left = c(target3[1], source3[1:2]), right = outgroup3, target=target3[1])
admix_2way_2 <- qpadm(f2_blocks, left = c(target3[2], source3[1:2]), right = outgroup3, target=target3[2])
admix_2way_3 <- qpadm(f2_blocks, left = c(target3[3], source3[1:2]), right = outgroup3, target=target3[3])
admix_2way_4 <- qpadm(f2_blocks, left = c(target3[4], source3[1:2]), right = outgroup3, target=target3[4])

View(admix_2way_1$weights)
View(admix_2way_2$weights)
View(admix_2way_3$weights)
View(admix_2way_4$weights)

admix_2way_1
admix_2way_2
admix_2way_3
admix_2way_4

admix_3way_1 <- qpadm(f2_blocks, left = c(target3[1], source3), right = outgroup3, target=target3[1])
admix_3way_2 <- qpadm(f2_blocks, left = c(target3[2], source3), right = outgroup3, target=target3[2])
admix_3way_3 <- qpadm(f2_blocks, left = c(target3[3], source3), right = outgroup3, target=target3[3])
admix_3way_4 <- qpadm(f2_blocks, left = c(target3[4], source3), right = outgroup3, target=target3[4])

View(admix_3way_1$weights)
View(admix_3way_2$weights)
View(admix_3way_3$weights)
View(admix_3way_4$weights)

admix_3way_1
admix_3way_2
admix_3way_3
admix_3way_4
