# Instructions

In this exercise, you will write some code to help you prepare to buy a vehicle.

You have three tasks: determine if you will need a license; choose between two vehicles; and estimate the acceptable price for a used vehicle.
Each task adds to the same script, so preserve the output from the previous tasks.
Do not print anything other than the requested output.

The script accepts five command-line arguments:

1. the kind of vehicle, such as `car` or `bike`.
2. the first vehicle you are considering.
3. the second vehicle you are considering.
4. the original price of the vehicle, as a whole number.
5. the age of the vehicle in years, as a whole number.

Run the script with:

```bash
bash vehicle_purchase.sh car 'Wuling Hongguang' 'Toyota Corolla' 1000 5
```

## 1. Determine if you will need a license

Some kinds of vehicles require a license to operate them.
Assume only the kinds `car` and `truck` require a license; everything else can be operated without a license.

The kind of vehicle is given as the first argument.
Print `License needed for KIND: yes` or `License needed for KIND: no`, with `KIND` replaced by that argument.

```text
License needed for car: yes
```

## 2. Choose between two potential vehicles to buy

You have evaluated your options of available vehicles.
You managed to narrow it down to two options but you need help making the final decision.
The decision is the option that comes first in dictionary order.

Print the decision as a sentence.
For the arguments `'Wuling Hongguang' 'Toyota Corolla'`:

```text
Toyota Corolla is clearly the better choice.
```

## 3. Calculate an estimation for the price of a used vehicle

Now that you have made your decision, you want to make sure you get a fair price at the dealership.
Since you are interested in buying a used vehicle, the price depends on how old the vehicle is.
For a rough estimate, assume:

- if the vehicle is less than 3 years old, it costs 80% of the original price it had when it was brand new.
- if it is more than 10 years old, it costs 50%.
- if the vehicle is at least 3 years old but not older than 10 years, it costs 70% of the original price.

Print the estimated price.
For an original price of `1000` and an age of `5`:

```text
Estimated price: 700
```
