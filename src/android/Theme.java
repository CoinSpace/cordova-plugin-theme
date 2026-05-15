package com.coinspace.plugin.theme;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;

import androidx.appcompat.app.AppCompatDelegate;

public class Theme extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("setStyle".equals(action)) {
            setStyle(args.getString(0), callbackContext);
            return true;
        } else if ("getStyle".equals(action)) {
            getStyle(callbackContext);
            return true;
        }
        return false;
    }

    private void setStyle(String style, CallbackContext callbackContext) {
        final int nightMode;
        switch (style.toLowerCase()) {
            case "light":  nightMode = AppCompatDelegate.MODE_NIGHT_NO;           break;
            case "dark":   nightMode = AppCompatDelegate.MODE_NIGHT_YES;          break;
            default:       nightMode = AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM; break;
        }
        cordova.getActivity().runOnUiThread(() -> {
            AppCompatDelegate.setDefaultNightMode(nightMode);
            callbackContext.success();
        });
    }

    private void getStyle(CallbackContext callbackContext) {
        String style;
        switch (AppCompatDelegate.getDefaultNightMode()) {
            case AppCompatDelegate.MODE_NIGHT_NO:  style = "light"; break;
            case AppCompatDelegate.MODE_NIGHT_YES: style = "dark";  break;
            default:                               style = "system"; break;
        }
        callbackContext.success(style);
    }
}
