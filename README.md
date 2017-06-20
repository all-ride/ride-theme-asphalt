# Ride: Theme Asphalt

This module installs the Asphalt theme for the Ride web base application.

## Related Modules

- [ride/app](https://github.com/all-ride/ride-app)
- [ride/app-template](https://github.com/all-ride/ride-app-template)
- [ride/app-template-smarty](https://github.com/all-ride/ride-app-template-smarty)
- [ride/lib-html](https://github.com/all-ride/ride-lib-html)
- [ride/lib-template](https://github.com/all-ride/ride-lib-template)
- [ride/theme-asphalt-cms](https://github.com/all-ride/ride-theme-asphalt-cms)
- [ride/web](https://github.com/all-ride/ride-web)
- [ride/web-base](https://github.com/all-ride/ride-web-base)
- [ride/web-i18n-expose](https://github.com/all-ride/ride-web-i18n-expose)
- [ride/web-template](https://github.com/all-ride/ride-web-template)
- [ride/web-template-smarty](https://github.com/all-ride/ride-web-template-smarty)

## Installation

You can use [Composer](http://getcomposer.org) to install this application.

```
composer require ride/theme-asphalt
```

## Integrations

### Export buttons

Theme asphalt provides support for export buttons from model pages. To enable the export link, you should add either 
one of following options to the model.

```xml
<option name="scaffold.export" value="true"/>
<option name="scaffold.export.xls" value="true"/>
```

If other custom exports are configured, you can enable them on a per-export basis, as shown in the second line.
