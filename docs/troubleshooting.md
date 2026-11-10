# Troubleshooting journal

## Trivy action installation failures

The Trivy installer failed to locate release versions that existed upstream. Replacing its release lookup with a direct versioned Trivy 0.76.2 archive download plus SHA-256 verification allowed the security scan to run. This failure was in setup tooling, not in the Flask app.

## Transient Trivy download failure

Run #9 initially failed with `curl: (56) Connection died` while downloading the scanner. Prior Docker build, setuptools investigation and application test steps passed. Re-running the same workflow succeeded, indicating a transient download failure; no application change was required.

## Setuptools discrepancy

Trivy reported findings linked to version `70.3.0` even though `setuptools 84.2.1` was installed. Diagnostic output confirmed `70.3.0` existed as a version reference in `pip/_vendor/bom.cdx.json`. Do not suppress findings without documenting the evidence and checking whether the affected code is present and relevant.

## Intentional gate rejection

Pull-request run #11 failed specifically at `Enforce security gate (HIGH and CRITICAL)`. The scanner detected 48 HIGH findings, so `--exit-code 1` blocked the build. This was expected behavior and was not a pipeline error.

Evidence: [Successful scan #5](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42473973597), [diagnostic rerun #9](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42476297741), [gate test #11](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42799290609).
