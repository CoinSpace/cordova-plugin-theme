var exec = require('cordova/exec');

/**
 * Switch between light, dark, and system appearance on iOS and Android.
 *
 * @namespace cordova.plugins.Theme
 */
var Theme = {

  /**
   * Set the UI style.
   *
   * @param {string} style - 'light', 'dark', or 'system'
   * @param {Function} [success]
   * @param {Function} [error]
   */
  setStyle: function(style, success, error) {
    exec(success, error, 'Theme', 'setStyle', [style]);
  },

  /**
   * Get the current UI style override.
   *
   * @param {Function} success - called with 'light', 'dark', or 'system'
   * @param {Function} [error]
   */
  getStyle: function(success, error) {
    exec(success, error, 'Theme', 'getStyle', []);
  },
};

module.exports = Theme;
