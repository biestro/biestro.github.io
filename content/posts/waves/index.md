---
title: "Wave Simulations"
date: 2022-12-10T21:37:24+09:00
draft: false
category: ["Computational Physics"]
tags: ["Numerical Analysis","Electrodynamics", "Acoustics", "Simulation"]
---
{{< katex >}}
Wave simulations are essential in optics and electrodynamics. Here are some of the simulations I've done for wave propagation using finite-difference schemes.

The difference between using ABCs and not using these are highlighted in Figures 1 and 2. While the former exhibits reflection phenomena as if the wave's domain was a rectangular container, the latter appears to show only a rectangular section of a larger, encompassing domain. Both have the same time-dependent sinusoidal source applied.

When using Finite Difference Schemes alongside ABCs, one must remember to apply it to the entire boundary. For example, when using a FDM of order \\(O(h^6)\\), the region on the boundary has element-size 3.

## Absorbing Boundary Conditions

The absorbing boundary conditions (ABCs) implemented what Gerrit Mur derived in a [1981 IEEE Transactions article](https://ieeexplore.ieee.org/abstract/document/4091495).

Although Perfectly-Matched-Layer (PML) method is far more robust than traditional ABCs, it has been coded by various software developers (such as in COMSOL) far better than I could. As a rule of thumb, use a PML thickness similar to half the largest wavelength.