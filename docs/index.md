---
repository: "https://github.com/turbot/steampipe-mod-zoom-compliance"
---

# Zoom Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for [Zoom](https://zoom.us).

<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-zoom-compliance/main/docs/zoom_compliance_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-zoom-compliance/main/docs/zoom_cis_v100_dashboard.png" width="50%" type="thumbnail"/>
<img src="https://raw.githubusercontent.com/turbot/steampipe-mod-zoom-compliance/main/docs/zoom_cis_v100_terminal.png" width="50%" type="thumbnail"/>

## References

[Zoom](https://zoom.us/) provides videotelephony and online chat services through a cloud-based peer-to-peer software platform.

[CIS Zoom Benchmarks](https://www.cisecurity.org/benchmark/zoom/) provide a predefined set of compliance and security best-practice checks for Zoom accounts.

[Steampipe](https://steampipe.io) is an open source CLI to instantly query cloud APIs using SQL.

[Steampipe Mods](https://steampipe.io/docs/reference/mod-resources#mod) are collections of `named queries`, and codified `controls` that can be used to test current configuration of your cloud resources against a desired configuration.

## Documentation

- **[Benchmarks and controls →](https://hub.steampipe.io/mods/turbot/zoom_compliance/controls)**
- **[Named queries →](https://hub.steampipe.io/mods/turbot/zoom_compliance/queries)**

## Getting started

### Installation

Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```sh
brew tap turbot/tap
brew install steampipe
```

Install the Zoom plugin with [Steampipe](https://steampipe.io):

```sh
steampipe plugin install zoom
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-zoom-compliance.git
cd steampipe-mod-zoom-compliance
```

### Usage

Start your dashboard server to get started:

```sh
steampipe dashboard
```

By default, the dashboard interface will then be launched in a new browser
window at http://localhost:9194. From here, you can run benchmarks by
selecting one or searching for a specific one.

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `steampipe check` command:

Run all benchmarks:

```sh
steampipe check all
```

Run a single benchmark:

```sh
steampipe check benchmark.cis_v100
```

Run a specific control:

```sh
steampipe check control.cis_v100_1_2_3_1
```

Different output formats are also available, for more information please see
[Output Formats](https://steampipe.io/docs/reference/cli/check#output-formats).

### Credentials

This mod uses the credentials configured in the [Steampipe Zoom plugin](https://hub.steampipe.io/plugins/turbot/zoom).

### Configuration

No extra configuration is required.

## Contributing

If you have an idea for additional controls or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing.

- **[Join #steampipe on Slack →](https://turbot.com/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-zoom-compliance/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Zoom Compliance Mod](https://github.com/turbot/steampipe-mod-zoom-compliance/labels/help%20wanted)