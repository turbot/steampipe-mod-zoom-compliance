# Zoom CIS Compliance Scans

Automated scanning of your Zoom account configuration against 100+ [CIS Zoom security benchmark](https://www.cisecurity.org/benchmark/zoom/) controls.

Run checks in a dashboard:
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-zoom-compliance/main/docs/zoom_cis_v100_dashboard.png)

Or in a terminal:
![image](https://github.com/turbot/steampipe-mod-zoom-compliance/blob/main/docs/zoom_cis_v100_terminal.png?raw=true)

Includes support for:
* [Zoom CIS v1.0.0](https://hub.steampipe.io/mods/turbot/zoom_compliance/controls/benchmark.cis_v100)

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
window at https://localhost:9194. From here, you can run benchmarks by
selecting one or searching for a specific one.

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `steampipe check` command:

Run all benchmarks:

```sh
steampipe check all
```

Run a single benchmark:

```sh
steampipe check benchmark.cis_v100_1_1_1
```

Run a specific control:

```sh
steampipe check control.cis_v100_1_1_1_3
```

Different output formats are also available, for more information please see
[Output Formats](https://steampipe.io/docs/reference/cli/check#output-formats).

### Credentials

This mod uses the credentials configured in the [Steampipe Zoom plugin](https://hub.steampipe.io/plugins/turbot/zoom).

### Configuration

No extra configuration is required.

## Contributing

If you have an idea for additional controls or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod)) we would love you to join the community and start contributing.

- **[Join our Slack community →](https://steampipe.io/community/join)** and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-zoom-compliance/blob/main/LICENSE).

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Zoom Compliance Mod](https://github.com/turbot/steampipe-mod-zoom-compliance/labels/help%20wanted)
