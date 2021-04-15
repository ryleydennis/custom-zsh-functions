#get diff file, save to desktop and open in vs code
function diffDesktop() {
    git log -p -L $1,$2:$3 &> ~/Desktop/$4.diff | code ~/Desktop/$4.diff
  }

# #get diff without saving a file
# function getdifftmp() {
#     git log -p -L $1,$2:$3 | code -
#   }

# #get diff with temp file
# function diff() {
#     newFileName="TmpDiff"+$(date +"%m%d%Y%H%M%S")
#     tmpFile=$(mktemp /tmp/${newFileName}.diff)
#     git log -p -L $1,$2:$3  &> /tmp/${newFileName}.diff | code /tmp/${newFileName}.diff
# }

#get diff with temp file
#params: 
#1 starting line
#2 ending line
#3 file location
function diff() {
    # create diffs directory if one does not exist
    mkdir -p /tmp/diffs
    
    #get prefix for filename if it can get it from orginal file. Otherwise use 'TmpDiff'
    # if fileName=$(basename $3); then
    # echo $fileName
    # else
    fileName="TmpDiff"
    # echo $fileName
    # fi

    #Create temporary file and save git response to it
    newFileName=$fileName+$1-$2+$(date +"%m%d%Y%H%M%S")
    newFilePath=/tmp/diffs/${newFileName}.diff
    mktemp $newFilePath
    git log -p -L $1,$2:$3  &> $newFilePath | code $newFilePath
}