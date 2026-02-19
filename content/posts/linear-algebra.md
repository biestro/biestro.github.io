---
title: "Transverse Ising model"
date: 2026-02-17
icon: "/images/dodecahedron.gif"
---


## Trotterization

Furthermore, since spins can flip as a function of (imaginary) time, they also need to be added.

This is easily seen from the trotterization of the Hamiltonian,

$$
\begin{aligned}
H &= -J \sum_i \sigma^z_i \sigma^z_{i+1} - h \sum_i \sigma_i^x \\
  &= H_z + H_x,
\end{aligned}
$$

and then the partition function

$$
\begin{aligned}
Z &= \mathrm{Tr}\; e^{-\beta H}, \\
  &= \mathrm{Tr}\; e^{-\beta (H_z + H_x)}, \\
  &= \lim_{M \rightarrow \infty}
     \left(e^{\beta H_z/M} e^{\beta H_x/M}\right)^M,
\end{aligned}
$$

where $\beta = \Delta \tau M$ evolves in imaginary time.

This is the result of Path-Integral QMC: the 1D quantum Ising model is mapped to a 2D classical Ising model.

$$
S = -K_s \sum_{i,n} \sigma_{i,n} \sigma_{i+1,n} - K_t
$$

This allows for more statistically independent configurations (because of detailed balance?) to be generated in fewer steps, compared to single spin-flip methods.

The magnetization $|m|$ can distinguish between a ferromagnetic (FM) and a paramagnetic phase.

<!-- ![Magnetization](./ising/ising_m.png) -->

<!-- ![Chi](./ising/ising_chi.png) -->

*Chi*

The Binder cumulant is defined as

$$
U_L = 1 - \frac{\langle m^4 \rangle}{3 \langle m^2 \rangle^2}
$$

<!-- ![Binder parameter](./ising/ising_binder.png) -->

*Binder parameter*

# Transfer Matrix Method
