# Architecture and test environment

## Goal

Package a two-endpoint Flask service in a non-root Docker container and automate build, runtime validation, vulnerability scanning, and policy enforcement.

## Components

| File or system | Function |
|---|---|
| `app.py` | Flask routes `/` and `/health` |
| `requirements.txt` | Flask and Gunicorn dependencies |
| `Dockerfile` | Python/Debian base, package updates, non-root user |
| `.dockerignore` | Excludes unneeded and sensitive build context files |
| `.github/workflows/ci.yml` | Continuous integration and security checks |
| Trivy 0.76.2 | Vulnerability report and severity policy |

## Workflow sequence

1. Push to `main` or open a pull request targeting `main`.
2. GitHub Actions builds `devsecops-flask-lab:ci` on `ubuntu-24.04`.
3. A container starts on `127.0.0.1:5000`; CI checks both endpoints and the `appuser` identity.
4. Trivy is downloaded by version and verified by pinned SHA-256.
5. Trivy reports findings at LOW through CRITICAL levels.
6. A separate gate fails if any CRITICAL findings are reported.

A controlled test branch changed the gate to `HIGH,CRITICAL` and demonstrated rejection. The local Ubuntu Server VM is distinct from the disposable GitHub Actions runner.

## Trust boundaries

The application is a training service. Binding to loopback minimizes unwanted exposure; using a non-root process limits one class of privilege risk. Neither is a comprehensive container hardening strategy. The workflow does not deploy to a production environment.
