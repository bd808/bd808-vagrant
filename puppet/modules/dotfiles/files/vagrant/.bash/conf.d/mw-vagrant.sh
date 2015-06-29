#!/usr/bin/env bash
# Things that are handy on a mediawiki vagrant instance

# run something as the apache user
alias www='sudo -u www-data'

# run php-cli as the apache user
alias wp='www php'

# run unit tests as the apache user
alias wpt='wp /vagrant/mediawiki/tests/phpunit/phpunit.php --colors --strict --verbose --debug'
