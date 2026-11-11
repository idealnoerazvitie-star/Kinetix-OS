# Lightweight security and privacy features

Quantix should borrow useful **defensive** ideas from security-focused Linux distributions without installing a large penetration-testing suite in its everyday desktop image.

## Included by default

The lightweight base image keeps the regular KDE terminal and essential system tools, along with `curl`, `wget`, `git`, and `htop`. It remains a general-purpose Debian desktop, not a penetration-testing environment.

## Optional Security Learning bundle

Install this only when needed:

```sh
./scripts/install-bundle.sh security-learning
```

The bundle provides:

- **Lynis** for local system security auditing
- **ClamAV** for malware scanning
- **UFW** for managing the host firewall
- **Wireshark** and **tcpdump** for inspecting network traffic
- **Nmap** for inventorying hosts and services on networks you own or are explicitly authorized to assess

Always follow applicable laws, organizational policy, and tool-specific documentation. Do not scan or test systems without explicit permission.

## Lightweight design choices

- Security tools are optional and are not installed in the base ISO.
- Avoid meta-packages that pull in hundreds of tools or large data sets.
- Keep one desktop environment and a small set of everyday applications in the base image.
- Let users install an optional bundle after installation, rather than shipping every use case in the live image.
- Review package availability and image size on each supported Debian release before publishing.

## What this does not claim

Quantix does not reproduce Kali Linux or include all of its tools, workflows, kernel customizations, or support model. This is a lightweight general-purpose desktop with a small, optional defensive learning toolkit.
