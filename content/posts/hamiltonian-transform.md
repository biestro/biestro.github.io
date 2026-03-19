---
title: "Another way to interpolate bandstructures"
date: 2026-03-18
icon: "/images/dodeca.gif"
draft: true
---

# Introduction

Recently, a [paper in **npj**](https://www.nature.com/articles/s41524-025-01684-5) showed an alternative to Wannier interpolated bandstructures using a localized Hamiltonian. Given that Wannierization is my main research area, I thought it would be interesting to see how well their algorithm, which is shown to include only two parameters, compares to the Hamiltonians created by SCDM methods (also require only two parameters).

## Compiling in Fortran90

Linux users thave it the easiest. However, if you're using MacOS (as I am), you may need to edit some of the tags in the compiler. An easy rule of thumb for Apple silicon is to replace any instances of `cpp` with `gcc` (optional `-E` flag for preprocessing only), for example, in he `Makefile.inc` you will most porbably find this.

Furthermore, I have replaced the `ht.sh` file with a `ht_mac.sh` alternative that does not run into parsing errors with tabs.

```bash
#!/bin/bash
#This script copies ht.f90 to PP/src and modifies PP/src/Makefile.
if grep -q "ht.x" PP/src/Makefile; then
    echo PP/src/Makefile already contains keyword \"ht.x\", do nothing.
else
    cp ht.f90 PP/src
    sed -i '' '/^all\ :/ s/\\$/ht.x\ \\/' PP/src/Makefile
    python3 - PP/src/Makefile <<'EOF'
import sys
path = sys.argv[1]
block = (
    "ht.x : ht.o libpp.a $(MODULES)\n"
    "\t$(LD) $(LDFLAGS) -o $@ \\\n"
    "\t\tht.o libpp.a $(MODULES) $(QELIBS)\n"
    "\t- ( cd ../../bin ; ln -fs ../PP/src/$@ . )\n"
    "\n"
)
txt = open(path).read()
txt = txt.replace("clean :", block + "clean :", 1)
open(path, "w").write(txt)
EOF
    echo "success"
fi
```

The `PP/src/Makefile` should include an `ht.x` block now (check it!). Run then the configuration by

```bash
./configure MPIF90=mpif90 CPP="gcc -E" F77=gfortran FC=gfortran \
  -enable-openmp \
  CFLAGS="-O2" \
  FFLAGS="-O2" \
  LDFLAGS=""
```

Note that this should already replace `cpp` with `gcc`.

For some reason, my `FFTW3` library does not allow a `howmany > 1` parameter. Therefore, we need to edit the file as follows

```fortran
! before:
! H1d(1:nk123*rk*rk) => H
! CALL cfft3d(H1d, nk1, nk2, nk3, nk1, nk2, nk3, rk*rk, -1)

! now:
DO i = 1, rk
  DO j = 1, rk
    CALL cfft3d(H(:, i, j), nk1, nk2, nk3, nk1, nk2, nk3, 1, -1)
  END DO
END DO
```