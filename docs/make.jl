push!(LOAD_PATH,"../src/")

using Documenter
using DataGen

makedocs(sitename="DataGen.jl documentation")
deploydocs(
    repo = "github.com/vly/DataGen.jl.git",
    push_preview = true,
    latest = "main",
)