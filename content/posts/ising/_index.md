---
title: "Ising model"
date: '2022-08-08'
categories:
- Posts
tags :
- Numerical Analysis
- Statistical Mechanics
- Stochastics
- Simulation
---

The Metropolis-Hastings algorithm for simulating the Lenz-Ising model is an excellent example of a Markov chain, since the former is actually a version of a Markov chain Monte Carlo (MCMC) simulation. I present examples based on cartesian and isometric grids.

It follows the Hamiltonian
\[
H(\sigma)=-\sum_{\{i,j\}}J_{ij}\sigma_i\sigma_j-\mu\sum_jh_j\sigma_j\ ,
\]

Since the Hamiltonian depends strictly on nearest-neighbours interactions, [it can be used as a model for opinion/voter dynamics](https://ci.ovgu.de/Team/Palina+Bartashevich/Publications/_/Bartashevich2019-Ising.pdf).

For this example, we consider a warping grid of size \\(N\\), where the \\(N+1\\)th index is congruent to the first index modulo \(N\). All these fancy words state that the grid behaves as when Pac-Man portals to the opposite side of the screen. This is done in the vertical direction as well, as stated by the expressions ```mod(k,n) + 1, ...)``` (the ```+ 1```s are there just due to ```Julia```'s indexing convention.)

The following function finds the Hamiltonian (or energy) for a matrix element \\(M_{ij}\\) with the interaction between its neighbours, as described by the expression above. It also accounts for external interaction of a magnetic field.

```julia
function hamiltonian(selected_spin, space, interaction, external, locs)

neighbour_spin        = view(space, fill(selected_spin,length(locs)) + locs)
neighbour_interaction = view(interaction,fill(selected_spin,length(locs)) + locs)
H = (-dot(neighbour_interaction, neighbour_spin) * view(space, selected_spin))[1]

H -= sum(view(external, neighbour_spin))
return H
end
```

If the resulting configuration is preferable (*i.e. it has a lower energy*), then the system accepts this new state. This allows us to only compute the change in energy at the desired index, instead of the whole array.

I use the [CircularArrays.jl](https://github.com/Vexatos/CircularArrays.jl) package, which aided in the construction of periodic boundaries.

## 2D example
I present a 2D example of the algorithm in action.

<!-- {{< youtube Tvvh6Dj0KIo >}} -->
{{< video src="Ising 2d.mp4" width="600px" loop="true" autoplay="true" controls="true">}}


## 3D example

The above code is robust to changes in dimensions (as well as the use of graphs). In principle, one would only need to update the corresponding `locs` and `space` dimensions, and the algorithm would do the rest. One can see that it also permits an arbitrary `neighbour_spin` definition, whether it be the original *5 point stencil* (in 2D) or any other setting.

For demonstration purposes, I show a 3D simulation for \\(n_z\in\left\\{5,9\right\\}\\) whith a *9 point stencil* Hamiltonian.

<!-- {{< youtube NyufiY0Mc6o >}} -->
{{< video src="Ising 3d short.mp4" width="600px" loop="true" autoplay="true" controls="true">}}

{{< video src="Ising 3D tall.mp4" width="600px" loop="true" autoplay="true" controls="true">}}

The plots were done using [Makie's volume plot](https://docs.makie.org/stable/reference/plots/volume).

### More posts: