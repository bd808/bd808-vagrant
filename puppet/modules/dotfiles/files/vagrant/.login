# try to switch to bash
if ( { which bash } ) then
  echo "Your shell is not bash, running it anyway..."
  echo
  exec bash -l
endif

echo "Ugh, bash isn't available. Have fun in csh..."
