<h1 align="center">
    uarmsolver-container
</h1>

<p align="center">
    <a href="#-build">🔨 Build</a> •
    <a href="#-output">📂 Output</a> •
    <a href="#-run-container">🚀 Run Container</a> •
    <a href="#-access-output">🔓 Access Output</a>
</p>

This repository contains a Docker container setup for running [uARMSolver](https://github.com/firefly-cpp/uARMSolver).

## 🔨 Build

To build the Docker image, run the following command:

```sh
docker build -t uarmsolver-container .
```
Alternatively, to build Singularity (or Apptainer) .sif image from Dockerfile:
```sh
docker save uarmsolver-container:latest -o uarmsolver.tar
sudo singularity build uarmsolver.sif docker-archive://uarmsolver.tar
```
Or simply use uarmsolver.sif file included (may not be up to date)

## 📂 Output

Ensure you have an `output` directory to store the results if you want to generate `rules.txt` to the local machine. Create it using the following command:

```sh
mkdir -p output
```

## 🚀 Run Container

### Output on local machine

Run the Docker container with the following command, which mounts the local `output` directory to the container:

```sh
docker run -v $(pwd)/output:/mnt/output -it uarmsolver-container
```
Or run Singularity image:
```sh
singularity exec uarmsolver.sif uARMSolver -s /var/uarmsolver/arm.set
mv rules.txt output
```
(Recommended use in batch scripts on HPC) <br/>
These commands will execute `uARMSolver` and store the generated `rules.txt` file in the `output` directory on your local machine.

### Output inside the container

Run the Docker container without mapping any local directory:

```sh
docker run -it uarmsolver-container
```

This command will execute `uARMSolver` inside the container, and the files will remain within the container.

## 🔓 Access Output

### Output on local machine

After running the container, you can access the `rules.txt` file in the `output` directory:

```sh
ls output
cat output/rules.txt
```

### Output inside the container

If you need to inspect the output files inside the container, you can run the container with an interactive shell:

```sh
docker run -it --entrypoint /bin/sh uarmsolver-container
```

Once inside the container, you can check the contents of the `/var/uarmsolver` and `/mnt/output` directories:

```sh
ls -l /var/uarmsolver/
cat /var/uarmsolver/solver.log
cat /var/uarmsolver/rules.txt
```
