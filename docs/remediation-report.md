# Remediation report

## Objective

Change affected dependencies/packages, rebuild the image, rerun functionality checks and compare actual scan outcomes.

## Actions and outcomes

| Action | Evidence | Observed result |
|---|---|---|
| Update `pip` to 26.3 | [Run #7](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42475115927) | Six pip findings no longer reported; three other Python inventory findings remained |
| Update installed `setuptools` to 84.2.1 | [Run #8](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42475621885) | Installed package verified; bundled pip SBOM still referenced 70.3.0 |
| Update Debian `zlib1g` | [Run #10](https://github.com/abdirhamanomer/devsecops-container-security-lab/actions/runs/42477147424) | Debian findings reduced from 189 to 186 |

`zlib1g` was upgraded from `1:1.3.dfsg+really1.3.1-1+b1` to `1:1.3.dfsg+really1.3.1-1+deb13u1`. This corresponded to two fewer HIGH and one fewer MEDIUM Debian findings.

## Net result

**195 → 189 findings (6 fewer)**, with application and non-root tests still passing. This is measurable improvement, not full remediation: 189 findings remained. The old setuptools version in pip SBOM is an unresolved inventory/interpretation issue rather than an outdated installed setuptools package.

## Not yet done

Complete HIGH-severity triage, export a reviewed JSON report/SBOM, lock transitive dependencies and base image digest, and implement more extensive container hardening. These are future improvements, not completed work.
