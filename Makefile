# Allow to use a different pandoc binary, e.g. when testing.
PANDOC = pandoc
# Allow to adjust the diff command if necessary
DIFF = diff

# Test that running the filter on the sample input document yields the
# expected output.
#
# The automatic variable `$<` refers to the first dependency (i.e., the
# filter file), so it's enough to update the first line after changing
# the name.
test: greetings.lua test/input.md
	$(PANDOC) --lua-filter=$< --to=native --standalone test/input.md | \
		$(DIFF) test/expected.native -

# Ensure that the `test` target is run each time it's called.
.PHONY: test

# Re-generate the expected output. This file **must not** be a
# dependency of the `test` target, as that would cause it to be
# regenerated on each run, making the test pointless.
test/expected.native: greetings.lua test/input.md
	$(PANDOC) --lua-filter=$< --standalone --to=native --output=$@ \
		test/input.md
