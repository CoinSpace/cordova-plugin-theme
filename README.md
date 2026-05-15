# cordova-plugin-theme

A Cordova plugin for CoinSpace's iOS app that exposes `cordova.plugins.Theme` (also `window.cordova.plugins.Theme`) in JavaScript. It controls iOS `overrideUserInterfaceStyle` — switching between light, dark, and system appearance.

Requires `cordova-ios >= 6.0.0`. iOS 13+ APIs (`overrideUserInterfaceStyle`) are guarded with `#available(iOS 13, *)` — on older iOS the methods no-op (setStyle succeeds silently, getStyle returns `'system'`).

## Architecture

| File | Role |
|------|------|
| `plugin.xml` | Plugin manifest — declares the JS module, the iOS feature, and maps the Swift class name |
| `www/Theme.js` | JS bridge; the two public methods (`setStyle`, `getStyle`) each call `cordova/exec` targeting the `Theme` native service |
| `src/ios/Theme.swift` | `CDVPlugin` subclass; `setStyle(_:)` and `getStyle(_:)` map to `UIUserInterfaceStyle` on the Cordova view controller's window |

The JS style strings `'light'` / `'dark'` / `'system'` map to `UIUserInterfaceStyle` values `.light` / `.dark` / `.unspecified`.

## JS API

```js
// Set style: 'light' | 'dark' | 'system'
cordova.plugins.Theme.setStyle('dark', successCb, errorCb);

// Get current override
cordova.plugins.Theme.getStyle(style => console.log(style)); // 'light' | 'dark' | 'system'
```

