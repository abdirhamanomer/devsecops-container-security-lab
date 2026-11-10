# Future improvements (not yet implemented)

1. Triage remaining HIGH findings by actual affected package, fix availability, and environment exposure.
2. Generate a first-party SBOM and compare with the `pip`-bundled SBOM to resolve inventory discrepancies.
3. Pin the Python base image by reviewed digest, and lock Python transitive dependencies.
4. Export JSON scan results as retained CI artifacts; add evidence of remediation before and after.
5. Expand security coverage with secret scanning, Dockerfile misconfiguration checks, and repeatable tests.
6. Consider a policy addressing fixable HIGH issues or contextual risk rather than treating CRITICAL-only as a production approval.
