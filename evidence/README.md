# Screenshot Evidence — Real Lab Results

These **10 images** were supplied from actual Ubuntu terminal sessions and GitHub Actions runs. The screenshots show a learning project, not production infrastructure. The run links in the main README allow independent verification of the key CI results.

| Lab | Evidence | What it demonstrates |
| --- | --- | --- |
| 01 | [Docker installation and hello-world](lab01/lab01-docker-verification.png) | Docker Engine and a test container work on Server01 |
| 02 | [Python application files and syntax](lab02/lab02-python-application.png) | Flask application file and Python syntax check |
| 03 | [Docker build](lab03/lab03-docker-build.png) | Image successfully built and tagged |
| 03 | [Running app tests](lab03/lab03-container-test.png) | Homepage, health endpoint, non-root identity |
| 04 | [First successful GitHub CI](lab04/lab04-github-actions-ci.png) | Automated build and runtime tests |
| 05 | [Trivy scanner in CI](lab05/lab05-trivy-workflow-success.png) | Trivy install and report-only scan completed |
| 06 | [CRITICAL security gate](lab06/lab06-security-gate.png) | Main-branch gate passed with zero critical findings |
| 07 | [SBOM discrepancy investigation](lab07/lab07-setuptools-sbom-investigation.png) | Installed setuptools 84.2.1 vs bundled SBOM reference 70.3.0 |
| 07 | [Debian package remediation](lab07/lab07-debian-remediation.png) | Successful build and scan after zlib1g update |
| 07 | [Intentional HIGH-gate rejection](lab07/lab07-security-gate-rejection.png) | Separate PR test blocked an image with HIGH findings |

A separate expanded Trivy vulnerability-summary screenshot **was not provided**; the full scan counts are documented in the [vulnerability assessment](../docs/vulnerability-assessment.md) and are available in the linked GitHub Actions run logs. No image has been fabricated to fill this gap.

## Review before publishing

The screenshots contain personal-lab details such as the `student` username, lab hostname, local IP addresses, container IDs and command outputs. Review what you wish to expose in a public repository. Do not publish passwords, private keys, credentials, or sensitive internal endpoints. Do not alter technical results merely to make the project appear more successful.
