function scrub() {
  # Clears terminal screen
  # https://askubuntu.com/a/473770
  clear && printf '\e[3J'
}

function listLinks() {
  ( ls -l node_modules ; ls -l node_modules/@* ) | grep ^l
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