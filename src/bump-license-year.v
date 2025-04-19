import os { read_lines, write_file }
import time { now }
import strconv { format_int }
import prantlf.cli { Cli, run }
import prantlf.debug { new_debug }
import prantlf.osutil { execute }
import prantlf.pcre2 { NoMatch, NoReplace, RegEx, pcre2_compile }

const version = '0.2.1'

const usage = 'Bumps the last year in the license text in LICENSE and README.md files.

Usage: bump-license-year [options]

Options:
  -m|--message <message>  commit message
  -n|--name <name>        owner of the license (default is git user.name)
  -y|--year <year>        the last year (default is the current one)
  -d|--dry-run            print the changes on the console only
  -v|--verbose            print the changes on the console too
  -V|--version            print the version of the executable and exits
  -h|--help               print the usage information and exits

The default commit message: "docs: Bump license year".

Examples:
  $ bump-license-year
  $ bump-license-year -n "Ferdinand Prantl" -dv'

struct Opts {
	message string = 'docs: Bump license year'
	name    string
	year    string
	verbose bool
	dry_run bool @[json: 'dry-run']
}

const d = new_debug('bump-license-year')

fn main() {
	run(Cli{
		usage:   usage
		version: version
	}, body)
}

fn body(mut opts Opts, _args []string) ! {
	name := if opts.name != '' {
		opts.name
	} else {
		get_name()!
	}
	year := if opts.year != '' {
		opts.year
	} else {
		get_year()
	}
	two_year_re := pcre2_compile(' (\\d+)-(\\d+) ${name}$', 0)!
	defer { two_year_re.free() }
	one_year_re := pcre2_compile(' (\\d+) ${name}', 0)!
	defer { one_year_re.free() }
	mut replaced := false
	if bump_license_year('LICENSE', name, year, two_year_re, one_year_re, opts)! {
		replaced = true
	}
	if bump_license_year('README.md', name, year, two_year_re, one_year_re, opts)! {
		replaced = true
	}
	if replaced {
		output := execute('git commit -am "${opts.message}"')!
		println(output)
		if opts.verbose {
			commit := execute('git show')!
			println(commit)
		}
	}
}

fn get_name() !string {
	name := execute('git config user.name')!
	d.log('git user.name: "%s"', name)
	return name
}

fn get_year() string {
	current_time := now()
	year := format_int(current_time.year, 10)
	d.log('current year: "%s"', year)
	return year
}

fn bump_license_year(file_name string, name string, year string, two_year_re &RegEx, one_year_re &RegEx, opts &Opts) !bool {
	dfile_name := d.rwd(file_name)
	d.log('reading "%s"', dfile_name)
	lines := read_lines(file_name)!
	d.log('received %d lines', lines.len)
	dry_run := if opts.dry_run {
		' (dry run)'
	} else {
		''
	}
	mut new_lines := []string{len: 0, cap: lines.len + 1}
	mut different := false
	mut replaced := false
	for line in lines {
		if replaced {
			new_lines << line
			continue
		}
		if new_line := two_year_re.replace(line, ' $1-${year} ${name}', pcre2.opt_replace_groups) {
			d.log('replacing "%s" with "%s"', line, new_line)
			println('Replacing ${file_name}${dry_run}: ${new_line}')
			new_lines << new_line
			different = line != new_line
			replaced = true
		} else {
			if err is NoMatch {
				if new_line := one_year_re.replace(line, ' $1-${year} ${name}', pcre2.opt_replace_groups) {
					d.log('replacing "%s" with "%s"', line, new_line)
					println('Replacing ${file_name}${dry_run}: ${new_line}')
					new_lines << new_line
					different = line != new_line
					replaced = true
				} else {
					if err is NoMatch {
						new_lines << line
					} else if err is NoReplace {
						d.log('no need to replace "%s"', line)
						println('Retaining ${file_name}${dry_run}: ${line}')
						new_lines << line
						different = false
						replaced = true
					} else {
						return err
					}
				}
			} else if err is NoReplace {
				d.log('no need to replace "%s"', line)
				println('Retaining ${file_name}${dry_run}: ${line}')
				new_lines << line
				different = false
				replaced = true
			} else {
				return err
			}
		}
	}
	if replaced {
		if different {
			if !opts.dry_run {
				d.log('writing "%s"', dfile_name)
				new_lines << ''
				new_text := new_lines.join('\n')
				write_file(file_name, new_text)!
				return true
			}
		}
	} else {
		println('No license line found in "${file_name}".')
	}
	return false
}
