# Contributing to TechStyle eCommerce

This document defines how the TechStyle DevOps Team works with Git: branching model,
merge strategy, pull request rules, release process, and conflict handling.

## a) Branching Strategy: GitHub Flow

We use **GitHub Flow**, not Git Flow and not pure Trunk-Based Development.

**Why:**
- TechStyle is a single-service Flask app deployed continuously, not a shipped product
  with multiple maintained versions in parallel — so we don't need Git Flow's
  `develop`/`release/*` branches and the overhead of keeping them in sync.
- We are a small team without a dedicated release manager. GitHub Flow's single
  long-lived branch (`main`) keeps merges simple and avoids drift between `develop`
  and `main`.
- Later modules in this course (CI, Continuous Deployment, GitOps/ArgoCD) assume
  every merge to `main` is releasable and can be deployed automatically. That maps
  directly onto GitHub Flow's core rule: **`main` is always deployable.**
- Pure Trunk-Based Development (commit straight to `main`, no PRs) skips code review,
  which we want for an eCommerce app that touches payments and user data.

**Branch structure:**

```
main                    ← always deployable, protected, source of production releases
├── feature/xyz         ← new features, branched from main
├── bugfix/xyz          ← non-urgent bug fixes, branched from main
└── hotfix/xyz          ← urgent production fixes, branched from main
```

There is no `develop` branch. Releases are tagged directly on `main` (see section e).

## b) Branch Naming Convention

| Branch pattern    | Purpose                                   | Branched from |
|--------------------|--------------------------------------------|---------------|
| `main`             | Production code, always deployable         | —             |
| `feature/<slug>`   | New feature, e.g. `feature/wishlist`        | `main`        |
| `bugfix/<slug>`    | Non-urgent bug fix, e.g. `bugfix/cart-total`| `main`        |
| `hotfix/<slug>`    | Urgent production fix, e.g. `hotfix/xss-login` | `main`     |
| `release/vX.Y.Z`   | Optional release stabilization window (used only for larger, multi-feature releases) | `main` |

Use lowercase, hyphen-separated slugs. Reference an issue number where one exists,
e.g. `feature/142-wishlist`.

## c) Merge Strategy

| Scenario                                   | Strategy       | Why |
|---------------------------------------------|----------------|-----|
| `feature/*`, `bugfix/*` → `main`             | **Squash merge** | Keeps `main` history one commit per logical change, hides noisy WIP commits, and gives us a clean Conventional Commit message per feature. |
| `hotfix/*` → `main`                          | **Squash merge** | Same reasoning; hotfixes should show up as a single, clearly labeled commit. |
| `release/*` → `main`                         | **Merge commit** | Preserves the fact that multiple features were integrated and tested together before release. |
| Updating a long-running feature branch with the latest `main` | **Rebase** | Keeps the feature branch's history linear and avoids noisy merge commits while the PR is still in review. Never rebase `main` itself, and never rebase a branch others have already pulled. |

Rule of thumb: **rebase to update a private branch, squash to land it, merge commit only
when integrating multiple already-reviewed branches.**

## d) Pull Request Requirements

- **Who can merge:** only the PR author after approval, or a maintainer. Direct pushes
  to `main` are blocked by branch protection — all changes go through a PR.
- **Reviews required:** at least **1 approving review** for `feature/*`/`bugfix/*`;
  at least **2 approving reviews** for anything touching payments, auth, or
  infrastructure/deploy config (`deploy.sh`, `.github/workflows/*`, `app.py` auth routes).
- **Checks required:** CI (lint + tests) must pass before merge; branch must be up to
  date with `main`.
- **PR template** (`.github/pull_request_template.md`) must include:
  - **What & why** — summary of the change and motivation
  - **Type of change** — feature / bugfix / hotfix / docs / chore
  - **Testing** — how it was tested, manual steps if relevant
  - **Checklist** — tests added/updated, docs updated, no secrets committed,
    `.env.example` updated if new config was added
- **CODEOWNERS** (`.github/CODEOWNERS`): defines who reviews which paths;
  `@marlob03` currently owns everything, with `app.py`, `.github/workflows/`
  and `deploy.sh` called out explicitly as the payments/auth/infra paths from
  the rule above.

### Enforced ruleset (GitHub branch protection on `main`)

What's actually configured on GitHub, not just documented here:

- **Required status checks:** `Code Quality (flake8)` and
  `Automated Tests (pytest)` must pass; `strict: true` means the PR branch
  must be up to date with `main` before merging.
- **`enforce_admins: false`:** the repo owner *can* merge past a red or
  pending check in an emergency (e.g. a hotfix where CI itself is broken),
  but doing so is a deliberate override, not the default path — GitHub
  visibly flags such a merge as bypassing the required checks.
- **No required PR-review count enforced yet:** the team is currently a
  single person, so requiring approvals would just lock out the only
  contributor. Revisit once a second reviewer joins (see CODEOWNERS above for
  who that should be).
- **Force-push and branch deletion on `main`:** disabled.

## e) Release & Tagging Process

- Releases are prepared from `main` once it contains all changes intended for the
  release and CI is green.
- We use **Semantic Versioning** (`vMAJOR.MINOR.PATCH`):
  - **MAJOR** — breaking changes (e.g. incompatible API/data model changes)
  - **MINOR** — new backward-compatible features
  - **PATCH** — bug fixes and small non-breaking changes
- A maintainer creates an annotated tag on `main` and pushes it:
  ```bash
  git tag -a v1.0.0 -m "Initial release - TechStyle Modernization Baseline"
  git push origin v1.0.0
  ```
- A **GitHub Release** is created from that tag with Markdown release notes covering:
  Overview, Features (✨), Tech Stack (🛠️), Documentation links (📚), Next Steps (🔄).
- **Who tags/releases:** a maintainer, only after the relevant PRs are merged and CI
  is green on `main`.

## f) Conflict Handling

- The developer whose branch is behind `main` is responsible for resolving merge
  conflicts on their own branch (via rebase or merge from `main`) before requesting
  review — reviewers should not have to resolve conflicts.
- For conflicts touching code the resolver didn't write, ping the original author
  before resolving, rather than guessing intent.
- Any non-trivial conflict resolution (i.e. more than whitespace/import ordering)
  must be called out explicitly in the PR description so reviewers know to double
  check that area.

## Git Workflow — Step by Step

1. `git checkout main && git pull`
2. `git checkout -b feature/my-change`
3. Make changes, commit using [Conventional Commits](#commit-message-guidelines)
4. `git push -u origin feature/my-change`
5. Open a PR against `main`, fill in the PR template
6. Address review feedback, keep the branch up to date with `main` via rebase
7. Once approved and CI is green, squash-merge via GitHub

## Commit Message Guidelines

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <short summary>

[optional body]
```

Common types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`.

Rules:
- **Language:** commit messages must be written in **English**.
- **Case:** the summary must be **lowercase** (no capital letter after `type:`, no
  Title Case) — this matches the Conventional Commits convention and keeps
  `git log --oneline` easy to scan.

Examples:
- `feat: add wishlist to product page`
- `fix: correct cart total rounding`
- `docs: add contributing guide`
- `chore: add gitignore`

Bad examples (wrong case / wrong language):
- `Fix: Correct Cart Total Rounding` ❌ (capitalized)
- `fix: Korrigiere Warenkorb-Summe` ❌ (German)

## Testing Requirements

- New features and bug fixes should include or update tests where the codebase has
  test coverage for that area.
- CI (lint + tests) must pass before a PR can be merged.
- For changes without automated coverage yet, describe manual test steps in the PR.

## Review Process

- At least one reviewer must approve before merge (two for payments/auth/infra, see
  section d).
- Reviewers check: correctness, adherence to this guide's branch/commit conventions,
  no secrets committed, and that `.env.example` / docs are updated if config changed.
