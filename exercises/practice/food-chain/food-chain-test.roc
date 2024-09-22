# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/food-chain/canonical-data.json
# File last updated on 2024-09-22
app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.15.0/SlwdbJ-3GR7uBWQo6zlmYWNYOxnvo8r6YABXD-45UOw.tar.br",
}

main =
    Task.ok {}

import FoodChain exposing [recite]

# fly
expect
    result = recite 1 1
    result
    ==
    """
    I know an old lady who swallowed a fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# spider
expect
    result = recite 2 2
    result
    ==
    """
    I know an old lady who swallowed a spider.
    It wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# bird
expect
    result = recite 3 3
    result
    ==
    """
    I know an old lady who swallowed a bird.
    How absurd to swallow a bird!
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# cat
expect
    result = recite 4 4
    result
    ==
    """
    I know an old lady who swallowed a cat.
    Imagine that, to swallow a cat!
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# dog
expect
    result = recite 5 5
    result
    ==
    """
    I know an old lady who swallowed a dog.
    What a hog, to swallow a dog!
    She swallowed the dog to catch the cat.
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# goat
expect
    result = recite 6 6
    result
    ==
    """
    I know an old lady who swallowed a goat.
    Just opened her throat and swallowed a goat!
    She swallowed the goat to catch the dog.
    She swallowed the dog to catch the cat.
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# cow
expect
    result = recite 7 7
    result
    ==
    """
    I know an old lady who swallowed a cow.
    I don't know how she swallowed a cow!
    She swallowed the cow to catch the goat.
    She swallowed the goat to catch the dog.
    She swallowed the dog to catch the cat.
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# horse
expect
    result = recite 8 8
    result
    ==
    """
    I know an old lady who swallowed a horse.
    She's dead, of course!
    """

# multiple verses
expect
    result = recite 1 3
    result
    ==
    """
    I know an old lady who swallowed a fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a spider.
    It wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a bird.
    How absurd to swallow a bird!
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.
    """

# full song
expect
    result = recite 1 8
    result
    ==
    """
    I know an old lady who swallowed a fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a spider.
    It wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a bird.
    How absurd to swallow a bird!
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a cat.
    Imagine that, to swallow a cat!
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a dog.
    What a hog, to swallow a dog!
    She swallowed the dog to catch the cat.
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a goat.
    Just opened her throat and swallowed a goat!
    She swallowed the goat to catch the dog.
    She swallowed the dog to catch the cat.
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a cow.
    I don't know how she swallowed a cow!
    She swallowed the cow to catch the goat.
    She swallowed the goat to catch the dog.
    She swallowed the dog to catch the cat.
    She swallowed the cat to catch the bird.
    She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
    She swallowed the spider to catch the fly.
    I don't know why she swallowed the fly. Perhaps she'll die.

    I know an old lady who swallowed a horse.
    She's dead, of course!
    """

