## v0.9 [2024-03-06]

_Powerpipe_

[Powerpipe](https://powerpipe.io) is now the preferred way to run this mod!  [Migrating from Steampipe →](https://powerpipe.io/blog/migrating-from-steampipe)

All v0.x versions of this mod will work in both Steampipe and Powerpipe, but v1.0.0 onwards will be in Powerpipe format only.

_Enhancements_

- Focus documentation on Powerpipe commands.
- Show how to combine Powerpipe mods with Steampipe plugins.

## v0.8 [2022-11-18]

_Bug fixes_

- Fix query for `cis_v100_1_1_6_3` control to check `cancel_meeting_reminder` instead of `jbh_reminder` in `email_notification` column. ([#17](https://github.com/turbot/steampipe-mod-zoom-compliance/pull/17)) (Thanks to [@shuetisha](https://github.com/shuetisha) for the fix!)

## v0.7 [2022-05-09]

_Enhancements_

- Updated docs/index.md and README with new dashboard screenshots and latest format. ([#14](https://github.com/turbot/steampipe-mod-zoom-compliance/pull/14))

## v0.6 [2022-05-06]

_Enhancements_

- Added `category`, `service`, and `type` tags to benchmarks and controls. ([#10](https://github.com/turbot/steampipe-mod-zoom-compliance/pull/10))

## v0.5 [2021-11-10]

_Enhancements_

- `docs/index.md` file now includes the console output image

## v0.4 [2021-09-23]

_Enhancements_

- README.md is now cleaner and more structured, including additional information on how to use and contribute to the available compliance benchmarks

_Bug fixes_

- Fixed broken links to the Mod developer guide in README.md

## v0.3 [2021-06-01]

_Bug fixes_

- Update Overview with a valid control example to run.

## v0.2 [2021-06-01]

_Bug fixes_

- Fix mod name to be `zoom_compliance` instead of `zoom`.
- Remove excess whitespace from inline SQL queries.

## v0.1 [2021-05-29]

_What's new?_

- New benchmark: CIS v1.0.0
