# MailGun Integration for Preside

## Overview

This extension provides integration for Mailgun with Preside's email centre (Preside 10.8 and above).

Currently, the extension provides:

* A Message Centre service provider with configuration for sending email through Mailgun's API
* A Mailgun webhook endpoint (`/mailgun/hooks/`) for receiving and processing mailgun webhooks for delivery & bounce notifications, etc.

See the [wiki](https://github.com/pixl8/preside-ext-mailgun/wiki) for further documentation.

## Installation

From the root of your application, type the following command:

```
box install preside-ext-mailgun
```

If your application is running, reload the application to complete the installation.