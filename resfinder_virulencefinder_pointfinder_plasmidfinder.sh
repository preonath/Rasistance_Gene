
# Activate_Conda_Environment
# conda activate res2

rawpath="/home/asus/Desktop/CHRF_Project/Commercial_Sample_analysis/iSeq/Commercial_Bac_iSeq_run_01"


for files in $rawpath/*/3_Unicycler/*.fasta
    do
    name=`basename $files| cut -f 1,2 -d '_'`

    echo $name
    # echo $files

    echo "Analysis for Resfinder"
    # No need to define Resfinder Database, because it will take automatically.
    mkdir -p $rawpath/$name/5_Resfinder
    run_resfinder.py -ifa $files -l 0.6 -t 0.9 --acquired -o $rawpath/$name/5_Resfinder


    echo "Analysis for Virulencefinder"
    # No need to define Virulencefinder Database, because it will take from bashrc.
    mkdir -p $rawpath/$name/6_Virulencefinder
    virulencefinder.py -i $files --mincov 0.6 --threshold 0.8 -p /home/asus/Database/virulencefinder_db > $rawpath/$name/6_Virulencefinder/$name\_virulencefinder_result
    
    echo "Analysis for Pointfinder"
    # No need to define Pointfinder Database, because it will take from bashrc.
    mkdir -p $rawpath/$name/7_Pointfinder
    
    #below comment main code
    # resfinder -o $rawpath/$name/7_Pointfinder -ifa $files -l 0.6 -t 0.9 --acquired -db_res $res_db --point -db_point $point_db -s "Salmonella enterica"
   
    #below my code
    resfinder -o $rawpath/$name/7_Pointfinder -ifa $files -l 0.6 -t 0.9 --acquired --point -db_point $pointfinder_db -s "Salmonella enterica"


    echo "Analysis for Plasmidfoinder"
    # No need to define Plasmidfinder Database, because it will take from bashrc.
    mkdir -p $rawpath/$name/8_Plasmidfinder
    plasmidfinder.py -i $files -o $rawpath/$name/8_Plasmidfinder -p $plasmidfinder_db -l 0.6 -t 0.6 >  $rawpath/$name/8_Plasmidfinder/$name\_virulencefinder_result 
    grep -E "Found" $rawpath/$name/8_Plasmidfinder/$name\_virulencefinder_result > $rawpath/$name/8_Plasmidfinder/$name\_virulencefinder_finel_result 

    break
done
