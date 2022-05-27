FROM ghcr.io/sparrow0hawk/miniconda3-user-docker:main

USER root

RUN apt update && apt install -y trimmomatic parallel bwa

USER condauser

# the parent docker file have a condauser
COPY --chown=condauser:staff . /home/condauser/rMAP

WORKDIR /home/condauser/rMAP

RUN mamba env create -n rMAP-1.0 --file rMAP-1.0-Linux-installer.yml

RUN conda run --no-capture-output -n rMAP-1.0 bash setup.sh && \
    cd && \
    bash clean.sh && \
    rm clean.sh

RUN conda run --no-capture-output -n rMAP-1.0 rMAP -t 4 -c

# The code to run when container is started:
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "rMAP-1.0","rMAP"]
