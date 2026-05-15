# cordova-plugin-theme

A Cordova plugin for CoinSpace that exposes `cordova.plugins.Theme` (also `window.cordova.plugins.Theme`) in JavaScript. It switches between light, dark, and system appearance on both iOS and Android.

Requires `cordova-ios >= 6.0.0` and `cordova-android >= 9.0.0`. iOS 13+ APIs (`overrideUserInterfaceStyle`) are guarded with `#available(iOS 13, *)` — on older iOS the methods no-op (setStyle succeeds silently, getStyle returns `'system'`).

## Architecture

| File | Role |
|------|------|
| `plugin.xml` | Plugin manifest — declares the JS module, iOS and Android features, and maps class names |
| `www/Theme.js` | JS bridge; the two public methods (`setStyle`, `getStyle`) each call `cordova/exec` targeting the `Theme` native service |
| `src/ios/Theme.swift` | `CDVPlugin` subclass; maps JS style strings to `UIUserInterfaceStyle` on the Cordova view controller's window |
| `src/android/Theme.java` | `CordovaPlugin` subclass; maps JS style strings to `AppCompatDelegate` night-mode constants |

The JS style strings `'light'` / `'dark'` / `'system'` map to:
- **iOS**: `UIUserInterfaceStyle` `.light` / `.dark` / `.unspecified`
- **Android**: `AppCompatDelegate` `MODE_NIGHT_NO` / `MODE_NIGHT_YES` / `MODE_NIGHT_FOLLOW_SYSTEM`

## JS API

```js
// Set style: 'light' | 'dark' | 'system'
cordova.plugins.Theme.setStyle('dark', successCb, errorCb);

// Get current override
cordova.plugins.Theme.getStyle(style => console.log(style)); // 'light' | 'dark' | 'system'
```

