# syntax=docker/dockerfile:1

# =============================================================================
# FinTrack Ansible Control Node
# -----------------------------------------------------------------------------
# WHAT:     A Linux container carrying Ansible, the AWS CLI, and the SSM Session
#           Manager plugin — everything needed to configure the EC2 nodes over SSM.
# WHY:      Apple-Silicon macOS aborts the forked workers Ansible's boto3 calls
#           spawn (the "dead worker" crash). That race does not exist on Linux.
#           Running Ansible in a Linux container removes the whole class of bug
#           instead of betting on flaky env-var workarounds.
# BUSINESS: Unblocks all of Phase 2 — with no working control node, the nodes
#           can never be configured and nothing downstream ships.
# ENGINEER: The "control node / ops box" pattern — containerise a toolchain to
#           escape a host-platform incompatibility.
# RECRUITER: I diagnosed a platform-specific failure and solved it with a
#            reproducible, version-controlled environment, not a hack.
# =============================================================================

# WHAT:  Pinned, slim Python base on Debian Bookworm.
# WHY:   Slim keeps it small; pinning the tag (not :latest) means it builds the
#        same next month. Bookworm = glibc, which AWS CLI v2 requires (Alpine's
#        musl would break it) — the base choice is deliberate.
FROM python:3.12-slim-bookworm

# WHAT:  OS packages to download and unpack the AWS tooling.
# WHY:   curl fetches installers, unzip unpacks the CLI, ca-certificates lets TLS
#        verify, less is the CLI pager. --no-install-recommends + cleaning apt
#        lists keeps the image lean.
# TRADE-OFF (hadolint DL3008): hadolint wants apt versions pinned for full
#        reproducibility. We deliberately don't: these are base utilities from
#        Debian's rolling security repo, and hard-pinning them breaks the build
#        the moment Debian ships a security update and drops the old version.
#        For base tools, build resilience beats the pin — so we pin the base
#        IMAGE (above) and consciously ignore this one rule.
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y --no-install-recommends \
      curl unzip ca-certificates less \
    && rm -rf /var/lib/apt/lists/*

# WHAT:  Install AWS CLI v2 and the SSM Session Manager plugin for this CPU arch.
# WHY:   The aws_ssm connection plugin shells out to the session-manager-plugin
#        binary to open the tunnel — without it, every connection fails. Arch
#        detection means the same file works on your arm64 Mac and on amd64 CI.
# ENGINEER: aws_ssm needs THREE things: boto3 (below), the AWS CLI, and this
#           plugin. Forgetting the plugin is the top cause of aws_ssm failures.
RUN set -eux; \
    arch="$(dpkg --print-architecture)"; \
    case "$arch" in \
      amd64) cli="x86_64";  smp="ubuntu_64bit" ;; \
      arm64) cli="aarch64"; smp="ubuntu_arm64" ;; \
      *) echo "Unsupported architecture: $arch" >&2; exit 1 ;; \
    esac; \
    curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${cli}.zip" -o /tmp/awscliv2.zip; \
    unzip -q /tmp/awscliv2.zip -d /tmp; \
    /tmp/aws/install; \
    curl -fsSL "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/${smp}/session-manager-plugin.deb" -o /tmp/smp.deb; \
    dpkg -i /tmp/smp.deb; \
    rm -rf /tmp/aws /tmp/awscliv2.zip /tmp/smp.deb

# WHAT:  Install Ansible + the AWS SDK from the frozen requirements file.
# WHY:   requirements.txt holds exact, pip-frozen versions captured from a known-
#        good build, so every rebuild installs the identical dependency tree — no
#        "works today, breaks next month" surprises. This is the reproducibility
#        the earlier unpinned install couldn't promise.
# ENGINEER: COPY the manifest, then install from it — the standard reproducible
#           Python-in-Docker pattern, and exactly what hadolint DL3013 asks for.
# RECRUITER: Pinned, reproducible builds — the line between a demo and something
#            you would run in production.
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --requirement /tmp/requirements.txt

# WHAT:  Default working directory; your repo mounts here at runtime.
# WHY:   You edit on your Mac; the container only executes. The repo is mounted,
#        never copied in — one source of truth, no stale baked-in copies.
WORKDIR /workspace/ansible

# WHAT:  No macOS fork-safety env hacks appear here — by design.
# WHY:   That bug is macOS-only; moving to Linux is the fix. A clean environment
#        is the proof the move worked.

# WHAT:  Default command self-reports versions, so a bare run is a built-in smoke test.
CMD ["ansible", "--version"]
