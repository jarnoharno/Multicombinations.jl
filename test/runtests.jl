using Multicombination
using Base.Test

# multichoose

@test multichoose(3,2) == 6
@test multichoose(3,0) == 1
@test multichoose(0,3) == 0
@test multichoose(0,0) == 1
@test multichoose(-1,-1) == 0

# multicombinations

@test collect(multicombinations("abc",3)) == ["aaa","aab","aac","abb","abc","acc","bbb","bbc","bcc","ccc"]
@test collect(multicombinations("åäö",3)) == ["ååå","ååä","ååö","åää","åäö","åöö","äää","ääö","äöö","ööö"]
@test collect(multicombinations("abc",0)) == collect(combinations("abc",0))
@test collect(multicombinations("",1)) == collect(combinations("",1))
@test collect(multicombinations("",0)) == collect(combinations("",0))
@test collect(multicombinations("",-1)) == collect(combinations("",-1))

# integersums

@test collect(integersums(3,3)) == {[3,0,0],[2,1,0],[2,0,1],[1,2,0],[1,1,1],[1,0,2],[0,3,0],[0,2,1],[0,1,2],[0,0,3]}
@test collect(integersums(3,0)) == {[0,0,0]}
@test collect(integersums(0,3)) == {}
@test collect(integersums(0,0)) == {[]}
@test collect(integersums(-1,-1)) == {}

# is2mc

@test map(is2mc,integersums(3,3)) == collect(multicombinations(1:3,3))
@test map(is2mc,integersums(3,0)) == collect(multicombinations(1:3,0))
@test map(is2mc,integersums(0,3)) == collect(multicombinations([],3))
@test map(is2mc,integersums(0,0)) == collect(multicombinations([],0))

# length

@test length(collect(multicombinations("abc",3))) == length(multicombinations("abc",3))
@test length(collect(multicombinations("åäö",3))) == length(multicombinations("åäö",3))
@test length(collect(integersums(3,3))) == length(integersums(3,3))
