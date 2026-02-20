---
title: "Tutorial for getting AiiDA-VASP running in NERSC"
date: 2026-02-20
icon: "/images/mail3.gif"
---

# Installing AiiDA and AiiDA-VASP

After all is done and set, run

```bash
verdi plugin list aiida.calculations
```

# Configuring AiiDA

verdi computer setup

```bash
-> % verdi computer setup
Report: enter ? for help.
Report: enter ! to ignore the default and set no value.
Computer label: perlmutter
Hostname: perlmutter.nersc.gov
Description []: Perlmutter at NERSC
Transport plugin: core.ssh
Scheduler plugin: core.slurm
Shebang line (first line of each script, starting with #!) [#!/bin/bash]:
Work directory on the computer [/scratch/{username}/aiida/]:
Mpirun command [mpirun -np {tot_num_mpiprocs}]: srun -n {tot_num_mpiprocs} -c 2
Default number of CPUs per machine: 2
Default amount of memory per machine (kB).: 12800000
Escape CLI arguments in double quotes [y/N]:
Success: Computer<1> perlmutter created
Report: Note: before the computer can be used, it has to be configured with the command:
Report:   verdi -p ar computer configure core.ssh perlmutter
```

```yaml
---
label: "perlmutter"
hostname: "perlmutter.nersc.gov"
transport: "core.ssh"
description: "NERSC Perlmutter cluster"
scheduler: "core.slurm"
work_dir: "/pscratch/sd/a/{username}/aiida/"
default_memory_per_machine: 128000000
mpirun_command: "srun -n {tot_num_mpiprocs} -c 2"
mpiprocs_per_machine: "32"
prepend_text: |
  ### computer prepend_text start ###
  #SBATCH -C cpu
  #SBATCH -q regular
  #SBATCH -A m4068
  # OMP Settings
  export OMP_PLACES=threads
  export OMP_PROC_BIND=true
  export OMP_NUM_THREADS=1
  ### computer prepend_text end ###
```

{{< warning >}}
After configuring a computer, you cannot edit its contents. If you want to edit something,
 you must create a new computer.
{{< /warning >}}

Enter the information as

```bash
verdi computer configure core.ssh perlmutter --config perlmutter.yaml
```

Test that the computer is working

```bash
verdi computer test perlmutter
```

Be sure to set the path to the `.ssh` file added with `sshproxy`

# Configuring AiiDA-VASP


