# Bump License Year

Bumps the last year in the license text in `LICENSE` and `README.md` files.

## Synopsis

    ❯ bump-license-year
    The license line in "LICENSE" was replaced.
    The license line in "README.md" was replaced.
    [master dcf23a3] docs: Bump license year
     2 files changed, 2 insertions(+), 2 deletions(-)

## Usage

    bump-license-year [options]

### Options

    -m|--message <message>  commit message
    -n|--name <name>        owner of the license (default is git user.name)
    -y|--year <year>        the last year (default is the current one)
    -d|--dry-run            print the new changes on the console only
    -v|--verbose            print the new changes on the console too
    -V|--version            print the version of the executable and exits
    -h|--help               print the usage information and exits

The default commit message: "docs: Bump license year".

###  Examples:

    $ bump-license-year -n "Ferdinand Prantl"
    $ bump-license-year -n "Ferdinand Prantl" -dv

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Lint and test your code.

## License

Copyright (c) 2025 Ferdinand Prantl

Licensed under the MIT license.
