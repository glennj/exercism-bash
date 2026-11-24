#!/usr/bin/env bats
load bats-extra
declare lines

# Each test runs in a fresh "downloads" directory that contains
# several files, some with awkward names.
setup() {
    cd "$BATS_TEST_TMPDIR" || return 1
    printf 'hello downloads\n' > 'my report.txt'
    printf 'second file\n' > 'notes [v2].txt'
    printf 'plain\n' > 'a.txt'
    printf 'plain\n' > 'b.txt'
    script="${BATS_TEST_DIRNAME}/messy_downloads.sh"
}

# bats test_tags=task:1
test_looking_at_file_with_spaces() { # @test
    run bash "$script" 'my report.txt' '*.txt' 'note'

    assert_success
    assert_line --index 0 'Looking at "my report.txt"'
}

# bats test_tags=task:1
test_looking_at_file_with_brackets() { # @test
    run bash "$script" 'notes [v2].txt' '*.txt' 'note'

    assert_success
    assert_line --index 0 'Looking at "notes [v2].txt"'
}

# bats test_tags=task:2
test_contents_of_file_with_spaces() { # @test
    run bash "$script" 'my report.txt' '*.txt' 'note'

    assert_success
    assert_line --index 1 'hello downloads'
}

# bats test_tags=task:2
test_contents_of_file_with_brackets() { # @test
    run bash "$script" 'notes [v2].txt' '*.txt' 'note'

    assert_success
    assert_line --index 1 'second file'
}

# bats test_tags=task:3
test_reminder() { # @test
    run bash "$script" 'my report.txt' '*.txt' 'note'

    assert_success
    # shellcheck disable=SC2016
    assert_line --index 2 'Careful: rm * deletes everything and $HOME is your home directory'
}

# bats test_tags=task:4
test_pattern_is_not_expanded() { # @test
    run bash "$script" 'my report.txt' '*.txt' 'note'

    assert_success
    assert_line --index 3 'Pattern: *.txt'
}

# bats test_tags=task:4
test_other_pattern_is_not_expanded() { # @test
    run bash "$script" 'my report.txt' '?.txt' 'note'

    assert_success
    assert_line --index 3 'Pattern: ?.txt'
}

# bats test_tags=task:4
test_pattern_matches_are_listed() { # @test
    run bash "$script" 'my report.txt' '*.txt' 'note'

    assert_success
    assert_line --index 4 'a.txt'
    assert_line --index 5 'b.txt'
    assert_line --index 6 'my report.txt'
    assert_line --index 7 'notes [v2].txt'
}

# bats test_tags=task:4
test_other_pattern_matches_are_listed() { # @test
    run bash "$script" 'my report.txt' '?.txt' 'note'

    assert_success
    assert_line --index 4 'a.txt'
    assert_line --index 5 'b.txt'
    # 6 lines if task 5 is not done yet, 7 if it is.
    # `assert` needs a command, so use `[` here.
    assert [ "${#lines[@]}" -ge 6 ]
    assert [ "${#lines[@]}" -le 7 ]
}

# bats test_tags=task:5
test_note_keeps_its_spaces() { # @test
    run bash "$script" 'my report.txt' '*.txt' 'keep   these   spaces'

    assert_success
    assert_line --index 8 'Note: keep   these   spaces'
}

# bats test_tags=task:5
test_exact_output() { # @test
    run bash "$script" 'my report.txt' '*.txt' 'two  spaces'

    assert_success
    assert_output - <<'END'
Looking at "my report.txt"
hello downloads
Careful: rm * deletes everything and $HOME is your home directory
Pattern: *.txt
a.txt
b.txt
my report.txt
notes [v2].txt
Note: two  spaces
END
}
