// 启动时打开自定义主页
user_pref("browser.startup.homepage", "about:home");
// 禁用默认浏览器检查
user_pref("browser.shell.checkDefaultBrowser", false);
// 禁用推荐内容和广告
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
// 关闭推荐扩展提示
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
// 启用所有开发者工具
user_pref("devtools.chrome.enabled", true);
user_pref("devtools.debugger.remote-enabled", true);
// 垂直标签栏
user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.visibility", "always-show");
// 书签栏
user_pref("browser.toolbars.bookmarks.visibility", "newTab");

//for nvidia-vaapi-driver since Firefox 137
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("media.rdd-ffmpeg.enabled", true);
// user_pref("media.av1.enabled", false);
user_pref("widget.dmabuf.force-enabled", true);