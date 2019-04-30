# Set the base image using miniconda 
FROM continuumio/miniconda3

# Set environmental variable(s)
ENV ACCEPT_INTEL_PYTHON_EULA=yes

# Set working directory 
WORKDIR /home/notebooks

# Add requirements file 
ADD requirements.txt /app/

# Installs, clean, and update   
RUN apt-get update \
    && apt-get clean \
    && apt-get update -qqq \
    && apt-get install -y -q g++ \ 
    && conda config --add channels intel \
    && conda install -y python=3 \ 
    && pip install --upgrade pip \ 
    && pip install -r /app/requirements.txt


RUN /opt/conda/bin/conda install jupyter -y --quiet
RUN pip install NiaPy==2.0.0rc4
RUN pip install SwarmPackagePy==1.0.0a5

# Run shell command for notebook on start 
CMD /opt/conda/bin/jupyter notebook --port=10003 --no-browser --ip=0.0.0.0 --allow-root