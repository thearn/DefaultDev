# Use an official Ubuntu base image
FROM continuumio/miniconda3:latest

# Optionally, set a maintainer or label for the image
LABEL maintainer="tristan.a.hearn@nasa.gov"

# Install necessary base packages
RUN apt-get update && apt-get install -y wget swig gfortran libblas-dev liblapack-dev libopenblas-dev && \
    rm -rf /var/lib/apt/lists/*

# create conda environment
RUN conda create --yes -n OpenMDAO python=3 && \
    conda init bash && \
    conda clean -afy

# make sure our conda environment is actived by default
RUN echo "conda activate OpenMDAO" >> ~/.bashrc

SHELL ["/bin/bash", "--login", "-c"]

# enable parallelism 
RUN conda install --yes -c conda-forge mpi4py petsc4py && \
    conda clean -afy

# install mdao toolchain 
RUN pip install openmdao[all] && \
    conda install --yes -c conda-forge pyoptsparse && \
    pip install dymos && \
    conda clean -afy && \
    pip cache purge

# suppress some MPI warnings
RUN echo "export OMPI_ALLOW_RUN_AS_ROOT=1" >> ~/.bashrc && echo "export OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1" >> ~/.bashrc && \
    echo "export OMPI_MCA_mca_base_component_show_load_errors=0" >> ~/.bashrc