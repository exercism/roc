# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/allergies/canonical-data.json
# File last updated on 2025-01-04
app [main!] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import pf.Stdout

main! = |_args|
    Stdout.line!("")

import Allergies exposing [allergic_to, set]

# testing for eggs allergy not allergic to anything
expect
    result = allergic_to(Eggs, 0)
    result == Bool.false

# testing for eggs allergy allergic only to eggs
expect
    result = allergic_to(Eggs, 1)
    result == Bool.true

# testing for eggs allergy allergic to eggs and something else
expect
    result = allergic_to(Eggs, 3)
    result == Bool.true

# testing for eggs allergy allergic to something, but not eggs
expect
    result = allergic_to(Eggs, 2)
    result == Bool.false

# testing for eggs allergy allergic to everything
expect
    result = allergic_to(Eggs, 255)
    result == Bool.true

# testing for peanuts allergy not allergic to anything
expect
    result = allergic_to(Peanuts, 0)
    result == Bool.false

# testing for peanuts allergy allergic only to peanuts
expect
    result = allergic_to(Peanuts, 2)
    result == Bool.true

# testing for peanuts allergy allergic to peanuts and something else
expect
    result = allergic_to(Peanuts, 7)
    result == Bool.true

# testing for peanuts allergy allergic to something, but not peanuts
expect
    result = allergic_to(Peanuts, 5)
    result == Bool.false

# testing for peanuts allergy allergic to everything
expect
    result = allergic_to(Peanuts, 255)
    result == Bool.true

# testing for shellfish allergy not allergic to anything
expect
    result = allergic_to(Shellfish, 0)
    result == Bool.false

# testing for shellfish allergy allergic only to shellfish
expect
    result = allergic_to(Shellfish, 4)
    result == Bool.true

# testing for shellfish allergy allergic to shellfish and something else
expect
    result = allergic_to(Shellfish, 14)
    result == Bool.true

# testing for shellfish allergy allergic to something, but not shellfish
expect
    result = allergic_to(Shellfish, 10)
    result == Bool.false

# testing for shellfish allergy allergic to everything
expect
    result = allergic_to(Shellfish, 255)
    result == Bool.true

# testing for strawberries allergy not allergic to anything
expect
    result = allergic_to(Strawberries, 0)
    result == Bool.false

# testing for strawberries allergy allergic only to strawberries
expect
    result = allergic_to(Strawberries, 8)
    result == Bool.true

# testing for strawberries allergy allergic to strawberries and something else
expect
    result = allergic_to(Strawberries, 28)
    result == Bool.true

# testing for strawberries allergy allergic to something, but not strawberries
expect
    result = allergic_to(Strawberries, 20)
    result == Bool.false

# testing for strawberries allergy allergic to everything
expect
    result = allergic_to(Strawberries, 255)
    result == Bool.true

# testing for tomatoes allergy not allergic to anything
expect
    result = allergic_to(Tomatoes, 0)
    result == Bool.false

# testing for tomatoes allergy allergic only to tomatoes
expect
    result = allergic_to(Tomatoes, 16)
    result == Bool.true

# testing for tomatoes allergy allergic to tomatoes and something else
expect
    result = allergic_to(Tomatoes, 56)
    result == Bool.true

# testing for tomatoes allergy allergic to something, but not tomatoes
expect
    result = allergic_to(Tomatoes, 40)
    result == Bool.false

# testing for tomatoes allergy allergic to everything
expect
    result = allergic_to(Tomatoes, 255)
    result == Bool.true

# testing for chocolate allergy not allergic to anything
expect
    result = allergic_to(Chocolate, 0)
    result == Bool.false

# testing for chocolate allergy allergic only to chocolate
expect
    result = allergic_to(Chocolate, 32)
    result == Bool.true

# testing for chocolate allergy allergic to chocolate and something else
expect
    result = allergic_to(Chocolate, 112)
    result == Bool.true

# testing for chocolate allergy allergic to something, but not chocolate
expect
    result = allergic_to(Chocolate, 80)
    result == Bool.false

# testing for chocolate allergy allergic to everything
expect
    result = allergic_to(Chocolate, 255)
    result == Bool.true

# testing for pollen allergy not allergic to anything
expect
    result = allergic_to(Pollen, 0)
    result == Bool.false

# testing for pollen allergy allergic only to pollen
expect
    result = allergic_to(Pollen, 64)
    result == Bool.true

# testing for pollen allergy allergic to pollen and something else
expect
    result = allergic_to(Pollen, 224)
    result == Bool.true

# testing for pollen allergy allergic to something, but not pollen
expect
    result = allergic_to(Pollen, 160)
    result == Bool.false

# testing for pollen allergy allergic to everything
expect
    result = allergic_to(Pollen, 255)
    result == Bool.true

# testing for cats allergy not allergic to anything
expect
    result = allergic_to(Cats, 0)
    result == Bool.false

# testing for cats allergy allergic only to cats
expect
    result = allergic_to(Cats, 128)
    result == Bool.true

# testing for cats allergy allergic to cats and something else
expect
    result = allergic_to(Cats, 192)
    result == Bool.true

# testing for cats allergy allergic to something, but not cats
expect
    result = allergic_to(Cats, 64)
    result == Bool.false

# testing for cats allergy allergic to everything
expect
    result = allergic_to(Cats, 255)
    result == Bool.true

# list when: no allergies
expect
    result = set(0)
    result == Set.from_list([])

# list when: just eggs
expect
    result = set(1)
    result == Set.from_list([Eggs])

# list when: just peanuts
expect
    result = set(2)
    result == Set.from_list([Peanuts])

# list when: just strawberries
expect
    result = set(8)
    result == Set.from_list([Strawberries])

# list when: eggs and peanuts
expect
    result = set(3)
    result == Set.from_list([Eggs, Peanuts])

# list when: more than eggs but not peanuts
expect
    result = set(5)
    result == Set.from_list([Eggs, Shellfish])

# list when: lots of stuff
expect
    result = set(248)
    result == Set.from_list([Strawberries, Tomatoes, Chocolate, Pollen, Cats])

# list when: everything
expect
    result = set(255)
    result == Set.from_list([Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats])

# list when: no allergen score parts
expect
    result = set(509)
    result == Set.from_list([Eggs, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats])

# list when: no allergen score parts without highest valid score
expect
    result = set(257)
    result == Set.from_list([Eggs])

