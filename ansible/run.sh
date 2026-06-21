#!/usr/bin/env bash
# WHAT: Wrapper that sets the macOS fork-safety fix before running Ansible.
# WHY: macOS crashes forked boto3 workers ("dead state") unless no_proxy is set.
#      Scoped here, not in .zshrc, so it never leaks to other tools.
# USE: ./ansible/run.sh all -m ping   (instead of: ansible all -m ping)
export no_proxy="*"
unset OBJC_DISABLE_INITIALIZE_FORK_SAFETY
exec ansible "$@"
