FROM continuumio/miniconda3:4.6.14

RUN useradd --no-log-init -r -m -g staff main 

COPY --chown=main:staff . /home/main/rMAP

RUN chown -R main:staff /opt/conda

USER main

WORKDIR /home/main/rMAP

RUN conda install -c conda-forge mamba

RUN mamba env create -n rMAP-1.0 --file rMAP-1.0-Linux-installer.yml

# Make RUN commands use the new environment:
SHELL ["conda", "run", "--no-capture-output", "-n", "rMAP-1.0", "/bin/bash", "-c"]

# The code to run when container is started:
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "rMAP-1.0","bin/rMAP"]
