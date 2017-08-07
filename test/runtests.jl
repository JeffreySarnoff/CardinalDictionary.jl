using CardinalDicts
using Base.Test

#=
  create an CardinalDict with indices 1:20 that holds Int64 values
  check length
  confirm keymax
  populate it
  use it
  unset an index
  check it
  reassign an indexable value
=#

FactorialDict = CardinalDict{Int64}(20);

@test length(FactorialDict) == 0
@test keymax(FactorialDict) == 20

for i in 1:20
    setindex!(FactorialDict, factorial(i), i)
end

@test length(FactorialDict) == 20

@test haskey(FactorialDict, 17) == true
@test FactorialDict[17] == factorial(17)

clearindex!(FactorialDict, 17)
@test haskey(FactorialDict, 17) == false
@test get(FactorialDict, 17, 0) == 0
FactorialDict[17] = factorial(17)
@test FactorialDict[17] == factorial(17)

vec = [1.0, 3.0, 2.0]
fromvec = CardinalDict(vec)
@test fromvec[2] == 3.0
@test keymax(fromvec) == 3
@test isfull(fromvec) == true

# Container, Associative interface

Tenfold = CardinalDict{Int32}(40)
@test length(Tenfold) == 0
@test endof(Tenfold) == 0
@test keys(Tenfold) == []
@test values(Tenfold) == []
Tenfold[20] = 200%Int32
Tenfold[25] = 250%Int32
Tenfold[26] = 260%Int32
@test length(Tenfold) == 3
@test endof(Tenfold) == 26
@test keys(Tenfold) == Int8[20, 25, 26]
@test values(Tenfold) == Int32[200, 250, 260]
@test eltype(tenfold) == Pair{Int8, Int32}


