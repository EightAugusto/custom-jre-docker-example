# Custom JRE Docker Example

This project uses jdeps to analyze application dependencies and determine the required Java modules. It then leverages
jlink to generate a custom JRE containing only the necessary modules. The resulting custom JRE is integrated into a
lightweight Docker image, optimizing image size and performance for efficient deployment.

To facilitate the use of jdeps and jlink, the same Dockerfile first builds an image with the JDK, allowing dependency
analysis and custom JRE generation before incorporating it into the final image.

Additionally, this project includes a build process using Maven, as well as a similar implementation with Gradle,
ensuring flexibility in build tool choice while maintaining the same core functionality.

---

## Requirements

* Docker 27.5.1
* Make 3.81
* Java 21.0.4
* Maven 3.9.9
* Gradle 8.12

---

## Run

```bash
make docker.start
```

---

## Stop

```bash
make docker.stop
```