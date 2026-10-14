// Firefox profile used while SFW mode is on (hypr/scripts/sfw copies this
// into ~/.mozilla/firefox/sfw/user.js). Never records anything and never
// suggests anything, so showing someone a browser is always safe.

// Everything private: no history, cookies or form data survive a session
user_pref("browser.privatebrowsing.autostart", true);
user_pref("places.history.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("signon.rememberSignons", false);

// Address bar: no suggestions of any kind
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.bookmark", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.recentsearches", false);
user_pref("browser.urlbar.suggest.trending", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);

// Blank start and new-tab pages, no first-run screens
user_pref("browser.startup.page", 0);
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("datareporting.policy.dataSubmissionPolicyBypassNotification", true);
