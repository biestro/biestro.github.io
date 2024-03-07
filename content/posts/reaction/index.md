---
title: "Belousov-Zhabotinsky Reaction"
date: 2024-02-12T22:21:00+09:00
draft: true
category: ["Research"]
tags: ["Numerical Analysis","Stochastics", "Simulation", "Chemistry"]
---

Recently, someone sent me a nice paper on something called a [*Belousov-Zhabotinsky* reaction](https://discovery.ucl.ac.uk/id/eprint/17241/), by **Alasdair Turner**. 


## 2D model

{{< katex >}}
The basic model consists of 3 processes, each with rate constants \\(\alpha, \beta, \gamma\\). The concentrations can therefore be modeled as per [Turner's paper](https://discovery.ucl.ac.uk/id/eprint/17241/):

{{< katex >}}
\begin{align}
a_{t+1} &= a_t+a_t\\left( \\alpha b_t- \\gamma c_t \\right)\\notag\\\\
b_{t+1} &= b_t+b_t\\left( \\beta c_t- \\alpha a_t \\right)\\notag\\\\
c_{t+1} &= c_t+c_t\\left( \\gamma a_t- \\beta b_t \\right)\\notag
\end{align}

For a bidimensional behaviour, we apply a *smoothing* or *averaging* operator for each grid point, meaning that we average each variable \\(A\\), \\(B\\), and \\(C\\), after running the process for one time-step. This can be tricky to achieve, as one wants to calculate every diffusion factor in separate before applying the changes to the grid.

Furthermore, we incorporate a cartesian *von Neumann* grid, which is just a fancy name for a grid that is periodic along the edges.

### Convolving

The bidimensional behaviour spoken of above can be efficiently implemented with convolutions. These are just *blurring* filters 

## 3D model
