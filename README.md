# Custom JRE Docker Example

This project uses jdeps to analyze application dependencies and determine the required Java modules. It then leverages
jlink to generate a custom JRE containing only those necessary modules. The resulting custom JRE is integrated into a
lightweight Docker image, optimizing the image size and performance for efficient deployment.

---

## Requirements

* Docker 27.2.0
* Make 3.81
* Java 21
* Maven 3.9.9

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