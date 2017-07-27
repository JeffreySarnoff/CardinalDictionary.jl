struct NBitSet{N}
    bitset::Vector{Int16}
    maxoffset::Int16
    
    function NBitSet(N)
        nInt16s = cld(N, 16)
        zeroed  = zeros(Int16, nInt16s)
        return new{N}(zeroed, nInt16s)
    end
end

Base.length(bitset::NBitSet{N}) where N<:Integer = N
Base.typemax(bitset::NBitSet{N}) where N<:Integer = fldmod(N, 16)

function hasvalue(bitset::NBitSet, index::N) where N<:Integer
    0 < index <= N || throw(ErrorException("index $(index) is outside of the defined domain (1:$(N))")) 
    offset, bitidx = fldmod(index, 16)
    return one(Int16) === (bitset[offset+1] >> 15-bitidx) & one(Int16)
end