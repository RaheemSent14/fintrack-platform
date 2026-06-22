# Where We Are — FinTrack Running Journal

*Newest entry at the top. Read the first section and you're caught up. The rest is history.*

---

## Entry — 22 June 2026

### The One-Liner

FinTrack is a pretend budgeting app — but the cloud infrastructure behind it is completely real, built to professional standards, and designed specifically to prove to employers that you can do this job.

---

### Where We Are Right Now

The foundation is built and battle-tested. Two cloud servers exist in code, the security is locked down, and the automated setup scripts are written and working. Right now, though, **nothing is actually running in the cloud** — and that's intentional. You shut it all down after each session to pay exactly $0. Spinning everything back up takes about three minutes.

The one thing left in Phase 2 is installing the cluster software (k3s — think of it as the traffic controller that runs your apps across both servers). Everything else in this phase is done.

---

### The Story So Far

**Phase 0 — Setting up the workshop (early June 2026)**

Before building anything, you set up the workshop itself. This meant creating the GitHub repository (the online folder where all the code lives), choosing a branching strategy (GitFlow — a system where all new work happens in a separate "draft" copy before it's approved and merged into the main one), and wiring up automatic quality checks. Every time you save code now, a set of tools runs automatically to catch formatting mistakes and security slip-ups before they ever leave your laptop. The commit history — the timestamped record of every change — starts here on 4 June 2026.

**Phase 1 — Building the cloud foundation (5–11 June 2026)**

This is where the actual cloud infrastructure got built using Terraform — a tool that lets you describe your servers, networks, and security rules in plain text files, like a written recipe, and then builds it all automatically in Amazon Web Services (AWS — Amazon's cloud platform). No clicking around in menus; everything is code.

Here's what got built: a private network (VPC — Virtual Private Cloud, basically a walled-off section of Amazon's internet), four sub-sections of that network (subnets — like rooms inside the walled compound), an internet gateway (the front door), and two servers — one to be the "master" (the brain of the operation) and one to be the "worker" (the muscle). Both are the smallest free-tier servers available, called t3.micro. There's also a security configuration (IAM — Identity and Access Management, basically ID badges and door keys for everything), firewall rules (Security Groups — rules that say exactly who is allowed to knock on which door), and a billing alarm that emails you if the costs start climbing.

The whole setup is also scanned automatically by a security tool called Checkov, which is like a building inspector for cloud code. Several findings came back; some were fixed immediately, others were documented as accepted trade-offs (like skipping a $32/month network component we deliberately don't need).

All the major decisions from this phase are written up as ADRs — Architecture Decision Records, which are short documents that explain *why* something was built the way it was, not just what was built. There are seven of them so far.

**Phase 2 — Configuring the servers automatically, without passwords (11–22 June 2026)**

Building the servers is phase 1. Teaching the servers what to do once they exist is phase 2. The tool for that is Ansible — think of it as a recipe book where each recipe ("playbook") says "go to these servers and make sure these things are installed and configured."

The really interesting part is *how* Ansible connects to the servers. Old-school approach: SSH (Secure Shell — a way to log into a remote computer using a password or key, like a secret knock). The new approach here: SSM — AWS Systems Manager Session Manager, which lets you connect to a server through Amazon's own internal plumbing, with no password, no open network ports, no key files. Think of it like having a direct internal phone line to each server instead of calling from the outside. Port 22 (the traditional SSH door) is now **closed entirely** on the worker server, and it's been removed from the master too.

The Ansible setup (the scripts that configure the servers once they're up) covers two things so far: a "common" role that updates software, installs basic tools, and creates a non-root admin user; and a "server-hardening" role that locks down the operating system — disabling root login, setting up a firewall, installing fail2ban (a tool that bans IP addresses that try too many wrong passwords), and tweaking Linux kernel settings for security.

There's also an S3 bucket (S3 — Amazon's file storage service, like a cloud hard drive) set up specifically as a transit staging area, because SSM has a size limit on what it can send to servers in one go. Ansible drops its scripts there temporarily, the server picks them up, and they're automatically deleted after 24 hours.

The merge conflict (a situation where two parallel lines of work edited the same files in incompatible ways and had to be untangled) from the branch history was resolved, and all the pieces are now aligned.

---

### What's Next

The immediate next thing is installing k3s on both servers — k3s is a lightweight version of Kubernetes (the industry-standard system for running and managing containerised applications across multiple servers, like an air traffic control system for software). The master server gets the control plane (the brain), the worker gets the agent (the muscle), and then you can verify both servers are talking to each other by checking their status with a single command.

After k3s, Phase 3 begins: deploying the actual FinTrack application onto the cluster, and wiring up a CI/CD pipeline (Continuous Integration / Continuous Deployment — an automated assembly line that takes your code changes and gets them running in production without manual steps).

---

### Things That Tripped Us Up (and how we won)

**The t2 → t3 pivot**

The original plan called for `t2.micro` servers (a specific small server type on AWS). When you went to actually build them, AWS rejected the request — they'd quietly retired that hardware type in the region you were using. Rather than panic, you documented the change as ADR-006, switched to `t3.micro` (the successor type, actually slightly better), and kept going. The free-tier budget stayed at $0.

**The macOS boto3 crash**

When you tried to run Ansible from your Mac laptop to connect to the servers via SSM, it kept crashing with a deeply unhelpful error about "dead state" and "fork safety." This is a known macOS quirk — the operating system doesn't play nicely with a particular Python library (boto3 — the library that lets Python programs talk to AWS). The fix was to run Ansible inside a Docker container (a lightweight isolated environment, like a clean virtual machine) on your Mac instead of directly on macOS. The container doesn't have the Mac quirk. This was a real debugging win — it took investigation, multiple attempts, and a principled solution rather than a hack.

**The SSH key task mismatch**

The server-hardening role originally had a task that copied your SSH public key (a credential that proves who you are when logging in) to each server. But the whole point of Phase 2 was to move *away* from SSH. The task was harmless when the key file existed, but would crash unexpectedly when it didn't. It was removed cleanly in a committed change on 22 June. Another small thing that could have caused a confusing future bug, caught and fixed.

**The merge conflict**

Two branches (parallel lines of work) both added files to the same locations. Git (the version control tool) flagged them as conflicts — it couldn't decide which version to keep. Working through three conflicted files and choosing the right side of each conflict (always the Phase 2 branch, which had the SSM transit wiring) untangled it cleanly. The repo is now in a clean, single-branch state.

---

### Money Check

**$0.** Everything is torn down. Nothing is running. No meters are ticking.

When you're ready to work, bring the servers back up (terraform apply), do your work, then tear them back down (terraform destroy) at the end of the session. The whole cycle costs less than a dollar if you remember to destroy.

---

*To add a new entry next time, just say: "Update WHERE-WE-ARE with a new entry for [what you did]."*
