# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [0.8.0] - 2016-10-28

### Added

- `Popolo.latest_term` replaces `Popolo.current_term` and has the same
  functionality. It will return the most recent term for the legislature
  but it is not guaranteed that the term will be a current one. You
  should check the `start_date` and `end_date` of the term to determine that.
- Added `Election` and `LegislativePeriod` classes for `Event`s.
- `Collection.where` now returns a `Collection` rather and an `Array`
- Added the following shortcut methods:
  - `Membership.area`
  - `Membership.legislative_period` or `Memberships.term`
  - `Membership.person`
  - `Membership.on_behalf_of` or `Membership.party`
  - `Membership.organization`
  - `Membership.post`
  - `Post.organization`
  - `Person.memberships`

### Changed

- Moving away from generating accessors to Popolo properties dynamically
  which means that in future only properties that are used by
  EveryPolitician will have accessors

### Deprecated

- `Popolo.current_term` - use `latest_term` instead.

## [0.7.0] - 2016-09-26

### Added

- Property lookups are now cached the first time they are used so
  multiple searches on the same property should be much quicker,
  especially on large data sets.

## [0.6.1] - 2016-09-12

### Fixes

- Version 0.6.0 was accidentally tagged at the wrong (broken) point in history,
  which included a broken fix for removing the `id` prefix from entities
  ([#48](https://github.com/everypolitician/everypolitician-popolo/pull/48)),
  but not the pull request reverting that change
  ([#49](https://github.com/everypolitician/everypolitician-popolo/pull/49)).
  0.6.0 has been yanked from RubyGems and we recommend using version 0.6.1.

## [0.6.0] (yanked from RubyGems.org) - 2016-09-03

### Fixed

- `Entitiy#identifiers` will now return an empty list if no identifiers
exist, rather than blowing up.

## [0.5.0] - 2016-08-01

### Added

- Added `Person#link(type)`

## [0.4.0] - 2016-07-04

### Added

- Added `Organization#wikidata`

## [0.3.2] - 2016-06-06

### Fixed

- Added missing attribute definition for `Event#start_date` and
  `Event#end_date`

## [0.3.1] - 2016-05-04

### Fixed

- Added missing attribute definition for `Post#label`.

## [0.3.0] - 2016-05-04

### Fixed

- Return an empty array when no data is available for a collection (Thanks @henare)

### Added

- Support for Posts, which EveryPolitician has recently added support for.
- `Collection#find_by` and `Collection#where` methods. See the README for more details on how to use these.
- Explicit methods so that calling a known property on a document returns `nil` rather than blowing up if it's missing.

## [0.2.0] - 2016-03-11

### Added

- Support for all Popolo collections that EveryPolitician uses - People, Organizations, Areas, Memberships and Events. Thanks to @equivalentideas and @henare for this contribution!

## 0.1.0 - 2016-01-26

- Initial release

[0.2.0]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.1.0...v0.2.0
[0.3.0]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.2.0...v0.3.0
[0.3.1]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.3.0...v0.3.1
[0.3.2]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.3.1...v0.3.2
[0.4.0]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.3.0...v0.4.0
[0.5.0]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.4.0...v0.5.0
[0.6.0]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.5.0...v0.6.0
[0.7.0]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.6.0...v0.7.0
[0.8.0]: https://github.com/everypolitician/everypolitician-popolo/compare/v0.7.0...v0.8.0
