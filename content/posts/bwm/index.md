---
title: "Boundary Integral Methods"
date: 2023-11-11T21:37:24+09:00
draft: false
category: ["Research"]
tags: ["Numerical Analysis", "Optics", "Quantum Mechanics", "Simulation"]
---

Essentially, a Boundary Integral Method (BIM) reduces the degrees of freedom of a problem to those of the boundary. It also means that the problem becomes *meshless*, which means that there is no need for simple domains.

However, the method relies on a more abstract notion of integral operators (rather than differential equations). Furthermore, most of the matrices are dense, which  While numerical integration can be more stable than numerical differentiation, one may need to project the continuous integral onto a finite-dimensional space of functions, which can be tricky to account for corners (infinite information in Fourier spectrum).

> "...on formulas differentiation is nice and integration is hard, but on computable functions differentiation is hard and integration is nice."
>
> **Jacques Carette**

{{< katex >}}
In the method implemented below, a matrix is associated to the required kernel for the integral operator. The chosen kernel will dictate how well-behaved (or well-conditioned) the matrix will be, and thus which algorithms can be used to solve a system \\(A\bm{x}=\bm{b}\\).

A *BIM* is an example of a [Galerkin method](https://en.wikipedia.org/wiki/Galerkin_method).

## Demonstration
As an example, I play with a boundary in the shape of the *Aphex Twin* logo, which kind of looks like a \\(\lambda\\). One can see how when considering a permeable barrier, the *BIM* appears to imitate a refractive, optical element.

{{< video loop="true" src="./videos/oscillating_potential.mp4" caption="Permeable potential" >}}
When the potential strength tends to infininty, only eigenstates can go through the billiard. This is due to the *transparency* effect whenever one has a plane-wave with energy \\(E_n\propto k_n^2\\) (the eigenenergy of the billiard).
{{< video loop="true" src="./videos/oscillating_resonance.mp4" caption="Oscillating wavenumber" >}}