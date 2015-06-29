# == Class: base
#
# Crappy grab bag of stuff that seems to be universally useful
class base {
    include ::apt

    package { [
      'build-essential',
      'colorgcc',
      'python-dev',
      'ruby-dev'
    ]: }

    package { 'python-pip': } -> Package <| provider == pip |>

    dotfiles::user { 'vagrant': }
}
