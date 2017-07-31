struct CardinalDict{K,V} <: Associative{K,V}
    valued::BitArray{1}
    values::Vector{V}
    
    function CardinalDict{V}(n::K) where K<:Integer where V
        valued = falses(n)
        values = Vector{V}(n)
        T = type_for_indexing(n)
        return new{T,V}(valued, values)
    end
end

@inline function Base.haskey(dict::CardinalDict{K,V}, key::K) where K where V
   return getindex(dict.valued, key)
end
@inline Base.haskey(dict::CardinalDict{K,V}, key::J) where J where K where V =
    getindex(dict, convert(K,key))

function Base.getindex(dict::CardinalDict{K,V}, key::K) where K where V
    haskey(dict, key) || throw(ErrorException("Key (index) $(key) has not been given a value"))
    @inbounds return dict.values[key]
end
@inline Base.getindex(dict::CardinalDict{K,V}, key::J) where J where K where V =
    getindex(dict, convert(K,key))

function Base.get(dict::CardinalDict{K,V}, key::K, default::V) where K where V
    return haskey(dict, key) ? dict.values[key] : default
end
@inline Base.get(dict::CardinalDict{K,V}, key::J, default::V) where J where K where V =
    get(dict, convert(K,key), default)

function Base.setindex!(dict::CardinalDict{K,V}, value::V, key::K) where K where V
    0 < key <= length(dict) || throw(ErrorException("Key (index) $(key) is outside of the domain 1:$(length(dict))."))
    @inbounds begin
        dict.valued[key] = true
        dict.values[key] = value
    end
    return dict
end
@inline Base.setindex!(dict::CardinalDict{K,V}, value::V, key::J) where J where K where V =
    setindex!(dict, value, convert(K,key))

function clearindex!(dict::CardinalDict{K,V}, key::K) where K where V
    0 < key <= length(dict) || throw(ErrorException("Key (index) $(key) is outside of the domain 1:$(length(dict))."))
    @inbounds dict.valued[key] = false
    return dict
end
@inline clearindex!(dict::CardinalDict{K,V}, key::J) where J where K where V =
    clearindex!(dict, convert(K,key))

        

        