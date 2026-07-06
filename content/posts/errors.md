---
title: "Common errors in VASP2WANNIER interface"
date: '2026-07-05'
# icon: "/images/type.gif"
categories: 
    - Posts
    - PhD
---

# VASP2WANNIER modes

VASP has two modes for calculating Wannier functions, either setting everything in the `INCAR`, or having a `wannier90.win` file beforehand (the so called *legacy* mode). The former is the recommended way to run a Wannierization nowadays.

# Common errors

When setting hybrid orbitals as projections, e.g. $sp^2$ orbitals, VASP can only read them when specified in the `LOCPROJ` tag. Placing them in the `wannier90.win` file's `begin projections` block will give an error similar to

```terminal
 Computing AMN (projections onto localized orbitals)
 -----------------------------------------------------------------------------
|                                                                             |
|     EEEEEEE  RRRRRR   RRRRRR   OOOOOOO  RRRRRR      ###     ###     ###     |
|     E        R     R  R     R  O     O  R     R     ###     ###     ###     |
|     E        R     R  R     R  O     O  R     R     ###     ###     ###     |
|     EEEEE    RRRRRR   RRRRRR   O     O  RRRRRR       #       #       #      |
|     E        R   R    R   R    O     O  R   R                               |
|     E        R    R   R    R   O     O  R    R      ###     ###     ###     |
|     EEEEEEE  R     R  R     R  OOOOOOO  R     R     ###     ###     ###     |
|                                                                             |
|     WANNIER90_ORBITAL_DEFINITIONS: ERROR: L= 0 M= 0 not implemented         |
|                                                                             |
|       ---->  I REFUSE TO CONTINUE WITH THIS SICK JOB ... BYE!!! <----       |
|                                                                             |
 -----------------------------------------------------------------------------
```

