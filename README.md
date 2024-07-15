
# uarmsolver-container

This repository contains a Docker container setup for running [uARMSolver](https://github.com/firefly-cpp/uARMSolver).

## Building the Docker Image

To build the Docker image, run the following command:

```sh
docker build -t uarmsolver-container .
```

## Preparing the Output Directory

Ensure you have an `output` directory to store the results if you want to generate `rules.txt` to the local machine. Create it using the following command:

```sh
mkdir -p output
```

## Running the Docker Container

### Option 1: Generating `rules.txt` to Local Machine

Run the Docker container with the following command, which mounts the local `output` directory to the container:

```sh
docker run -v $(pwd)/output:/mnt/output -it uarmsolver-container
```

This command will execute `uARMSolver` and store the generated `rules.txt` file in the `output` directory on your local machine.

### Option 2: Running Without Generating `rules.txt` to Local Machine

Run the Docker container without mapping any local directory:

```sh
docker run -it uarmsolver-container
```

This command will execute `uARMSolver` inside the container, and the files will remain within the container.

## Accessing the Output

### When Generating `rules.txt` to Local Machine

After running the container, you can access the `rules.txt` file in the `output` directory:

```sh
ls output
cat output/rules.txt
```

### When Running Without Generating `rules.txt` to Local Machine

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
