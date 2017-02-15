# MailGun Integration for Preside

[![Build Status](https://travis-ci.org/pixl8/preside-ext-mailgun.svg?branch=stable)](https://travis-ci.org/pixl8/preside-ext-mailgun)

## Overview

This extension provides integration for Mailgun with Preside's email centre (Preside 10.8 and above).

Currently, the extension provides:

* A Message Centre service provider with configuration for sending email through Mailgun's API
* A Mailgun webhook endpoint (`/mailgun/hooks/`) for receiving and processing mailgun webhooks for delivery & bounce notifications, etc.

See the [wiki](https://github.com/pixl8/preside-ext-mailgun/wiki) for further documentation.

## Installation

Install the extension to your application via either of the methods detailed below (Git submodule / CommandBox) and then enable the extension by opening up the Preside developer console and entering:

```
extension enable preside-ext-mailgun
reload all
```

### CommandBox (box.json) method

From the root of your application, type the following command:

```
box install preside-ext-mailgun
```

### Git Submodule method

From the root of your application, type the following command:

```
git submodule add https://github.com/pixl8/preside-ext-mailgun.git application/extensions/preside-ext-mailgun
```