var exec = require('cordova/exec');

/**
 * Switch iOS overrideUserInterfaceStyle.
 *
 * @namespace cordova.plugins.Theme
 */
var Theme = {

  /**
   * Set the UI style.
   *
   * @param {string} style - 'light', 'dark', or 'auto'
   * @param {Function} [success]
   * @param {Function} [error]
   */
  setStyle: function(style, success, error) {
    exec(success, error, 'Theme', 'setStyle', [style]);
  },

  /**
   * Get the current UI style override.
   *
   * @param {Function} success - called with 'light', 'dark', or 'auto'
   * @param {Function} [error]
   */
  getStyle: function(success, error) {
    exec(success, error, 'Theme', 'getStyle', []);
  },
};

module.exports = Theme;
