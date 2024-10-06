---
title: "Simulated Annealing"
date: '2022-09-08'
draft: false
categories: 
- Posts
tags: 
- Numerical Analysis
- Stochastics
- Simulation
---

Similar to the Ising Model, Simulated Annealing takes a step implements a similar cost function to that of the Ising Hamiltonian. Once again, the probability of accepting a less-efficient state follows the Maxwell-Boltzmann distribution.

## Methodology

The probability of choosing or accepting a state with higher energy is given by

$$ P_a(\delta E) = \exp\left(-\frac{\delta E}{k_BT}\right)$$

Where \\(T\\) is the temperature function \\(T = T(t)\\). Several cooling schedules are available on the web.

```julia
...
if δE < 0                               # 
  state = new_state                     # new state is more efficient
elseif rand() < exp( -δE / (kb * Tᵢ))   # 
  state = new_state                     # random choice of less efficient state
end
...
```

## Applications: TSP

Useful applications for the Simulated Annealing metaheuristic are combinatorial problems, such as the Travelling Salesman Problem. Here, the \\(\delta E\\) is interpreted as being proportional to the total distance of a loop starting from any point on the grid.

{{< video src=tsp.mp4 width="600px" loop="true" autoplay="true" >}}
<!-- ![TSP GIF](/images/waves/wave_barriers.gif) -->