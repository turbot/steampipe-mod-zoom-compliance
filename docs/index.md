---
repository: "https://github.com/turbot/steampipe-mod-zoom-compliance"
---

# Zoom Compliance Mod

Run individual configuration, compliance and security controls or full compliance benchmarks for CIS for [Zoom](https://zoom.us).

## References

[Zoom](https://zoom.us/) provides videotelephony and online chat services through a cloud-based peer-to-peer software platform.

[CIS Zoom Benchmarks](https://www.cisecurity.org/benchmark/zoom/) provide a predefined set of compliance and security best-practice checks for Zoom accounts.

[Steampipe](https://steampipe.io) is an open source CLI to instantly query cloud APIs using SQL.

[Steampipe Mods](https://steampipe.io/docs/reference/mod-resources#mod) are collections of `named queries`, and codified `controls` that can be used to test current configuration of your cloud resources against a desired configuration.

## Documentation

- **[Benchmarks and controls →](https://hub.steampipe.io/mods/turbot/zoom_compliance/controls)**
- **[Named queries →](https://hub.steampipe.io/mods/turbot/zoom_compliance/queries)**

## Get started

Install the Zoom plugin with [Steampipe](https://steampipe.io):

```shell
steampipe plugin install zoom
```

Clone:

```sh
git clone https://github.com/turbot/steampipe-mod-zoom-compliance.git
cd steampipe-mod-zoom-compliance
```

Run all benchmarks:

```shell
steampipe check all
```

Run a single benchmark:

```shell
steampipe check benchmark.cis_v100
```

Run a specific control:

```shell
steampipe check control.cis_v100_1_2_3_1
```

### Credentials

This mod uses the credentials configured in the [Steampipe Zoom plugin](https://hub.steampipe.io/plugins/turbot/zoom).

### Configuration

No extra configuration is required.

## Get involved

- Contribute: [GitHub Repo](https://github.com/turbot/steampipe-mod-zoom-compliance)
- Community: [Slack Channel](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)
