'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "765aa61fb3676f97143253290126315d",
"assets/assets/animations/lottie-dog-loading.json": "ee3bf01f617e0b898c960f37e9f1b48f",
"assets/assets/animations/lottie-space.json": "05b099c29212cfde79d7a982560d6fa7",
"assets/assets/images/bg01.png": "f9c6a4eea668aa83b33df998bc3f82a7",
"assets/assets/images/bg02.jpg": "0c0deba80d3aade1f64f5a3fa56c9083",
"assets/assets/images/bg03.jpg": "54e188b889d291eced689a3ff2105fc4",
"assets/assets/images/bg04.jpg": "7ca9d1635fecbf6fc7ec61ffb8866aae",
"assets/assets/images/bg05.jpg": "893685ba17d832e13590bc8444c474a3",
"assets/assets/images/bg06.jpg": "fce9ac020e455c6680005851a4573386",
"assets/assets/images/code.png": "d43032cbbf59c0ecc08c73de88524bc9",
"assets/assets/sound/background.wav": "3d15a89f45f772d8153a48d1285c958b",
"assets/assets/sound/clearning.wav": "8fb75c98bb5ee8764a33b368b68caeb5",
"assets/assets/sound/clearning2.wav": "57ae9b34e270e588a7f5b32e9fad1346",
"assets/assets/sound/drop.wav": "9695583a2bace44d62b88278bcb75343",
"assets/assets/sound/drop1.wav": "1713a57bee6bb91d4a53900376a845f7",
"assets/assets/sound/drop2.wav": "867febc41d3ceedbe9341c522a367a67",
"assets/assets/sound/game-end.wav": "377f5a22e3a5a80f5b562db93d1b57a9",
"assets/assets/sound/hold.wav": "796ca903a9dd36bfaf3d3124f914dea0",
"assets/assets/sound/level-up.wav": "131108985b657c263e1414966c6da8ec",
"assets/assets/sound/rotate2.wav": "eff30a1c46208ac4a19f3344f5d9dbc0",
"assets/assets/sound/rotate3.wav": "bf4e43036ae40236429df581ae4ad7ee",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "d319cbc65704b1222403cbb388aa9bb9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"canvaskit/canvaskit.js": "43fa9e17039a625450b6aba93baf521e",
"canvaskit/canvaskit.wasm": "04ed3c745ff1dee16504be01f9623498",
"canvaskit/profiling/canvaskit.js": "f3bfccc993a1e0bfdd3440af60d99df4",
"canvaskit/profiling/canvaskit.wasm": "a9610cf39260f60fbe7524a785c66101",
"favicon.ico": "e9f730b7cecfdd865cd96060f2dd4d47",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "5da8e1f83abbbefbc62f3d3fce69f7fc",
"icons/Icon-512.png": "168bea986290e053a1624a20221275fd",
"icons/Icon-maskable-192.png": "5da8e1f83abbbefbc62f3d3fce69f7fc",
"icons/Icon-maskable-512.png": "168bea986290e053a1624a20221275fd",
"index.html": "bb453f1f8c5e38c789615d18c7aa9b68",
"/": "bb453f1f8c5e38c789615d18c7aa9b68",
"main.dart.js": "88b360cca90220bb6b204c3c74e49b7f",
"manifest.json": "b634c074dcb1c75ead7158e4675bebca",
"version.json": "7b2471689c73be94afe1a6995c8601d3"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
