#!/usr/bin/env bats
load bats-extra

# bats test_tags=task:1
test_car_needs_a_license() { # @test
    run bash vehicle_purchase.sh car 'Toyota Corolla' 'Wuling Hongguang' 1000 1

    assert_success
    assert_line --index 0 'License needed for car: yes'
}

# bats test_tags=task:1
test_truck_needs_a_license() { # @test
    run bash vehicle_purchase.sh truck 'Toyota Corolla' 'Wuling Hongguang' 1000 1

    assert_success
    assert_line --index 0 'License needed for truck: yes'
}

# bats test_tags=task:1
test_bike_does_not_need_a_license() { # @test
    run bash vehicle_purchase.sh bike 'Toyota Corolla' 'Wuling Hongguang' 1000 1

    assert_success
    assert_line --index 0 'License needed for bike: no'
}

# bats test_tags=task:1
test_stroller_does_not_need_a_license() { # @test
    run bash vehicle_purchase.sh stroller 'Toyota Corolla' 'Wuling Hongguang' 1000 1

    assert_success
    assert_line --index 0 'License needed for stroller: no'
}

# bats test_tags=task:1
test_e_scooter_does_not_need_a_license() { # @test
    run bash vehicle_purchase.sh e-scooter 'Toyota Corolla' 'Wuling Hongguang' 1000 1

    assert_success
    assert_line --index 0 'License needed for e-scooter: no'
}

# bats test_tags=task:1
test_empty_kind_does_not_need_a_license() { # @test
    run bash vehicle_purchase.sh '' 'Toyota Corolla' 'Wuling Hongguang' 1000 1

    assert_success
    assert_line --index 0 'License needed for : no'
}

# bats test_tags=task:2
test_recommends_the_first_option() { # @test
    run bash vehicle_purchase.sh car 'Bugatti Veyron' 'Ford Pinto' 1000 1

    assert_success
    assert_line --index 1 'Bugatti Veyron is clearly the better choice.'
}

# bats test_tags=task:2
test_recommends_the_second_option() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 1000 1

    assert_success
    assert_line --index 1 'Bugatti Veyron is clearly the better choice.'
}

# bats test_tags=task:2
test_recommends_the_shorter_name_first() { # @test
    run bash vehicle_purchase.sh car 'Volkswagen Golf' 'Volkswagen' 1000 1

    assert_success
    assert_line --index 1 'Volkswagen is clearly the better choice.'
}

# bats test_tags=task:2
test_recommends_by_digits_before_letters() { # @test
    run bash vehicle_purchase.sh bike '2020 Gazelle Medeo' '2018 Bergamont City' 1000 1

    assert_success
    assert_line --index 1 '2018 Bergamont City is clearly the better choice.'
}

# bats test_tags=task:2
test_choice_does_not_expand_glob_characters() { # @test
    run bash vehicle_purchase.sh car '*' 'Ford Pinto' 1000 1

    assert_success
    assert_line --index 1 '* is clearly the better choice.'
}

# bats test_tags=task:3
test_price_for_a_new_vehicle() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 1000 1

    assert_success
    assert_line --index 2 'Estimated price: 800'
}

# bats test_tags=task:3
test_price_for_a_vehicle_just_under_three_years() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 1000 2

    assert_success
    assert_line --index 2 'Estimated price: 800'
}

# bats test_tags=task:3
test_price_for_a_three_year_old_vehicle() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 1000 3

    assert_success
    assert_line --index 2 'Estimated price: 700'
}

# bats test_tags=task:3
test_price_for_a_ten_year_old_vehicle() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 1000 10

    assert_success
    assert_line --index 2 'Estimated price: 700'
}

# bats test_tags=task:3
test_price_for_an_eleven_year_old_vehicle() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 1000 11

    assert_success
    assert_line --index 2 'Estimated price: 500'
}

# bats test_tags=task:3
test_price_for_an_old_vehicle_other_price() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 25000 30

    assert_success
    assert_line --index 2 'Estimated price: 12500'
}

# bats test_tags=task:3
test_prints_exactly_three_lines() { # @test
    run bash vehicle_purchase.sh car 'Ford Pinto' 'Bugatti Veyron' 1000 5

    assert_success
    assert_equal "${#lines[@]}" 3
}
