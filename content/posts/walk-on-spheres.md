---
title: "Solving the heat equation with Markov Chains"
date: '2025-11-08'
draft: false
categories:
  - Posts
tags:
  - Blog
---

# Problem

Meshing is hard

![OWL](../walk-on-spheres/owl_mesh.png)

Consider a simple problem with Dirichlet boundary conditions, i.e. a boundary-value problem 

$$\Delta u(x)=0,\quad u(x)\big|_{\partial\Omega}=h(x),$$

where (for mathematicians) $\Delta \equiv \partial^2_{j}$. 

## Walk-on-spheres

Running a random-walk for each 

In other words, the algorithm substitutes the Wiener process with the *grow-and-sample* method, which reduces computational time, and can set fixed bounds on the iterations (which makes it easier to paralellize). Instead of hoping to sample the boundary within a time $t$, one just sets a large `N_iter` and hopes for the best! A graphical description of the algorithm is shown below

![WOS](../walk-on-spheres/wos.svg)


One can see that the algorithm builds the solution from the outside towards the inside, as the points near the boundary converge faster to the solution. 

![WOS_SOL](../walk-on-spheres/wos_circle.svg)

It is quite suprising how fast the solver gets a *feeling* for the solution's characteristics. The rest of the iterations just smoothen things out a bit, but the 'orange-wedges' pattern appears  as earlt as the 34th iteration!

The code for performing the walk-on-spheres steps is contained within `wos_single_walk_circle`, which one calls for a set of points in $\Omega$. These describe the process in the [wikipedia page](https://en.wikipedia.org/wiki/Walk-on-spheres_method) for the algorithm,

$$
u(x)=E[h(W_\tau)]\sim \frac{1}{n}\sum_i^nh(W_\tau^i)
$$


```julia
function wos_single_walk_circle(
  x0::Vector{Float64}, 
  R::Float64, 
  phi_b::Function; 
  eps::Real=1e-3, 
  max_steps::Int=10_000
  )
  
  x = copy(x0)
  for _ in 1:max_steps
    # distance to circle
    r = max(R - norm(x), 0.0)
    if r <= eps
      # closest point on boundary (circle)
      r = norm(x)
      if r == 0.0
        return phi_b([R, 0.0])
      else
        return phi_b((R / r) * collect(x))
      end
    end
    # random point on ball (go to next point)
    θ = 2π * rand()
    x = [x[1] + r * cos(θ), x[2] + r * sin(θ)]
  end
  error("wos_single_walk_circle: exceeded max steps")
end
```

```julia
s = zeros(nx, ny)
for _ in 1:num_iter
  s_old = copy(s)
  s += @. wos_single_walk_circle(points, R, phi_b)
  convergence[k] = sum(abs.(s_old / (k-1) - s / k))
  # optional: do a convergence break
end
```

# Further reading

This algorithm came back to use for computer graphics, and a new, improved version was named [Walk on Stars](https://www.cs.cmu.edu/~kmcrane/Projects/WalkOnStars/). This has all the advantages that I described above, mainly that it is mesh-free, but it can handle Neumann boundary conditions too.