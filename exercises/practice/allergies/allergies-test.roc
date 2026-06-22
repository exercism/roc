# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/allergies/canonical-data.json
# File last updated on 2026-06-22

import Allergies exposing [allergic_to, set]

# testing for eggs allergy not allergic to anything
expect {
	result = allergic_to(Eggs, 0)
	result == Bool.False
}

# testing for eggs allergy allergic only to eggs
expect {
	result = allergic_to(Eggs, 1)
	result == Bool.True
}

# testing for eggs allergy allergic to eggs and something else
expect {
	result = allergic_to(Eggs, 3)
	result == Bool.True
}

# testing for eggs allergy allergic to something, but not eggs
expect {
	result = allergic_to(Eggs, 2)
	result == Bool.False
}

# testing for eggs allergy allergic to everything
expect {
	result = allergic_to(Eggs, 255)
	result == Bool.True
}

# testing for peanuts allergy not allergic to anything
expect {
	result = allergic_to(Peanuts, 0)
	result == Bool.False
}

# testing for peanuts allergy allergic only to peanuts
expect {
	result = allergic_to(Peanuts, 2)
	result == Bool.True
}

# testing for peanuts allergy allergic to peanuts and something else
expect {
	result = allergic_to(Peanuts, 7)
	result == Bool.True
}

# testing for peanuts allergy allergic to something, but not peanuts
expect {
	result = allergic_to(Peanuts, 5)
	result == Bool.False
}

# testing for peanuts allergy allergic to everything
expect {
	result = allergic_to(Peanuts, 255)
	result == Bool.True
}

# testing for shellfish allergy not allergic to anything
expect {
	result = allergic_to(Shellfish, 0)
	result == Bool.False
}

# testing for shellfish allergy allergic only to shellfish
expect {
	result = allergic_to(Shellfish, 4)
	result == Bool.True
}

# testing for shellfish allergy allergic to shellfish and something else
expect {
	result = allergic_to(Shellfish, 14)
	result == Bool.True
}

# testing for shellfish allergy allergic to something, but not shellfish
expect {
	result = allergic_to(Shellfish, 10)
	result == Bool.False
}

# testing for shellfish allergy allergic to everything
expect {
	result = allergic_to(Shellfish, 255)
	result == Bool.True
}

# testing for strawberries allergy not allergic to anything
expect {
	result = allergic_to(Strawberries, 0)
	result == Bool.False
}

# testing for strawberries allergy allergic only to strawberries
expect {
	result = allergic_to(Strawberries, 8)
	result == Bool.True
}

# testing for strawberries allergy allergic to strawberries and something else
expect {
	result = allergic_to(Strawberries, 28)
	result == Bool.True
}

# testing for strawberries allergy allergic to something, but not strawberries
expect {
	result = allergic_to(Strawberries, 20)
	result == Bool.False
}

# testing for strawberries allergy allergic to everything
expect {
	result = allergic_to(Strawberries, 255)
	result == Bool.True
}

# testing for tomatoes allergy not allergic to anything
expect {
	result = allergic_to(Tomatoes, 0)
	result == Bool.False
}

# testing for tomatoes allergy allergic only to tomatoes
expect {
	result = allergic_to(Tomatoes, 16)
	result == Bool.True
}

# testing for tomatoes allergy allergic to tomatoes and something else
expect {
	result = allergic_to(Tomatoes, 56)
	result == Bool.True
}

# testing for tomatoes allergy allergic to something, but not tomatoes
expect {
	result = allergic_to(Tomatoes, 40)
	result == Bool.False
}

# testing for tomatoes allergy allergic to everything
expect {
	result = allergic_to(Tomatoes, 255)
	result == Bool.True
}

# testing for chocolate allergy not allergic to anything
expect {
	result = allergic_to(Chocolate, 0)
	result == Bool.False
}

# testing for chocolate allergy allergic only to chocolate
expect {
	result = allergic_to(Chocolate, 32)
	result == Bool.True
}

# testing for chocolate allergy allergic to chocolate and something else
expect {
	result = allergic_to(Chocolate, 112)
	result == Bool.True
}

# testing for chocolate allergy allergic to something, but not chocolate
expect {
	result = allergic_to(Chocolate, 80)
	result == Bool.False
}

# testing for chocolate allergy allergic to everything
expect {
	result = allergic_to(Chocolate, 255)
	result == Bool.True
}

# testing for pollen allergy not allergic to anything
expect {
	result = allergic_to(Pollen, 0)
	result == Bool.False
}

# testing for pollen allergy allergic only to pollen
expect {
	result = allergic_to(Pollen, 64)
	result == Bool.True
}

# testing for pollen allergy allergic to pollen and something else
expect {
	result = allergic_to(Pollen, 224)
	result == Bool.True
}

# testing for pollen allergy allergic to something, but not pollen
expect {
	result = allergic_to(Pollen, 160)
	result == Bool.False
}

# testing for pollen allergy allergic to everything
expect {
	result = allergic_to(Pollen, 255)
	result == Bool.True
}

# testing for cats allergy not allergic to anything
expect {
	result = allergic_to(Cats, 0)
	result == Bool.False
}

# testing for cats allergy allergic only to cats
expect {
	result = allergic_to(Cats, 128)
	result == Bool.True
}

# testing for cats allergy allergic to cats and something else
expect {
	result = allergic_to(Cats, 192)
	result == Bool.True
}

# testing for cats allergy allergic to something, but not cats
expect {
	result = allergic_to(Cats, 64)
	result == Bool.False
}

# testing for cats allergy allergic to everything
expect {
	result = allergic_to(Cats, 255)
	result == Bool.True
}

# list when: no allergies
expect {
	result = set(0)
	result == []->Set.from_list()
}

# list when: just eggs
expect {
	result = set(1)
	result == [Eggs]->Set.from_list()
}

# list when: just peanuts
expect {
	result = set(2)
	result == [Peanuts]->Set.from_list()
}

# list when: just strawberries
expect {
	result = set(8)
	result == [Strawberries]->Set.from_list()
}

# list when: eggs and peanuts
expect {
	result = set(3)
	result == [Eggs, Peanuts]->Set.from_list()
}

# list when: more than eggs but not peanuts
expect {
	result = set(5)
	result == [Eggs, Shellfish]->Set.from_list()
}

# list when: lots of stuff
expect {
	result = set(248)
	result == [Strawberries, Tomatoes, Chocolate, Pollen, Cats]->Set.from_list()
}

# list when: everything
expect {
	result = set(255)
	result == [Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]->Set.from_list()
}

# list when: no allergen score parts
expect {
	result = set(509)
	result == [Eggs, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats]->Set.from_list()
}

# list when: no allergen score parts without highest valid score
expect {
	result = set(257)
	result == [Eggs]->Set.from_list()
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
