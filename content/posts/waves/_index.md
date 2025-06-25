---
title: "Wave simulations"
date: '2023-06-11'
categories: 
    - Posts
tags:
    - FDTD
    - Simulation
---

Wave simulations are essential in optics and electrodynamics. Here are some of the simulations I've done for wave propagation using finite-difference schemes.

{{< video src=tesseract.mp4 width="500px" loop="true" autoplay="true" controls="false">}}

## Discrete wave equation

In general, using a FDTD scheme is just a fancy way of discretizing a differential operator. In this case, we want to discretize the following equation,

\[\partial^2_{t}\psi(\mathbf{r},t)-\alpha^2{\Delta}\psi(\mathbf{r},t)=0\quad (+\phi),\]

with \(\Delta\) being Laplace's operator. One can also add a source term, \(\phi\), but this does not cause any major differences when discretizing the homogeneous equation. [Wikipedia's page on the Discrete Laplace Operator](https://en.wikipedia.org/wiki/Discrete_Laplace_operator) gives a great insight into how the method works for \(\mathcal{O}(h^2)\) error. Long story short, we deal with a generalization of the central finite difference method for higher dimensions. In 1D, one has the coefficients \((1,-2,1)\), which discretize \(\partial_x^2\). In 2D, the same coefficients apply, but now in the perpendicular direction. In a cartesian grid, this translates to having a column vector of coefficients \((1,2,1)^T\). For 3D, the same methodology applies. Having the connection between the differential operator and its discrete version \(\Delta_{x,y,z}\rightarrow \mathbf{D}_{i,j,k}^2\), one can infer the structure of the *kernel* to be used,

\[\Delta\equiv\partial^2_x+\partial^2_y+\partial_z^2\]

\[\mathbf{D}_{i,j,k}^2\equiv\mathbf{D}^2_i+\mathbf{D}^2_j+\mathbf{D}^2_k\]

\[\mathbf{D}^2_{(i,j,k=-1)}=
\begin{pmatrix}
0&0&0\\
0&1&0\\
0&0&0\\
\end{pmatrix},\quad \mathbf{D}^2_{(i,j,k=0)}=\begin{pmatrix}0&1&0\\1&-6&1\\0&1&0\end{pmatrix},\quad\mathbf{D}^2_{(i,j,k=1)}=\begin{pmatrix}0&0&0\\0&1&0\\0&0&0\end{pmatrix}\]

In fact, image processing software and tools use this types of convolution kernels for filters and other algorithms. For hicher precision, one replaces the centered difference with its respective weights (these are listed in [this page](https://en.wikipedia.org/wiki/Finite_difference_coefficient)). Although more precise, it has the disadvantage of requiring a bigger stencil and having wider boundaries.

## Absorbing Boundary Conditions

When using Finite Difference Schemes alongside ABCs, one must remember to apply it to the entire boundary. For example, when using a FDM of order \(O(h^6)\), the region on the boundary has element-size 3. The absorbing boundary conditions (ABCs) implemented what Gerrit Mur derived in a [1981 IEEE Transactions article](https://ieeexplore.ieee.org/abstract/document/4091495). Although Perfectly-Matched-Layer (PML) method is far more robust than traditional ABCs, it has been coded by various software developers (such as in COMSOL) far better than I could. As a rule of thumb, use a PML thickness similar to half the largest wavelength.

### 3D example

At the top of the page I present a 3D solution of the discrete wave equation, using an approximation with error \(\mathcal{O}(h^6)\), with absorbing boundary conditions.


### More posts: