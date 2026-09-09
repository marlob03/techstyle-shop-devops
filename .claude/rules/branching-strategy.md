# TechStyle DevOps Course - Branching Strategy Guide

## Overview

This document outlines the Git branching strategy for the TechStyle DevOps course (Days 1-20). Each day has two branches to support student learning and assessment.

## Branch Naming Convention

Two branches per day:
- **`day_X_checkpoint`**: Clean starting point for the day (contains end-of-previous-day code)
- **`day_X_solution`**: Complete solution with all project tasks finished

**Example:**
- `day_1_checkpoint` - Starting point for Day 1 (clean state)
- `day_1_solution` - Day 1 complete with all tasks done
- `day_2_checkpoint` - Starting point for Day 2 (same as end of day_1_checkpoint)
- `day_2_solution` - Day 2 complete with all tasks done
- ... and so on through `day_20_solution`

## Branch Creation Workflow

### Step 1: Create Checkpoint Branch

The checkpoint branch is a clean starting point. It contains:
- The code from the **end of the previous day** (or nothing for Day 1)
- No new functionality yet
- Documentation describing what students should accomplish

```bash
# Create from the previous day's solution (or main for day 1)
git checkout day_1_solution  # (or main for day 1)
git checkout -b day_2_checkpoint
git push -u origin day_2_checkpoint
```

### Step 2: Create Solution Branch

The solution branch contains all completed project tasks for the day.

```bash
# Create from the checkpoint branch
git checkout day_2_checkpoint
git checkout -b day_2_solution
# Add implementations/code changes
git commit -m "Implement Day 2 project tasks"
git push -u origin day_2_solution
```

## Day-by-Day Tasks Overview

Below is a quick reference of what each day covers and what should be in the solution branches:

### **Day 1: DevOps Kickoff** ✅
- **Checkpoint:** Main branch (clean Flask app)
- **Solution:** Application running, project documentation
- **File:** `docs/DAY_1_COMPLETION.md`
- **Status:** ✅ CREATED

### **Day 2: Git & Code Repository**
- **Checkpoint:** From Day 1 solution
- **Key Tasks:**
  - Git workflow documentation
  - Semantic versioning setup
  - Branching strategy documentation
  - `.gitignore` and `.gitattributes` if needed
- **Files to Add:**
  - `docs/DAY_2_COMPLETION.md`
  - Git setup documentation
  - Version tracking in `VERSION` file

### **Day 3: MVP Concept**
- **Checkpoint:** From Day 2 solution
- **Key Tasks:**
  - Define MVPs for features
  - Break down requirements into stories
  - Kanban board setup documentation
- **Files to Add:**
  - `docs/DAY_3_COMPLETION.md`
  - Feature slicing documentation
  - MVP definitions

### **Day 4: CI Fundamentals & GitHub Actions**
- **Checkpoint:** From Day 3 solution
- **Key Tasks:**
  - `.github/workflows/ci.yml` - Basic CI pipeline
  - Linting and testing steps
  - Artifact creation
- **Files to Add:**
  - `docs/DAY_4_COMPLETION.md`
  - CI workflow file
  - Test files (if needed)

### **Day 5: Artifact Management**
- **Checkpoint:** From Day 4 solution
- **Key Tasks:**
  - Enhance CI pipeline for artifact creation
  - Add Python package creation
  - Artifact storage configuration
- **Files to Add:**
  - `docs/DAY_5_COMPLETION.md`
  - Build script enhancements

### **Day 6: Test Automation**
- **Checkpoint:** From Day 5 solution
- **Key Tasks:**
  - Add unit tests (`tests/` directory)
  - Integrate SonarQube configuration
  - Quality gates in pipeline
- **Files to Add:**
  - `docs/DAY_6_COMPLETION.md`
  - Test files
  - SonarQube config

### **Day 7: Continuous Deployment**
- **Checkpoint:** From Day 6 solution
- **Key Tasks:**
  - CD pipeline implementation
  - Deployment strategies (Blue/Green, Canary)
  - Rollback procedures
- **Files to Add:**
  - `docs/DAY_7_COMPLETION.md`
  - Deployment scripts
  - Strategy documentation

### **Day 8: Hands-on Day**
- **Checkpoint:** From Day 7 solution
- **Key Tasks:**
  - Complete all practical assignments from Days 1-7
  - Fix any issues
- **Files to Add:**
  - `docs/DAY_8_COMPLETION.md` (verification checklist)

### **Day 9: CALMS Framework & Monitoring Setup**
- **Checkpoint:** From Day 8 solution
- **Key Tasks:**
  - Prometheus setup configuration
  - Basic monitoring dashboard
  - Alerting rules
- **Files to Add:**
  - `docs/DAY_9_COMPLETION.md`
  - `prometheus.yml`
  - `grafana-dashboards/`

### **Day 10: Monitoring & Alerting**
- **Checkpoint:** From Day 9 solution
- **Key Tasks:**
  - Node Exporter configuration
  - Grafana dashboards for application metrics
  - Alert configurations
- **Files to Add:**
  - `docs/DAY_10_COMPLETION.md`
  - Grafana dashboard definitions
  - Alert rules

### **Day 11: DevSecOps**
- **Checkpoint:** From Day 10 solution
- **Key Tasks:**
  - Security scanning integration (Snyk)
  - SAST/SCA configuration
  - Security in CI pipeline
- **Files to Add:**
  - `docs/DAY_11_COMPLETION.md`
  - `.snyk` configuration
  - Security policies

### **Day 12: Production Readiness**
- **Checkpoint:** From Day 11 solution
- **Key Tasks:**
  - Production readiness checklist
  - High availability setup documentation
  - Load testing configuration
- **Files to Add:**
  - `docs/DAY_12_COMPLETION.md`
  - HA configuration docs

### **Day 13: Auto Scaling & Multi-Region**
- **Checkpoint:** From Day 12 solution
- **Key Tasks:**
  - Auto-scaling policies
  - Multi-region deployment configuration
  - Failover strategies
- **Files to Add:**
  - `docs/DAY_13_COMPLETION.md`
  - Scaling configuration
  - Infrastructure diagrams

### **Day 14: Containerization Part 1**
- **Checkpoint:** From Day 13 solution
- **Key Tasks:**
  - Create `Dockerfile`
  - Build Docker image
  - Docker best practices implementation
- **Files to Add:**
  - `docs/DAY_14_COMPLETION.md`
  - `Dockerfile`
  - `.dockerignore`

### **Day 15: Containerization Part 2**
- **Checkpoint:** From Day 14 solution
- **Key Tasks:**
  - Container registry integration
  - CI pipeline with container builds
  - Docker compose configuration (optional)
- **Files to Add:**
  - `docs/DAY_15_COMPLETION.md`
  - `docker-compose.yml` (optional)
  - Registry configuration

### **Day 16: Workshop Day**
- **Checkpoint:** From Day 15 solution
- **Key Tasks:**
  - Complete all practical work from Days 1-15
  - Buffer for catching up
- **Files to Add:**
  - `docs/DAY_16_COMPLETION.md` (verification)

### **Day 17: Infrastructure as Code (Terraform)**
- **Checkpoint:** From Day 16 solution
- **Key Tasks:**
  - Terraform configuration for AWS infrastructure
  - State management setup (S3 + DynamoDB)
  - Ansible playbooks for configuration management
- **Files to Add:**
  - `docs/DAY_17_COMPLETION.md`
  - `terraform/` directory with `.tf` files
  - `ansible/` directory with playbooks

### **Day 18: GitOps with ArgoCD**
- **Checkpoint:** From Day 17 solution
- **Key Tasks:**
  - ArgoCD installation and configuration
  - Kubernetes manifest preparation
  - GitOps workflow setup
- **Files to Add:**
  - `docs/DAY_18_COMPLETION.md`
  - `argocd/` directory with configs
  - Kubernetes manifests (`k8s/` directory)

### **Day 19: ArgoCD Continuation**
- **Checkpoint:** From Day 18 solution
- **Key Tasks:**
  - Complete ArgoCD implementation
  - Multi-environment deployments
  - Sync policies and notifications
