Intended for use in VSCode using the Dev Containers extension.

This Docker dev container environment is a basic OpenMDAO and Dymos environment (latest builds).
This is built from the latest Python 3 Miniconda image 
Petsc and MPI are not installed by default, but can be added.
pytoptsparse is installed with IPOPT, but not SNOPT.

This directory is mounted into the container by default.
This can be used as the starting point for generic projects.

pip uninstall -y pyoptsparse
apt-get update && apt-get install make g++ pkgconf
git clone https://github.com/OpenMDAO/build_pyoptsparse.git
pip install build_pyoptsparse/
build_pyoptsparse -v -s snopt_src/
rm -rf build_pyoptsparse/