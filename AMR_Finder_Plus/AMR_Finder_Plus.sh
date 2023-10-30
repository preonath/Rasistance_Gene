#!/bin/bash
															#################################################################
															#																#
															#						Pipeline GBS  							#
															#																#
															#################################################################



#***********************************************#
#				Trimmomatic						#
#***********************************************#


# path="/media/chrf/Home03/GBS/GBS_All/Okay_RawData"
# path="/media/chrf/Home04/300_GBS"

# path="/media/chrf/Home03/GBS/GBS_All/OKAY"
# adapters_path="/media/chrf/Home03/GBS/GBS_All/Adapter_trimming/adapters"


# for id in $path/*
# do
# 	name=`basename $id | cut -f 1,2 -d '_'`
# 	echo $name


	# fastq_1=$path/$name/1_RawData/$name*\_R1_001.fastq.gz
	# fastq_2=$path/$name/1_RawData/$name*\_R2_001.fastq.gz
	# echo $fastq_1
# 	# echo $fastq_2

# 	mkdir -p $path/$name/2_Trimmed
# 	R1_Trim_P=$path/$name/2_Trimmed/$name\_R1_TrmP.fastq.gz
# 	R2_Trim_P=$path/$name/2_Trimmed/$name\_R2_TrmP.fastq.gz

# 	R1_Trim_S=$path/$name/2_Trimmed/$name\_R1_TrmS.fastq.gz
# 	R2_Trim_S=$path/$name/2_Trimmed/$name\_R2_TrmS.fastq.gz


# 	# trimmomatic PE -threads 92 $fastq_1 $fastq_2 $R1_Trim_P $R1_Trim_S $R2_Trim_P $R2_Trim_S ILLUMINACLIP:$adapters_path/TruSeq3-PE-2.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:36 LEADING:20 TRAILING:20
# 	unicycler -1 $R1_Trim_P -2 $R2_Trim_P -o $dir\/3_Unicycler/ -t 92 --min_fasta_length 200 --keep 1
# 	break
# done


#***********************************************************#
#				Assembly by Unicycler And Kraken2			#
#***********************************************************#

# kraken_db="/media/chrf/Home03/Trial_Preonath/kraken/k2_standard_08gb_20221209"
# kkraken2="/media/chrf/Home03/Trial_Preonath/kraken"


# for id in $path/*
# do
# 	name=`basename $id | cut -f 1,2 -d '_'`
# 	echo $name



# 	R1_Trim_P=$path/$name/2_Trimmed/$name\_R1_TrmP.fastq.gz
# 	R2_Trim_P=$path/$name/2_Trimmed/$name\_R2_TrmP.fastq.gz

# 	echo $R1_Trim_P
# 	echo $R1_Trim_P


# 	############## Assembly ##################

# 	echo "Start Assembly of $name "

# 	mkdir -p -v $path/$name/3_Unicycler
# 	unicycler -1 $R1_Trim_P -2 $R2_Trim_P -o $path/$name/3_Unicycler -t 92 --min_fasta_length 200 --keep 1
# 	mv $path/$name/3_Unicycler/assembly.fasta $path/$name/3_Unicycler/$name\_contigs.fasta

# 	echo "End Assembly of $name "



# 	############## Kraken2 ##################

# 	echo "Start Kraken2 of $name "

# 	mkdir -p -v $path/$name/4_Kraken2_Result
# 	$kkraken2/kraken2 --use-names --db $kraken_db $path/$name/3_Unicycler/$name\_contigs.fasta --report $path/$name/4_Kraken2_Result/$name\_kraken2.txt --output $path/$name/4_Kraken2_Result/ --threads 92

# 	echo "End Assembly of $name "

# 	# break



# done





#***********************************************#
#				Kraken2							#
#***********************************************#


# kraken_db="/media/chrf/Home03/Trial_Preonath/kraken/k2_standard_08gb_20221209"
# kkraken2="/media/chrf/Home03/Trial_Preonath/kraken"

# for dir in $path/*
# do
# 	name=`basename $dir | cut -f 1,2 -d '_'`
# 		echo $name
#         mkdir -p -v $path/$name/4_Kraken2_Result
# 		$kkraken2/kraken2 --use-names --db $kraken_db $path/$name/3_Assembly/$name\_contigs.fasta --report $path/$name/4_Kraken2_Result/$name\_kraken2.txt
# done