- **Files to Add:**
  - `docs/DAY_19_COMPLETION.md`
  - Additional ArgoCD configurations

### **Day 20: DevOps Transformation Review**
- **Checkpoint:** From Day 19 solution
- **Key Tasks:**
  - Project retrospective
  - Documentation of achievements
  - Lessons learned
  - Future improvements roadmap
- **Files to Add:**
  - `docs/DAY_20_COMPLETION.md`
  - `docs/TRANSFORMATION_REVIEW.md`
  - `docs/LESSONS_LEARNED.md`

## Creating a Complete Branch Set

### Quick Script to Create All Branches

Once you have the detailed Day 2-20 implementations ready, you can use this approach:

```bash
#!/bin/bash
# Create Day 2-20 checkpoint and solution branches

for day in {2..20}; do
  # Create checkpoint from previous solution
  git checkout day_$((day-1))_solution
  git checkout -b day_${day}_checkpoint
  git push -u origin day_${day}_checkpoint
  
  # Create solution from checkpoint (to be filled with implementations)
  git checkout -b day_${day}_solution
  git commit --allow-empty -m "Day $day solution - to be implemented"
  git push -u origin day_${day}_solution
done
```

## Branch Characteristics

### Checkpoint Branches
- ✅ Clean, ready-to-use starting point
- ✅ Includes completed work from previous day
- ✅ No experimental or incomplete code
- ✅ Good for students to begin daily work
- ✅ Can be used as fallback if students get stuck

### Solution Branches
- ✅ Complete day's project tasks
- ✅ Best practices implemented
- ✅ Well-documented
- ✅ Example code for student reference
- ✅ Can be used for assessment

## Student Workflow

### Recommended Process for Students

1. **Start of Day X:**
   ```bash
   git checkout day_X_checkpoint
   git checkout -b my-day-X-work
   ```

2. **Complete Tasks:**
   - Work on project tasks
   - Commit regularly
   - Test functionality

3. **Check Solution (Optional):**
   ```bash
   git log day_X_solution
   # Compare with your work or review if stuck
   ```

4. **Submission:**
   ```bash
   git push origin my-day-X-work
   # Create PR against day_X_checkpoint
   ```

## Maintenance Notes

### When Creating Each Day's Branches

1. **Review the course materials** for that day (in `/0_Organisatorisches/Tagesplanungen/`)
2. **Implement all project tasks** from the day summary
3. **Add a DAY_X_COMPLETION.md** documenting:
   - What was completed
   - Acceptance criteria (marked ✅ when done)
   - Key learnings
   - Testing instructions
4. **Test thoroughly** before pushing
5. **Document any new files or structure changes** in the completion file

### Key Files to Update for Each Day

- Add `DAY_X_COMPLETION.md` with tasks and acceptance criteria
- Update `README.md` if new components are added
- Update `requirements.txt` if new dependencies are needed
- Add configuration files as needed (`.github/workflows/`, `terraform/`, etc.)

## Configuration Management

### Environment-Specific Configurations

Use `.env` file (already in `.gitignore`) for:
- Database paths
- API keys
- Environment-specific settings

Example:
```bash
# .env (not committed)
DATABASE_URL=postgres://localhost/techstyle
API_KEY=your-secret-key
```

### Version Tracking

Add a `VERSION` file to track application version:
```
1.0.0+day-02
```

Update on each day with the format: `<major>.<minor>.<patch>+day-XX`

## Integration with CI/CD

These branches should integrate with GitHub Actions CI:

1. **Checkpoints** can run sanity checks (linting, basic tests)
2. **Solutions** should pass all quality gates and tests
3. Use `DAY_X_COMPLETION.md` to verify expected pipeline results

## References

- Organizational Repository: `/0_Organisatorisches/`
- Course Materials: `/0_Organisatorisches/Tagesplanungen/`
- TechStyle Application: `/README.md`

---

**Last Updated:** 2026-04-07  
**Status:** ✅ Framework Ready  
**Next:** Implement remaining days (Day 2-20)
