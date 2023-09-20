---
title: "Ising model"
date: 2022-08-08T21:37:24+09:00
draft: false
category: ["Research"]
tags: ["Numerical Analysis", "Statistical Mechanics", "Stochastics", "Simulation"]
---

The Metropolis-Hastings algorithm for simulating the Lenz-Ising model is an excellent example of a Markov chain, since the former is actually a version of a Markov chain Monte Carlo (MCMC) simulation. I present examples based on cartesian and isometric grids.

It follows the Hamiltonian
<div>
</div>

{{< katex >}}
$$
H(\sigma)=-\sum_{\{i,j\}}J_{ij}\sigma_i\sigma_j-\mu\sum_jh_j\sigma_j\ ,
$$

Since the Hamiltonian depends strictly on nearest-neighbours interactions, [it can be used as a model for opinion/voter dynamics](https://ci.ovgu.de/Team/Palina+Bartashevich/Publications/_/Bartashevich2019-Ising.pdf).


For this example, we consider a warping grid of size \\(N\\), where the \\(N+1\\)th index is congruent to the first index \\(\text{mod } N\\). All these fancy words state that the grid behaves as when Pac-Man portals to the opposite side of the screen. This is done in the vertical direction as well, as stated by the expressions ```mod(k,n) + 1, ...)``` (the ```+ 1```s are there just due to ```Julia```'s indexing convention.)

The following function finds the energy in a set of indices \\(\{ii,jj\}\\) (I use this notation to avoid confusion with imaginary numbers.) 

```julia
function energy(mat, J, B, ii, jj)
  N = size(mat, 1);
  H = mat[mod(ii,N),jj]+
      mat[ii,mod(jj,N)+1+mat];
  H *= J;
  H += B;
  return H
end
```

If the resulting configuration is preferable (*i.e. it has a lower energy*), then the system accepts this new state. This allows us to only compute the change in energy at the desired index, instead of the whole array.

## Isometric model.

The same Hamilising_wb_lossy_singletonian can also be extended to a hexagonal or triangular grid. If we think of the isometric grid as being a cartesian grid transformed by some operator \\(\mathbf{f}\\) (as seen below), we realize that the only change to our energy function is the addition of two diagonal indices.

![ising iso 1](img/ising/hex1.png)
![ising iso 2](img/ising/hex2.png)

![ising](img/ising/hex1.png)

The overall effect over large iterations (order of \\(10^7\\)) is the appearance ofpronounced diagonal patterns (Keep in mind that there is some bias due to the heatmap being cartesian in nature.)

![ising iso sl1](img/ising/ising_slanted.png)
![ising iso sl2](img/ising/ising_slanted_2.png)
![ising iso sl3](img/ising/ising_slanted_3.png)

