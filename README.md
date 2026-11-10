# DevSecOps Container Security Lab

**Practical, educational portfolio project:** Docker • Flask • Linux • GitHub Actions • Trivy • CI security policies. This is a personal lab, **not** a production deployment or employer incident.

## Project overview

A small Flask application is packaged with Docker, run as a non-root user, built and tested automatically by GitHub Actions, scanned for known vulnerabilities with Trivy, and checked against a configurable security gate.

| Component | Implementation |
|---|---|
| Application | Flask (`/`, `/health`), served with Gunicorn |
| Container | `python:3.12-slim`, user `appuser`, port 5000 |
| Local environment | Ubuntu Server VM in Oracle VirtualBox (`linux-server01`) |
| CI | GitHub Actions using `ubuntu-24.04` runner |
| Scanner | Trivy `0.76.2` (download verified with SHA-256) |
| Main branch gate | Block detected CRITICAL findings |
| Controlled branch test | Block HIGH and CRITICAL findings |

## Pipeline architecture

```text
GitHub push / pull request
          |
     Docker build
          |
   Run Flask container
          |
   Test / and /health
   Check non-root user
          |
   Install verified Trivy
          |
   Report vulnerabilities
          |
  Enforce security policy
       /       \
     pass      reject
```

See [architecture](docs/architecture.md).

## Verified results

- `hello-world` succeeded using Docker on Ubuntu Server01.
- Container responses and non-root `appuser` were verified.
- CI built and tested the image successfully.
- Trivy generated vulnerability reports and the main CRITICAL-only gate passed.
- A stricter HIGH/CRITICAL gate **rejected** the image on an isolated pull request, as expected.
- A package update measurably reduced scan findings; not all findings were remediated.

| Severity | Baseline (run #6) | After remediation (run #10) |
|---|---:|---:|
| CRITICAL | 0 | 0 |
| HIGH | 49 | 48 |
| MEDIUM | 80 | 75 |
| LOW | 66 | 66 |
| **All findings** | **195** | **189** |

The latest recorded total consists of **186 Debian findings** and **3 Python-inventory findings**. The remaining Python findings refer to `setuptools 70.3.0` in a bundled pip SBOM; the installed setuptools package was verified as **84.2.1**. Inventory interpretation needs further triage and is not proof that all associated risks are false or exploitable.

See [vulnerability assessment](docs/vulnerability-assessment.md) and [remediation report](docs/remediation-report.md).

## Evidence from real GitHub Actions runs

| Milestone | Evidence |
|---|---|
| Successful Docker CI | [Run #1](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42472185939) |
| Trivy scan added and working | [Run #5](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42473973597) |
| CRITICAL gate passes | [Run #6](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42474831227) |
| Debian `zlib1g` remediation | [Run #10](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42477147424) |
| HIGH/CRITICAL gate rejects image | [Run #11](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42799290609) |

Run #11's red status is **intentional** and demonstrates policy enforcement on a test pull-request branch; the default main-branch policy remains CRITICAL-only.

## Run the application locally

With Docker installed and running:

```bash
docker build -t devsecops-flask-lab:local .
docker run -d --name devsecops-lab -p 127.0.0.1:5000:5000 devsecops-flask-lab:local
curl -fsS http://127.0.0.1:5000/
curl -fsS http://127.0.0.1:5000/health
docker exec devsecops-lab id
docker rm -f devsecops-lab
```

If Docker daemon access requires administrator privileges in your training VM, use `sudo` on the Docker commands. Keep the example app bound to loopback.

## Documentation

- [Architecture](docs/architecture.md)
- [Vulnerability assessment](docs/vulnerability-assessment.md)
- [Remediation report](docs/remediation-report.md)
- [Security-gate test](docs/security-gate-testing.md)
- [Troubleshooting journal](docs/troubleshooting.md)
- [Further improvements](docs/future-improvements.md)
- [Screenshot evidence index (10 images)](evidence/README.md)

## Screenshot gallery

The following authentic images are included in the [`evidence/` directory](evidence/README.md):

| Demonstration | Screenshot |
| --- | --- |
| Docker setup | [LAB-01](evidence/lab01/lab01-docker-verification.png) |
| Flask container works and runs as non-root | [LAB-03](evidence/lab03/lab03-container-test.png) |
| First successful CI pipeline | [LAB-04](evidence/lab04/lab04-github-actions-ci.png) |
| Automated vulnerability scanning | [LAB-05](evidence/lab05/lab05-trivy-workflow-success.png) |
| CRITICAL-only security gate passes | [LAB-06](evidence/lab06/lab06-security-gate.png) |
| Bundled SBOM discrepancy | [LAB-07 investigation](evidence/lab07/lab07-setuptools-sbom-investigation.png) |
| Debian package remediation pipeline | [LAB-07 remediation](evidence/lab07/lab07-debian-remediation.png) |
| HIGH/CRITICAL gate rejects the image | [LAB-07 controlled failure](evidence/lab07/lab07-security-gate-rejection.png) |

The full index links all **10 supplied screenshots**; no vulnerability totals have been inferred from a green checkmark.

## Skills demonstrated

Linux administration, Docker images and containers, basic Flask service support, shell diagnostics, GitHub Actions CI, vulnerability triage, package remediation, security policy gates, branch isolation, and technical documentation.

## Limitations

- The recorded image **still has 189 findings**; green CI does not prove production safety.
- `requirements.txt` uses version ranges, and the base image tag is not digest-locked.
- This is CI for build/test/scan, **not** an automated production deployment.
- No secrets, private keys, unredacted sensitive logs, or confidential data should be committed.
