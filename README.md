# DevSecOps Container Security Lab

This repository documents an **educational lab** using Ubuntu, Docker, Flask, GitHub Actions and (in a future stage) Trivy. This is **not** a production deployment.

## Completed locally

- Docker Engine verified using `hello-world` on `linux-server01`.
- Flask application packaged in a Docker image named `devsecops-flask-lab:local`.
- App served via Gunicorn on port 5000, bound on the host to `127.0.0.1`.
- `GET /` returned `{"message":"Welcome to my DevSecOps Security Lab","status":"running"}`.
- `GET /health` returned `{"status":"ok"}`.
- Container process ran as `appuser` (`uid=999` in the local test).

See screenshots under [`evidence/lab03/`](evidence/lab03/).

## Continuous integration (LAB-04)

The workflow at [`.github/workflows/ci.yml`](.github/workflows/ci.yml) is intended to build the Docker image and test both endpoints and non-root execution on each push to `main` and each pull request targeting `main`.

**Status: awaiting first GitHub Actions run.** Do not mark this stage as verified until a successful run is observed in the Actions tab.

## Future work

- Integrate a verified, pinned Trivy release for vulnerability scanning.
- Record a controlled security-gate failure and its remediation.
- Lock tested dependencies and base image for reproducibility, and produce vulnerability evidence and a remediation report.

## Safety

The application is only a training service. It should not be deployed publicly or treated as production-ready. Never upload passwords, API keys, or private credentials.
