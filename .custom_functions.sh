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

function scrub() {
  # Clears terminal screen
  # https://askubuntu.com/a/473770
  clear && printf '\e[3J'
}

function listLinks() {
  ( ls -l node_modules ; ls -l node_modules/@* ) | grep ^l
}

function refreshPods() {
  cd /Users/rdennis/swing/tempo && npx pod-install && osascript -e 'display notification "Refresh complete with no errors" with title "Tempo Refresh Done"' || osascript -e 'display notification "Error while refreshing Tempo" with title "Tempo Refresh ERROR"'
}

function rebuildPods() {
  cd /Users/rdennis/swing/tempo && cd ios && rm -rf pods && cd .. && npx pod-install && osascript -e 'display notification "Refresh complete with no errors" with title "Tempo Refresh Done"' || osascript -e 'display notification "Error while refreshing Tempo" with title "Tempo Refresh ERROR"'
}

function buildI() {
  if [ "$1" = "p" ]; then
    cd /Users/rdennis/swing/tempo && npx pod-install
  fi
  # This does not pass the errors through correctly
  react-native run-ios --device "Nexient" --verbose && osascript -e 'display notification "Build complete with no errors" with title "iOS Build Successful"' || osascript -e 'display notification "Error while building" with title "iOS Build Error"'
}

function buildA() {
  goT
  make android && osascript -e 'display notification "Build complete with no errors" with title "Android Build Successful"' || osascript -e 'display notification "Error while building" with title "Android Build Error"'
  react-native run-android
}


function runTaco() {
  wml add "/Users/rdennis/swing/taco/packages/swingcore" "/Users/rdennis/swing/tempo/node_modules/@swing-therapeutics/swingcore/"
  watchman watch-del-all
  # key code 27 => -
  # key code 36 => enter
  # key code 39 => '
  # key code 49 => space
  # tabset WML --badge "WML" --color #223c5c
  osascript \
    -e 'tell application "iTerm" to activate' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "t" using command down' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "go swingcore"' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 36' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "tabset WML "' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 27' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 27' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "badge "' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 39' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "WML"' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 39' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 49' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 27' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 27' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "color "' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 39' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "#223c5c"' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 39' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 36' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "scrub"' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 36' \
    -e 'tell application "System Events" to tell process "iTerm" to keystroke "wml start"' \
    -e 'tell application "System Events" to tell process "iTerm" to key code 36'
  
  eval "go swingcore"
  tabset Hot Reload --badge "Hot Reload" --color "#704459"
  scrub
  npm run dev
}

function startTempo() {
  go tempo l
  tabset Tempo --badge "Tempo" --color "#1A3469"
  scrub
  make watch
}

function startTempest() {
  go tempest l
  tabset Tempest --badge "Tempest" --color "#711684"
  scrub
  yarn start
}

function linkCore() {
  yarn link @swing-therapeutics/swingcore
}

function unlinkCore() {
  yarn unlink @swing-therapeutics/swingcore && yarn install --force
}

function go {
  case ${1:l} in 

  t | tempo)
    cd /Users/rdennis/swing/tempo
    ;;

  te | tempest)
    cd /Users/rdennis/swing/tempest
    ;;

  ta | taco)
    cd /Users/rdennis/swing/taco
    ;;

  sw | swingcore)
    cd /Users/rdennis/swing/taco/packages/swingcore
    ;;

  su | survey | surveybay)
    cd /Users/rdennis/swing/taco/packages/surveyBay
    ;;

  se | sessions)
    cd /Users/rdennis/swing/taco/packages/sessions
    ;;

  swing)
    cd /Users/rdennis/swing/
    ;;
  
  temper)
    cd /Users/rdennis/swing/temper
    ;;

  *)
    echo "\"${1}\" has not been defined"
    ;;

  esac
  
  if [[ "$2" = "-l" ||  "$2" = "l" ]]; then
    label ${1}
  fi
}

function label() {
  color=""

  case ${1:l} in

  tempo)
    color="--color \"#00657A\""
    ;;
  tempest)
    color="--color \"#1A3469\""
    ;;

  taco)
    color="--color \"#2E7D1C\""
    ;;

  sessions)
    color="--color \"#7A002F\""
    ;;

  swingcore)
    color="--color \"#53007A\""
    ;;

  survey | surveybay)
    color="--color \"#BF7F28\""

  esac

  eval "tabset ${1} --badge ${1} ${color}"
}