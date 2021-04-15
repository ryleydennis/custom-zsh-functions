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