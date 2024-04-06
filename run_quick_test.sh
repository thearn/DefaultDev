#!/bin/sh
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
echo "CONTAINER FINAL BUILD TESTS"
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
echo "\n"

echo "Testing MPI/PetSC..."
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
mpirun -np 2 python test/run_petsc.py 
echo "\n"

echo "Testing OpenMDAO quickstart sample..."
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
python test/run_om.py
echo "\n"

echo "Testing Dymos MinTimeClimb problem..."
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
python test/run_dm.py
echo "\n"

# cleanup
rm *.db
rm -rf coloring_files
rm -rf reports