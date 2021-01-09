[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://vly.github.io/DataGen.jl/stable) [![CircleCI](https://circleci.com/gh/vly/DataGen.jl.svg?style=shield)](https://circleci.com/gh/vly/DataGen.jl) [![codecov](https://codecov.io/gh/vly/DataGen.jl/branch/main/graph/badge.svg?token=4GRUCDJL9D)](https://codecov.io/gh/vly/DataGen.jl)

DataGen.jl
============

DataGen aims to provide a tool set for creation of synthetic timeseries data.

Example use:
```julia
julia> using DataGen

julia> sample_data = gen_ts()
365×4 DataFrame
 Row │ sample     trends   seasonality  remainder  
     │ Float64    Float64  Float64      Float64    
─────┼─────────────────────────────────────────────
   1 │  0.828964      0.0          1.0  -0.171036
   2 │ -1.91611      -3.0          1.0   0.0838861
   3 │ -1.77674      -3.0          1.0   0.223256
...

```

## Acknowledgements

Thanks to (@LeeDoYup)[github.com/leedoyup] for his work on Robust STL implementation along with the sample generation code that got me started. 
