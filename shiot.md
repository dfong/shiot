## Shell I/O tester

### Synopsis

	shiot [-C] [-hv] TEST_SUITE_FILE ...

	shiot [-hv] < TEST_SUITE_FILE

### Description

shiot is a tool intended to facilitate testing of scripts.
It is intended for functional testing (as opposed to unit testing).
It can also be used to test anything that can be called by the shell.
Each `TEST_SUITE_FILE` is a collection of tests.  Each test spec
consists of a block of lines, specifying these 4 data items:

* A command to run (mandatory).
Specify the command on a line beginning with the ! character.
* Its expected exit status (optional, with default 0).
Specify the exit status on a line beginning with the ? character.
* Its input on stdin, if any (optional, with default of no input).
Specify each line of input on a line beginning with the < character.
* Its output on stdout, if any (optional, with a default of no output).
Specify each line of output on a line beginning with the > character.
* Its error output on stderr, if any (optional, with default of none).
Specify each line out error output on a line beginning with the / character.

The command line (!) begins the test spec.

Within the file, blank lines and lines beginning with the # character
are considered comments, and are ignored.

For each test, shiot executes the command with the given input,
and compares the stdout, stderr, and exit status to the expected values.
If they match, the test passes.  Otherwise it is considered a failure.
At the end of each file, shiot reports the number of failures.
It's considered a success if all tests pass.

### Flags

-C: The -C option directs shiot to change directory to the parent dir
of each `TEST_SUITE_FILE` before running its tests.  (Under the
assumption the test commands refer to resources in the same directory.)

-D: An option to aid in debugging the command(s) being tested.
The -D option tells shiot to ignore stdout/stderr lines
that begin with either # or DEBUG.  They are not compared to
the expected stdout/stderr.

-T: This option runs python's doctest module on shiot.
This is for testing shiot itself.

-d: An option for debugging shiot itself.

-h: Print a usage message and exit.

-v: Run the tests verbosely.

### Exit status

shiot exits with status 0 if all the tests passed.

### Examples:

Here is a `TEST_SUITE_FILE` for the script of one of the exercises.

	# test cases for whyq
	! whyq ''
	>[] is the empty string
	?0

	! whyq 'a string with  spaces'
	>[a string with  spaces] contains whitespace
	?0

	! whyq '*junk*'
	>[*junk*] contains globchars
	?0

	! whyq '"'
	>["] is not special
	?0

	! whyq 'spaces and ?'
	>[spaces and ?] contains whitespace
	>[spaces and ?] contains globchars
	?0

	! whyq ordinary
	>[ordinary] is not special
	?0

	! whyq ']'
	>[]] contains globchars
	?0

If the whyq script behaves as expected, then "shiot whyq-tests"
should yield this output:

	$ shiot whyq-tests
	whyq-tests: OK (7 passed)
	Global: OK (7 passed in 1 files)

Here's a trivial example:

	$ shiot < /dev/null
	<STDIN>: OK (0 passed)

