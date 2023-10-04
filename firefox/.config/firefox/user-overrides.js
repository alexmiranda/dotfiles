// dark mode
user_pref("browser.in-content.dark-mode", true);
// 0110
user_pref("browser.privatebrowsing.autostart", false);
// 0203
user_pref("geo.provider.network.logging.enabled", true);
user_pref("geo.wifi.uri", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
user_pref("geo.wifi.logging.enabled", true);
// 0210
user_pref("intl.accept_languages", "en-GB, en");
// 0412
user_pref("browser.safebrowsing.downloads.remote.enabled", true);
// 0708
user_pref("network.ftp.enabled", false);
// 0901
user_pref("signon.rememberSignons", false);
// 0903
user_pref("security.ask_for_password", 1);
// 0912
user_pref("network.auth.subresource-http-auth-allow", 0);
// 1001
user_pref("browser.cache.disk.enable", true);
// 1003
user_pref("browser.cache.memory.enable", true);
user_pref("browser.cache.memory.capacity", 8192);
// 1006
user_pref("permissions.memory_only", true);
// 1021
user_pref("browser.sessionstore.max_tabs_undo", 0);
// 1022
user_pref("browser.sessionstore.resume_from_crash", false);
// 1202
user_pref("security.tls.version.min", 3);
user_pref("security.tls.version.max", 4);
// 1244
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode.upgrade_local", true);
// 1401
user_pref("browser.display.use_document_fonts", 1);
// 1403
user_pref("gfx.downloadable_fonts.enabled", true);
user_pref("gfx.downloadable_fonts.fallback_delay", 0);
// 1404
user_pref("gfx.font_rendering.opentype_svg.enabled", true);
// 1601
user_pref("network.http.sendRefererHeader", 0);
// 1602
user_pref("network.http.referer.trimmingPolicy", 1);
// 1604
user_pref("network.http.referer.XOriginTrimmingPolicy", 1);
// 1606
user_pref("network.http.referer.defaultPolicy", 3);
user_pref("network.http.referer.defaultPolicy.pbmode", 3);
// 1704
user_pref("privacy.userContext.enabled", true);
user_pref("privacy.userContext.ui.enabled", true);
user_pref("privacy.userContext.longPressBehavior", 2);
// 1820
user_pref("media.gmp-provider.enabled", false);
// 1825
user_pref("media.gmp-widevinecdm.visible", true);
user_pref("media.gmp-widevinecdm.enabled", true);
// 2012
user_pref("webgl.disable-extensions", false);
// 2024
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.microphone", 2);
// 2030
user_pref("media.autoplay.default", 5);
// 2304
user_pref("dom.webnotifications.enabled", false);
user_pref("dom.webnotifications.serviceworker.enabled", false);
// 2305
user_pref("dom.push.userAgentID", "");
// 2306
user_pref("permissions.default.desktop-notification", 2);
// 2401
user_pref("dom.event.contextmenu.enabled", false);
// 2402
user_pref("dom.event.clipboardevents.enabled", false);
// 2502
user_pref("dom.battery.enabled", false);
// 2520
user_pref("dom.vr.enabled", false);
// 2521
user_pref("permissions.default.xr", 2);
// 2601
user_pref("accessibility.force_disabled", 0);
// 2620
user_pref("pdfjs.disabled", true);
// 2654
user_pref("browser.download.forbid_open_with", true);
// 2703
user_pref("network.cookie.lifetimePolicy", 2);
// 2710
user_pref("dom.storage.enabled", true);
// 2731
user_pref("offline-apps.allow_by_default", false);
// 2740
user_pref("dom.caches.enabled", false);
// 2750
user_pref("dom.storageManager.enabled", false);
// 2755
user_pref("dom.storage_access.enabled", false);
// 2805
user_pref("privacy.clearOnShutdown.openWindows", true);
user_pref("privacy.cpd.openWindows", true);
// 4504
user_pref("privacy.resistFingerprinting.letterboxing", false);
// 4605
user_pref("browser.zoom.siteSpecific", false);
// 4606
user_pref("dom.gamepad.enabled", false);
// 4607
user_pref("dom.netinfo.enabled", false);
// 4608
user_pref("media.webspeech.synth.enabled", false);
// 4610
user_pref("media.video_stats.enabled", false);
// 4611
user_pref("dom.w3c_touch_events.enabled", 0);
// 4612
user_pref("media.ondevicechange.enabled", false);
// 4613
user_pref("webgl.enable-debug-renderer-info", true);
// 4615
user_pref("ui.use_standins_for_native_colors", true);
// 4616
user_pref("ui.systemUsesDarkTheme", 1);
// 4617
user_pref("ui.prefersReducedMotion", 0);
// 4618
user_pref("layout.css.font-visibility.level", 1);
// 4701
user_pref("general.useragent.override", "");
// 4702
user_pref("general.buildID.override", "");
// 4703
user_pref("general.appname.override", "");
// 4704
user_pref("general.appversion.override", "");
// 4705
user_pref("general.platform.override", "MacIntel");
// 4706
user_pref("general.oscpu.override", "");

// SECTION 5000
user_pref("browser.startup.homepage_override.mstone", "ignore"); // master
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("startup.homepage_override_url", ""); // what's new
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("browser.tabs.warnOnOpen", false);
user_pref("full-screen-api.warning.delay", 0);
user_pref("full-screen-api.warning.timeout", 0);
user_pref("browser.download.autohideButton", false); // [FF57+]
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true); // [FF68+] allow userChrome/userContent
user_pref("accessibility.typeaheadfind", false); // enable "Find As You Type"
user_pref("clipboard.autocopy", false); // disable autocopy default [LINUX]
user_pref("layout.spellcheckDefault", 2); // 0=none, 1-multi-line, 2=multi-line & single-line
user_pref("browser.backspace_action", 2); // 0=previous page, 1=scroll up, 2=do nothing
user_pref("browser.tabs.closewindowwithlasttab", false);
user_pref("browser.tabs.loadbookmarksintabs", true); // open bookmarks in a new tab [ff57+]
user_pref("browser.urlbar.decodeurlsoncopy", true); // see bugzilla 1320061 [ff53+]
user_pref("general.autoscroll", false); // middle-click enabling auto-scrolling [default: false on linux]
user_pref("ui.key.menuaccesskey", 0); // disable alt key toggling the menu bar [restart]
user_pref("view_source.tab", false); // view "page/selection source" in a new window [ff68+, ff59 and under]
user_pref("browser.messaging-system.whatsnewpanel.enabled", false); // what's new [ff69+]
user_pref("extensions.pocket.enabled", false); // pocket account [ff46+]
user_pref("identity.fxaccounts.enabled", false); // firefox accounts & sync [ff60+] [restart]
user_pref("reader.parse-on-load.enabled", false); // reader view
user_pref("browser.bookmarks.max_backups", 2);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false); // disable cfr [ff67+]
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false); // disable cfr [ff67+]
user_pref("network.manage-offline-status", false); // see bugzilla 620472
user_pref("xpinstall.signatures.required", false); // enforced extension signing (nightly/esr)

// Some performance improvements
user_pref("nglayout.initialpaint.delay", 0);
user_pref("content.notify.interval", 500000);
user_pref("content.max.tokenizing.time", 1000000);
user_pref("content.switch.threshold", 10000);
user_pref("content.notify.ontimer", true);
user_pref("content.interrupt.parsing", true);
user_pref("network.http.max-persistent-connections-per-server", 8);
user_pref("network.http.request.max-start-delay", 0);
user_pref("network.http.pipelining", true);
user_pref("network.http.proxy.pipelining", true);
user_pref("network.http.pipelining.maxrequests", 64);
user_pref("browser.sessionhistory.max_total_viewers", 1);

// Disable Geo IP
user_pref("geo.enabled", false);

// Keyboard
user_pref("accessibility.tabfocus", 7);

// webgl will be enabled because of some sites... argh!
user_pref("webgl.disabled", false);
user_pref("webgl.enable-webgl2", true);

// Disable page translation
user_pref("browser.translations.enable", false);

