## Lightweight desktop and optional security tools

The default ISO package list is intentionally smaller: it includes KDE Plasma, core connectivity and hardware support, and a compact set of everyday apps. Larger productivity, developer, maker, gaming, and accessibility applications can be installed from optional bundles.

Quantix is not a Kali clone. For users learning defensive security, the optional `security-learning` bundle provides local auditing, malware scanning, firewall management, and network visibility tools without placing a large toolkit in the default image. Use assessment tools only on systems and networks you own or have explicit permission to test. See [docs/lightweight-security-edition.md](docs/lightweight-security-edition.md).

Install an optional bundle after installation:

```sh
./scripts/install-bundle.sh productivity
./scripts/install-bundle.sh developer
./scripts/install-bundle.sh security-learning
```

Bundles require internet access and may increase installed disk usage. Review package availability for your Debian release before relying on a bundle.
