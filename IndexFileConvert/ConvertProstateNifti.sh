
rm -r /media/ziyue/Research/Data/ProstateX/Nifti/*

for i in $(seq 0 203)
do 
    i="$(printf "%04d\n" $i)"
    rawDir=/media/ziyue/Research/Data/ProstateX/RawData/PEx$i\_00000000
    if [ -d "$rawDir" ]; then
        echo "-------------------------------------------"       
        echo $i
        mkdir /media/ziyue/Research/Data/ProstateX/Nifti/$i
        tgtDir=/media/ziyue/Research/Data/ProstateX/Nifti/$i
        ITK_Tools/./DicomToAnalyze $rawDir/dicoms/adc/aligned/ $tgtDir/adc.nii.gz 0
        ITK_Tools/./DicomToAnalyze $rawDir/dicoms/highb/aligned/ $tgtDir/highb.nii.gz 0
        ITK_Tools/./DicomToAnalyze $rawDir/dicoms/t2/ $tgtDir/t2.nii.gz 0
    
        for j in $rawDir/*.txt
        do
            name=$(basename "$j" ".txt")
            name=${name// /_}
            echo $name
            ITK_Tools/./GenerateMaskFromImageAndIndex $tgtDir/t2.nii.gz "$j" $tgtDir/$name.nii.gz 0 
        done        
    fi
done

