// Open custom homepage on startup
user_pref("browser.startup.homepage", "about:home");
// Disable default browser check
user_pref("browser.shell.checkDefaultBrowser", false);
// Disable recommended content and ads
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
// Disable recommended extension prompts
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
// Enable all developer tools
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.debugger.remote-enabled", true);
// Vertical tab bar
user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.visibility", "always-show");
// Bookmarks bar
user_pref("browser.toolbars.bookmarks.visibility", "newTab");
// Ctrl+Tab to cycle tabs
user_pref("browser.ctrlTab.sortByRecentlyUsed", true);

user_pref("intl.accept_languages", "zh-CN, en-US");
user_pref("browser.download.panel.shown", true);

//for nvidia-vaapi-driver since Firefox 137
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("media.rdd-ffmpeg.enabled", true);
// user_pref("media.av1.enabled", false);
user_pref("widget.dmabuf.force-enabled", true);
// Remember search and form history
user_pref("browser.formfill.enable", false);