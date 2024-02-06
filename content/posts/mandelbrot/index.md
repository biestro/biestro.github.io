---
title: "Mandelbrot Sets"
date: 2021-10-07T21:37:24+09:00
draft: false
category: ["Fun"]
tags: ["Mathematics", "Programming"]
---
{{< katex >}}

The Mandelbrot set is a captivating and intricate mathematical object that has fascinated mathematicians and enthusiasts alike. It's a set of complex numbers, often denoted by \\(M\\), that is defined through a relatively simple iterative process. The Mandelbrot set was first pictured by Robert Brooks and J. Peter Matelski in a paper from 1978[^fn], although there still is debate on who discovered it first (I'd really recommend reading [this article](https://www.scientificamerican.com/article/mandelbrot-set-1990-horgan/)).

The set is defined as follows

{{< katex >}}
\\[M = \\left\\{c \in \mathbb{C} \\, : \\, z_{n+1} = z_n^2 + c \right\\}\\]
Where \\(z_{n+1}\\) remains bounded for all  \\(n \geq 0\\) and \\(z_0 = 0\\).

Where:
- \\(M\\): The Mandelbrot set.
- \\(\mathbb{C}\\): The set of complex numbers.
- \\(c\\): A complex number.
- \\(z_n\\): A sequence of complex numbers, defined by \\(z_{n+1} = z_n^2 + c\\).
- The condition for \\(c\\) to be in the Mandelbrot set is that the sequence \\(z_n\\) remains bounded for all \\(n\\).

Numerically, we can check for *boundedness* after a certain number of iterations.

```julia
function mandelbrot_set(x, y, n, fun)
    z = c = x + y*im
    for i in 1:n
      if abs(z) > 2
        return i
      else
        z = fun(z,c)
      end
    end 
    return 0; # no success after n iterations
end
```
The previous function implements a sort of *Mandelbrot* set for a function ```fun(z,c)```, where we input our complex domain and get a matrix that measures an approximate boundedness, depending on the number of iterations we require.

```julia
mandelbrot_set.(X, Y', 100, (z,c) -> sin(z/c))
```

Here are some examples
{{< video autoplay="true" loop="true" src="./videos/void.mp4" >}}
{{< video autoplay="true" loop="true" src="./videos/seahorse.mp4" >}}
{{< video autoplay="true" loop="true" src="./videos/balls.mp4" >}}
{{< video autoplay="true" loop="true" src="./videos/intestine.mp4" >}}
{{< video autoplay="true" loop="true" src="./videos/spiral.mp4" >}}

<!-- #![mandelbrot 1](img/mandelbrot/heatmap_mandelbrot_void.mp4) -->


[^fn]: Brooks, Robert, and J. Peter Matelski. "The dynamics of 2-generator subgroups of PSL (2, C)." Riemann surfaces and related topics: Proceedings of the 1978 Stony Brook Conference. Vol. 1. Princeton, New Jersey: Princeton University Press, 1978.
