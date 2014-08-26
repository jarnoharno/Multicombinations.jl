# Multicombinations.jl

[![Build Status](https://travis-ci.org/jlep/Multicombinations.jl.svg?branch=master)](https://travis-ci.org/jlep/Multicombinations.jl)

An iterator for [k-combinations with repetitions](http://en.wikipedia.org/wiki/Combination#Number_of_combinations_with_repetition), k-multicombinations, k-multisubsets or whatever you want to call them.

## Installation

Install this package with `Pkg.clone("git://github.com/jlep/Multicombinations.jl")`

## Usage

-----------

- **multichoose**(n, k)

    Return the number of multisets of length ``k`` on ``n`` symbols.

    Examples
    ```julia
    multichoose(3,2)
    ```
    yields
    ```
    6
    ```

- **multicombinations**(xs, k)

    Iterate over every `k`-size multisubset of a collection ``xs``.

    Example:
    ```julia
    for i in multicombinations([1,2,3],2)
        @show i
    end
    ```
    yields
    ```
    i => [1,1]
    i => [1,2]
    i => [1,3]
    i => [2,2]
    i => [2,3]
    i => [3,3]
    ```

- **integersums**(n, k)

    Iterate over every nonnegative integer solution of the equation:
    _x<sub>1</sub> + x<sub>2</sub> + ... + x<sub>n</sub> = k_.

    The order in which the solutions are given corresponds to the order of
    subsets given by ``multicombinations(xs, k)``.

    Example:
    ```julia
    for i in integersums(3,2)
        @show i
    end
    ```
    yields
    ```
    i => [2,0,0]
    i => [1,1,0]
    i => [1,0,1]
    i => [0,2,0]
    i => [0,1,1]
    i => [0,0,2]
    ```

- **is2mc**(s)

    Convert a solution array given by ``integersums(n, k)`` to the
    corresponding multicombination index array.

    Example:
    ```julia
    for i in integersums(3,2)
        @show is2mc(i)
    end
    ```
    yields
    ```
    is2mc(i) => [1,1]
    is2mc(i) => [1,2]
    is2mc(i) => [1,3]
    is2mc(i) => [2,2]
    is2mc(i) => [2,3]
    is2mc(i) => [3,3]
    ```
