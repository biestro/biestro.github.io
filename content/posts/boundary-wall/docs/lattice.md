# Lattices & Grids

These methods implement grids similar to a Bravais lattice, as well as 
their repetition scheme.

## Constructors

## Methods

All `buildGrid` functions construct a grid with $n\\_1\times n\\_2$ 
elements (depending on their basis vectors).

```@docs
buildGrid
```

```@example grids
buildGrid(HexagonalGrid(SVector(0.0, 0.0), 0.5), 8, 6) |> scatter
```

One can use these as centers for other boundaries.

```julia
using LinearAlgebra
using StaticArrays: SVector

import BoundaryWall as BWM

N    = 9                         # number of points per element
R    = 1.0
θ    = LinRange(0, 2pi, N+1)
TH   = 180                  # incident angle

STEP = 2.0R + R/2 # diameter  + constant
N_CIRCLES = (10,7)
RANGES = [-(N_CIRCLES[1]-1)*STEP/2:STEP:(N_CIRCLES[1]-1)*STEP/2,-(N_CIRCLES[2]-1)*STEP/2:STEP:(N_CIRCLES[2]-1)*STEP/2]
N_STEPS =length(RANGES)
CENTERS = vec([(i, j) for i in RANGES[1], j in RANGES[2]])

# delete some indices
INDICES = sort([31,32,33,43,44,45,46,47,48,38,39, 40, 23, 24, 25, 26, 27, 28])

deleteat!(CENTERS, INDICES)

CIRCLES = [BWM.createCircle(R, θ, SVector(cen)) for cen in CENTERS]
# ...
```

One then can proceed to plot such circles. The details can be found in 

![alt text](../src/assets/photonic_diagram.svg)
