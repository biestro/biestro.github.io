---
title: "State Equation Based Simulation"
date: 2023-10-11T21:37:24+09:00
draft: false
category: ["Fun"]
tags: ["Numerical Analysis", "Fluids", "Elastic Solids", "Simulation"]
---


There is a technique called *Smoothed Particle Hydrodynamics* ([SPH](https://arxiv.org/abs/2009.06944)) which deals with simulating the behaviour of continuous media such as fluids, deformable solids, and viscous materials. It is a type of **phenomenological simulation**, as it consists of heuristic arguments rather than physical principles. We'll come back to this. While SPH was originally formulated for computational astrophysics, it has seen a rise in current graphics research, as it produces impressive visuals. The technique, however, might not be as accurate (due to its phenomenological nature) compared to other methods (especially in non-linear regimes), but one can gain valuable insight (and animations!) from studying its foundations.

# Discretization
## Kernels

{{< katex >}}
Integration is hard by hand, but it is easy in numerics. SPH deals mainly with the discretization of spatial differential operators. Point particles can be represented by Dirac's delta "function", which we must also approximate through a *smoothing-kernel*,

$$
(A \ast \delta)(\mathbf{x})\approx\int\mathrm{d^n}x\'\\,A(\mathbf{x}\')W(\mathbf{x}-\mathbf{x}\',h).
$$

This kernel choice is similar to that of choosing the [Lennard-Jones potential](https://en.wikipedia.org/wiki/Lennard-Jones_potential) in molecular dynamics. It is a simplified model that describes the essential behaviour of a type of dynamics we are trying to replicate. There are some fundamental properties that \\(W\\) needs to exhibit for it to be a useful kernel (normalized, compact support, its limit as \\(h\rightarrow 0\\) has to be a delta function, etc.). We use the [cubic-spline kernel](https://ui.adsabs.harvard.edu/abs/1992ARA%26A..30..543M/abstract).

## From integrals to sums
Having defined a kernel with said properties, one can begin to discretize the behaviour of some other operators by first discretizing the kernel itself,
\\[ (A\ast W)(\mathbf{x}_i)\approx\sum\_{j}m_j\frac{A_j}{\rho_j}\\,W(\mathbf{x}-\mathbf{x}_j,h).\\]

Further reading of the [original paper](https://ui.adsabs.harvard.edu/abs/1992ARA&A..30..543M/abstract) by J. J. Monaghan will show that one can define the density and velocity through the following expressions,

\\begin{align}
\boldsymbol{\nabla} A(\mathbf{r})&=\sum\_j m\_j\frac{A_j}{\rho_j}\\, \boldsymbol{\nabla}W(\mathbf{r}-\mathbf{r}_j,h)\\\\
\rho\_i(\boldsymbol{\nabla}\cdot\mathbf{v})_i&=\sum\_j(\mathbf{v}_i-\mathbf{v}_j)\cdot\boldsymbol{\nabla}\\,W\_{ij}\\\\
\\end{align}

These equations can be unstable and have large errors, which is why in the [paper by Koschier, *et. al.*](https://arxiv.org/abs/2009.06944), there is a section dedicated to better approximations for such operators. (Note that for the animation, I had to calculate the densities at all grid points.)

# Phenomenology?

SPH however has the advantage (or disadvantage) of being mesh-free, as we are only interested in the position of each particle relative to each other. Nonetheless, this comes at a price. Fine tuning a SPH model is done in a heuristic manner, based upon trial and error, observation, and our understanding of macroscopic behaviours in fluids. This is why it is not always feasible nor accurate to use it for non-linear regimes and incompressible dynamics. This is why it is used in real-time animations and games; we shift our focus from accuracy to interactivity.

# Conclusion
I hope this was enough introduction to SPH, and that you too try to experiment with the model!

{{< video autoplay="true" loop="true" src="./time_animation_rand.mp4" >}}
