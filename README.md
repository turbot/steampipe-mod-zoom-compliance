# Zoom CIS Compliance Scans

Automated scanning of your Zoom account configuration against 100+ [CIS Zoom security benchmark](https://www.cisecurity.org/benchmark/zoom/) controls.

![image](https://github.com/turbot/steampipe-mod-zoom-compliance/blob/main/docs/console-output.png?raw=true)

## Current Zoom CIS Control Checks:
1. [Account Settings](https://hub.steampipe.io/mods/turbot/zoom_compliance/controls/benchmark.cis_v100_1) – Meeting, recording and telephony controls.
2. [IM Management](https://hub.steampipe.io/mods/turbot/zoom_compliance/controls/benchmark.cis_v100_2) – Messaging security and storage controls.
3. [Advanced Security](https://hub.steampipe.io/mods/turbot/zoom_compliance/controls/benchmark.cis_v100_3_1) - Security and authentication controls.

## Other Compliance Scanning Steampipe Mods:
* [AWS - CIS & PCI](https://github.com/turbot/steampipe-mod-aws-compliance)
* [Azure - CIS](https://github.com/turbot/steampipe-mod-azure-compliance)
* [GCP - CIS](https://github.com/turbot/steampipe-mod-gcp-compliance)
* [GitHub - Best Practices](https://github.com/turbot/steampipe-mod-github-sherlock)

## Quick start

1) Download and install Steampipe (https://steampipe.io/downloads). Or use Brew:

```shell
brew tap turbot/tap
brew install steampipe

steampipe -v 
steampipe version 0.8.2
```

2) Install the Zoom plugin with [Steampipe](https://steampipe.io):

```shell
steampipe plugin install zoom
```
3) Configure your credentials in `/.steampipe/config/zoom.spc`
```hcl
connection "zoom" {
  plugin     = "zoom"
  api_key    = "9m_kAcfuTlW_JCrvoMYK6g"
  api_secret = "lEEDVf3SgyQWckN3ASqMpXWpCixkwMzgnZY7"
}
```

5) Clone this repo:

```sh
git clone https://github.com/turbot/steampipe-mod-zoom-compliance.git
cd steampipe-mod-zoom-compliance
```

4) Run all benchmarks:

```shell
steampipe check all
```

Run a specifc benchmark:

```shell
steampipe check benchmark.cis_v100_1_1_1
```

Use Steampipe introspection to view all current controls:

```
steampipe query "select resource_name from steampipe_control;"
```

## Guidance

If you check everything you'll see a long list of messages, many of which are likely to be alarms. How to prioritize what actions to take? In [The Control Freak's guide to Zoom](https://newsletter.turbot.com/p/the-control-freaks-guide-to-zoom), David Boeke has helpfully summarized the top 10 things that might warrant intervention.

## Contributing

Have an idea on how to improve the scans, or just want to help maintain and extend this mod ([or others](https://github.com/topics/steampipe-mod))?

- **[Join our Slack community →](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g)**
- **[Mod developer guide →](https://steampipe.io/docs/using-steampipe/writing-controls)**

**Prerequisites**:

- [Steampipe installed](https://steampipe.io/downloads)
- Steampipe Zoom plugin installed (see above)

**Fork**:
Click on the GitHub Fork Widget (and Don't forget to :star: the repo!)

**Clone**:

1. Change the current working directory to the location where you want to put the cloned directory on your local filesystem.
2. Type the clone command below inserting your GitHub username instead of `YOUR-USERNAME`:

```sh
git clone git@github.com:YOUR-USERNAME/steampipe-mod-zoom-compliance
cd steampipe-mod-zoom-compliance
```

3. Get coding and put your SQL skills to the test!

Thanks for getting involved! We would love to have you [join our Slack community](https://join.slack.com/t/steampipe/shared_invite/zt-oij778tv-lYyRTWOTMQYBVAbtPSWs3g) and hang out with other Mod developers.

Please see the [contribution guidelines](https://github.com/turbot/steampipe/blob/main/CONTRIBUTING.md) and our [code of conduct](https://github.com/turbot/steampipe/blob/main/CODE_OF_CONDUCT.md). All contributions are subject to the [Apache 2.0 open source license](https://github.com/turbot/steampipe-mod-zoom-compliance/blob/main/LICENSE).

`help wanted` issues:

- [Steampipe](https://github.com/turbot/steampipe/labels/help%20wanted)
- [Zoom Compliance Mod](https://github.com/turbot/steampipe-mod-zoom-compliance/labels/help%20wanted)
