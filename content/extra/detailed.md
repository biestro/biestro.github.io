---
title: "My research (detailed)"
date: 2026-06-30
# icon: "/images/dodecahedron.gif"
draft: false
---

# Panorama

DFT is the workhorse of any modern computational materials, but it is limited by its computational implementation. Even with High-Performance-Computing centers, the ever-growing demands of materials science makes DFT calculations expensive (sometimes even prohibitely expensive). 

I work with a technique called *Wannierization* that can be applied after an inexpensive DFT calculation, albeit not highly accurate, in order to reduce the complexity of any *a posteriori* calculation that requires higher accuracy (say interpolation, magnetic-force-theorem, etc.). 

Wannierization in itself is an interesting problem, but the **main goal** of using such tools is to discover new materials with interesting magnetic behaviour (high-throughput searches).

# Questions we want to answer

Picture the *magnetic exchange interaction*. Starting from a very simple two-body configuration, it is through localized orbitals that one obtains an exchange of the form

$$
J=J_D + \frac{U}{4}-\sqrt{t^2+\frac{U^2}{16}},
$$

where $U$ and $t$ are integrals related to the on-site Coulomb interaction and the hopping parameter. From the picture below, it 

![overlap](overlap.svg)

Of course, this is anlogous to how exchange is studied in molecules. Here, a localized *atomic orbital* basis may suffice (though not always). In solids, however, Wannier functions are a complete description of the electronic structure. In other words, there is a direct way to build these Wannier orbitals starting from the Bloch wavefunctions. In practice, this construction is obstructed by numerous details that fit better in [another post](../../zettelkasten/wannier). Furthermore, assuming that one gets the localized orbital picture, the methods for obtaining $J$ starting from such basis functions is also its own [challenge](https://tb2j.readthedocs.io/en/latest/src/faq.html).

Nonetheless, expressions like this bring a lot of intuition (e.g. an orbital-decomposed $J$), and while their predictions might be off for certain materials, these limits also tell a nice story of what's going on with the electrons in a material, and that's what makes them valuable.

More standard applications of Wannier functions are interpolating band-structure (in a Slater-Koster sense), evaluation of transport quantities (from a Berry phase approach).
