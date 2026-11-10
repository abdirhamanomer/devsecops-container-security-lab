# Security gate: passing and intentionally failing cases

## Default policy on `main`

- Report scan: `--severity CRITICAL,HIGH,MEDIUM,LOW --exit-code 0`.
- Blocking scan: `--severity CRITICAL --exit-code 1`.
- Result: passed with no CRITICAL findings. HIGH findings still remained.

## Controlled pull-request test

- Branch: `security-gate-high-test`.
- Pull request: [#1](https://github.com/abdirhamanomer/devsecops-container-security-lab/pull/1).
- Workflow: [Run #11](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42799290609).

On the test branch the gate used:

```bash
trivy image --scanners vuln --severity HIGH,CRITICAL   --format table --exit-code 1 devsecops-flask-lab:ci
```

The Docker build, application tests, Trivy installation and report-only scan passed. The strict gate then failed with exit code **1**, as intended, because the image had **48 HIGH findings and 0 CRITICAL findings** (47 Debian; one Python-inventory finding).

This is a **successful negative test**. A red result during build or downloading the scanner would not demonstrate security gate enforcement.

Do **not** merge the strict test branch into `main` without deciding to adopt that different policy. Close the experimental PR without merging after capturing evidence.