#***********************************************************************************#
#						Mapping by Bowtie2, VCF Quality Filter						#
#***********************************************************************************#
# script="/home/chrf/WGS_Scripts/"
# References="/home/chrf/Reference_Sequences/"
# refname=GBS_HUGS5823
# ref=GBS_HUGS5823.fasta


# # Build Index (speed up the alignment)
# mkdir $References\/GBS_HUGS5823/Index/

# bowtie2-build $References\/GBS_HUGS5823/$ref $References\/GBS_HUGS5823/Index/index

# Index=`echo $References`"GBS_HUGS5823/Index/"
# samtools faidx $References\/GBS_HUGS5823/$ref


# # path_2="/media/chrf/Home03/GBS/GBS_All/OKAY"
# path_2="/media/chrf/Home04/300_GBS"

# for id in $path/*
# do
# 	name=`basename $id | cut -f 1,2 -d '_'`
# 	echo $name


# 	fastq_1=$path/$name*\_R1_001.fastq.gz
# 	fastq_2=$path/$name*\_R2_001.fastq.gz
# 	# echo $fastq_1
# 	# echo $fastq_2




# 	mkdir -p -v $path_2/$name/5_Mapping_$refname/Mapping/
# 	echo "# Mapping the reads"
# 	bowtie2 -x $Index\/index -1 $fastq_1 -2 $fastq_2 -S $path_2/$name/5_Mapping_$refname/Mapping/$name\.sam -p 90
	
# 	echo "# Convert .sam to .bam"
# 	samtools view -ubS --threads 90 $path_2/$name/5_Mapping_$refname/Mapping/$name\.sam > $path_2/$name/5_Mapping_$refname/Mapping/$name\.bam

# 	# break

# done




#***********************************************************#
#				AMRFinderPlus								#
#***********************************************************#

# Avtivate Conda env

# eval "$(conda shell.bash hook)"
# conda activate amrfinder
# # cp /media/chrf/Home04/GBS/GBS_Analysis/GBS_*/3_Unicycler/GBS_*_contigs.fasta /media/chrf/Home04/GBS/GBS_Contigs

# path_assembly="/media/chrf/Home04/GBS/GBS_Contigs"

# for id in $path_assembly/*
# do
# 	name=`basename $id | cut -f 1,2 -d '_'`
# 	echo $name


# 	############## AMRFinderPlus ##################

# 	echo "Start AMRFinderPlus of $name "

# 	mkdir -p -v /media/chrf/Home04/GBS/GBS_Analysis/$name/6_AMRFinderPlus_Result
	 
# 	amrfinder -n $path_assembly/$name\_contigs.fasta -o /media/chrf/Home04/GBS/GBS_Analysis/$name/6_AMRFinderPlus_Result/$name\_amrfinder.got --threads 90
	

# 	echo "End AMRFinderPlus aof $name "

# 	# break

# done




#***********************************************************#
#				MLST										#
#***********************************************************#

# eval "$(conda shell.bash hook)"
# conda activate mlst


# path_assembly="/media/chrf/Home04/GBS/GBS_Analysis"

# for id in $path_assembly/*
# do
# 	name=`basename $id | cut -f 1,2 -d '_'`
# 	echo $name


# 	############## MLST ##################
# 	mkdir -p -v $path_assembly/$name/7_MLST_Result

# 	mlst $path_assembly/$name/3_Unicycler/$name\_contigs.fasta --threads 90 --csv >  $path_assembly/$name/7_MLST_Result/$name\_mlst.csv


# 	# break

# done


# Add ID from the first column of result of AMRFinder

# path_file="/media/chrf/Home04/GBS/GBS_Analysis/GBS_*/6_AMRFinderPlus_Result"

# for id in $path_file/*
# do
# 	name=`basename $id | cut -f 1,2 -d '_'`
# 	echo $name
# 	# echo "$id"
# 	sed -i "1s/^/$name\tProtein identifier/" "$id"
# 	sed -i '2,$s/^/\t/' "$id"
# 	# break
# done

# Now Concatination all result
