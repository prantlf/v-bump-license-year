# Bump License Year

Bumps the last year in the license text in `LICENSE` and `README.md` files.

## Synopsis

    ❯ bump-license-year
    Replacing LICENSE: Copyright (c) 2023-2025 Ferdinand Prantl
    Replacing README.md: Copyright (c) 2023-2025 Ferdinand Prantl
    [master 20c7728] docs: Bump license year
     2 files changed, 2 insertions(+), 2 deletions(-)

### Commit

    20c7728 (HEAD -> master) docs: Bump license year
    LICENSE   | 2 +-
    README.md | 2 +-
    2 files changed, 2 insertions(+), 2 deletions(-)

    diff --git a/LICENSE b/LICENSE
    index 46f4fc0..030ef72 100644
    --- a/LICENSE
    +++ b/LICENSE
    @@ -1,6 +1,6 @@
    MIT License

    -Copyright (c) 2023-2024 Ferdinand Prantl
    +Copyright (c) 2023-2025 Ferdinand Prantl

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    diff --git a/README.md b/README.md
    index 6bb5f51..bea5fa0 100644
    --- a/README.md
    +++ b/README.md
    @@ -256,7 +256,7 @@ In lieu of a formal styleguide, take care to maintain the existing coding style.

    ## License

    -Copyright (c) 2023-2024 Ferdinand Prantl
    +Copyright (c) 2023-2025 Ferdinand Prantl

    Licensed under the MIT license.

## Usage

    bump-license-year [options]

### Options

    -m|--message <message>  commit message
    -n|--name <name>        owner of the license (default is git user.name)
    -y|--year <year>        the last year (default is the current one)
    -d|--dry-run            print the changes on the console only
    -v|--verbose            print the changes on the console too
    -V|--version            print the version of the executable and exits
    -h|--help               print the usage information and exits

The default commit message: "docs: Bump license year".

###  Examples:

    $ bump-license-year
    $ bump-license-year -n "Ferdinand Prantl" -dv

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Lint and test your code.

## License

Copyright (c) 2025 Ferdinand Prantl

Licensed under the MIT license.
