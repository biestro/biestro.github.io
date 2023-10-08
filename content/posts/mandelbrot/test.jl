function mandelbrot(x, y,n, fun)
    z = c = x + y*im
    for i in 1:n
      if abs(z) > 2
        return i
      else
        z = fun(z,c)
      end
    end 
    return 0;
end
function mandelbrot2(x, y)
  z = c = x + y*im
  for i in 1:30.0; abs(z) > 2 && return i; z = z^2 + c; end; 0
end

mandelbrot2(0.5,0.5)
mandelbrot(0.5,0.15, 2.0,(z,c) -> z^2 + c)