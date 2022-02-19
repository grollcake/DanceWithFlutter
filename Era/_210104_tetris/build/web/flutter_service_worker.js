'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "8d6e757d8a820ffc7e1eae4ef80e5a2e",
"assets/assets/animations/abstract-background.json": "5bf0867305aa1283a2be74e87daa3708",
"assets/assets/animations/balloon-background.json": "fd3cc9fccefc87b44e8240a312c0fb5c",
"assets/assets/animations/heart-background.json": "fb2a543621e5be5e99dbd131e17cdcac",
"assets/assets/animations/lake-background.json": "a9f7a1ea1992d673f902416e4fbcc72b",
"assets/assets/animations/loading1.json": "593891a522df33229da1937b7b1c3632",
"assets/assets/animations/loading2.json": "355facd287463114db9f01557e3f3d73",
"assets/assets/animations/lottie-space.json": "05b099c29212cfde79d7a982560d6fa7",
"assets/assets/animations/night-background.json": "cacfe4d1d254d8d9f98679c0e2b9620b",
"assets/assets/animations/space-background.json": "ba1624760c28c503fc91676b96892855",
"assets/assets/animations/train-background.json": "af111f54727ae67297b25099f896e31b",
"assets/assets/images/bg01.jpg": "b335b09f6904056fe1c22dae9fc4dd05",
"assets/assets/images/bg01.png": "f9c6a4eea668aa83b33df998bc3f82a7",
"assets/assets/images/bg02.jpg": "15192cfcc0b557487a42b7f39b10d411",
"assets/assets/images/bg03.png": "7c1502234d494f2ebfe7657e0210024d",
"assets/assets/images/code.png": "d43032cbbf59c0ecc08c73de88524bc9",
"assets/assets/images/space.gif": "3dc3c1b1b8b09431fae0f06c621f241e",
"assets/assets/sound/background.wav": "3d15a89f45f772d8153a48d1285c958b",
"assets/assets/sound/clearning.wav": "8db84382e123fe43dcc2d3c0c1139ae8",
"assets/assets/sound/drop.wav": "c071b0b00756d5c487cc75f670fb4abd",
"assets/assets/sound/fixing.wav": "c2bb9459d2a35fbb93427c796679cdc9",
"assets/assets/sound/game-end.wav": "377f5a22e3a5a80f5b562db93d1b57a9",
"assets/assets/sound/hold.wav": "1f6e28b6358e30f57fd43485c32a3a97",
"assets/assets/sound/level-up.wav": "8fb75c98bb5ee8764a33b368b68caeb5",
"assets/assets/sound/moving.wav": "cabebaeca9f9cec625e4529e8ecbcdd6",
"assets/assets/sound/rotate.wav": "92101c306ad53abd1183d31fbb594087",
"assets/assets/sound/rotate.wav.wbm": "af07c0cd68256f74591b02a0c190b68f",
"assets/assets/sound/unused/drop.wav": "9695583a2bace44d62b88278bcb75343",
"assets/assets/sound/unused/hold.wav": "eff30a1c46208ac4a19f3344f5d9dbc0",
"assets/assets/sound/unused/level-up.wav": "131108985b657c263e1414966c6da8ec",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "64087bdd5c94e6342969db5a1d7c034b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.ico": "d41d8cd98f00b204e9800998ecf8427e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "0f9616cc8bc2e45d39242e0fcd27ca72",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "a3bc328738b52b673bbd45a4279587fe",
"/": "a3bc328738b52b673bbd45a4279587fe",
"main.dart.js": "1da4958ed30942764aec31163a2269f9",
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
