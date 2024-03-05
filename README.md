# Zoom Compliance Mod for Powerpipe

> [!IMPORTANT]  
> Steampipe mods are [migrating to Powerpipe format](https://powerpipe.io) to gain new features. This mod currently works with both Steampipe and Powerpipe, but will only support Powerpipe from v1.x onward.

Automated scanning of your Zoom account configuration against 100+ [CIS Zoom security benchmark](https://www.cisecurity.org/benchmark/zoom/) controls.

Run checks in a dashboard:
<!-- ![image](https://raw.githubusercontent.com/turbot/steampipe-mod-zoom-compliance/main/docs/zoom_cis_v100_dashboard.png) -->
![image](https://raw.githubusercontent.com/turbot/steampipe-mod-zoom-compliance/add-new-checks/docs/zoom_cis_v100_dashboard.png)

Or in a terminal:
<!-- ![image](https://github.com/turbot/steampipe-mod-zoom-compliance/blob/main/docs/zoom_cis_v100_terminal.png?raw=true) -->
![image](https://github.com/turbot/steampipe-mod-zoom-compliance/blob/add-new-checks/docs/zoom_cis_v100_terminal.png?raw=true)

Includes support for:
* [Zoom CIS v1.0.0](https://hub.steampipe.io/mods/turbot/zoom_compliance/controls/benchmark.cis_v100)

## Documentation

- **[Benchmarks and controls →](https://hub.powerpipe.io/mods/turbot/zoom_compliance/controls)**
- **[Named queries →](https://hub.powerpipe.io/mods/turbot/zoom_compliance/queries)**

## Getting started

### Installation

Install Powerpipe (https://powerpipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/powerpipe
```

This mod also requires [Steampipe](https://steampipe.io) with the [Zoom plugin](https://hub.steampipe.io/plugins/turbot/zoom) as the data source. Install Steampipe (https://steampipe.io/downloads), or use Brew:

```sh
brew install turbot/tap/steampipe
steampipe plugin install zoom
```

Finally, install the mod:

```sh
mkdir dashboards
cd dashboards
powerpipe mod init
powerpipe mod install github.com/turbot/steampipe-mod-zoom-compliance
```

### Browsing Dashboards

Start Steampipe as the data source:

```sh
steampipe service start
```

Start the dashboard server:

```sh
powerpipe server
```

Browse and view your dashboards at **https://localhost:9033**.

### Running Checks in Your Terminal

Instead of running benchmarks in a dashboard, you can also run them within your
terminal with the `powerpipe benchmark` command:

List available benchmarks:

```sh
powerpipe benchmark list
```

Run a benchmark:

```sh
powerpipe benchmark run zoom_compliance.benchmark.cis_v100_1_1_1
```

Different output formats are also available, for more information please see
[Output Formats](https://powerpipe.io/docs/reference/cli/benchmark#output-formats).

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

[Steampipe](https://steampipe.io) and [Powerpipe](https://powerpipe.io) are products produced from this open source software, exclusively by [Turbot HQ, Inc](https://turbot.com). They are distributed under our commercial terms. Others are allowed to make their own distribution of the software, but cannot use any of the Turbot trademarks, cloud services, etc. You can learn more in our [Open Source FAQ](https://turbot.com/open-source).

## Get Involved

**[Join #powerpipe on Slack →](https://turbot.com/community/join)**

Want to help but don't know where to start? Pick up one of the `help wanted` issues:

- [Powerpipe](https://github.com/turbot/powerpipe/labels/help%20wanted)
- [Zoom Compliance Mod](https://github.com/turbot/steampipe-mod-zoom-compliance/labels/help%20wanted)
