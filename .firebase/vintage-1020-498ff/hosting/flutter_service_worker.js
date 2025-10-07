'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "17180f1f313250cf044b71d50eccb8e6",
"version.json": "acb7fbeeacafb8f0a56ddd68b5135382",
"index.html": "fdb43df6f21e54abae3f6717fba2bfcc",
"/": "fdb43df6f21e54abae3f6717fba2bfcc",
"main.dart.js": "2b083b26dfe658f185b71c98e8cafd8b",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a4b65cbc62551622eb5e3782b085d896",
"assets/resources/branding/wateree.jpeg": "982183ae578fcb35a156adb033941b6d",
"assets/resources/images-furniture/10.jpeg": "2405d23f2afb017189b25ad45cd1cc9e",
"assets/resources/images-furniture/three.jpeg": "52474be61c913fe61a7b4ef232e03f00",
"assets/resources/images-furniture/One.jpeg": "da0df71515362301cee4b536ab8fb325",
"assets/resources/images-furniture/lunaFurnitureThree.jpeg": "1df24f22ec59704c44b6f9ccc0dd7d92",
"assets/resources/images-furniture/11.jpeg": "202cc59fd856262fdf87974b04f1a166",
"assets/resources/images-furniture/20.jpeg": "423fe1a5ae1d7ed73e469744401f596b",
"assets/resources/images-furniture/five.jpeg": "51b72e64d1ce65cd476a240cf743f0ca",
"assets/resources/images-furniture/lunaFurnitureOne.jpeg": "7f8389101fa4a654f96eee8ebad24783",
"assets/resources/images-furniture/16.jpeg": "9902b8576072e2d1fb03b8e549ae9067",
"assets/resources/images-furniture/17.jpeg": "b665ced3d85f00e581521fe5aac1cf7d",
"assets/resources/images-furniture/four.jpeg": "eeaa2cf82bbb87d2dbb16eefe10f5b1b",
"assets/resources/images-furniture/15.jpeg": "dbbc88ba457c42e0a1e21f6d6557b3ad",
"assets/resources/images-furniture/seven.jpeg": "276736e5c525bee3fccac56dd164bb25",
"assets/resources/images-furniture/lunaFurnitureTwo.jpeg": "51b72e64d1ce65cd476a240cf743f0ca",
"assets/resources/images-furniture/19.jpeg": "9390ac15c535e3147a7ddf2ca297b612",
"assets/resources/images-furniture/six.jpeg": "dbbc88ba457c42e0a1e21f6d6557b3ad",
"assets/resources/images-furniture/9.jpeg": "c29e24dabdfbed053908a7cac554389d",
"assets/resources/images-furniture/12.jpeg": "eec2abdae52fc3664f483845f991c56d",
"assets/resources/images-furniture/two.jpeg": "202cc59fd856262fdf87974b04f1a166",
"assets/resources/images-furniture/13.jpeg": "a7b04511c42c84f5cc68653263991d17",
"assets/resources/images-lamps/lampFive.jpeg": "f225ad3a811d23798bb03e3f4b34fea3",
"assets/resources/images-lamps/lampThree.jpeg": "b9f2aee56d2c2d5f811272d239b217d8",
"assets/resources/images-lamps/eight.jpeg": "f225ad3a811d23798bb03e3f4b34fea3",
"assets/resources/images-lamps/21.jpeg": "709315491d429bbfc62e2ca99d959b9c",
"assets/resources/images-lamps/14.jpeg": "b9f2aee56d2c2d5f811272d239b217d8",
"assets/resources/images-lamps/lampFour.jpeg": "423fe1a5ae1d7ed73e469744401f596b",
"assets/AssetManifest.json": "f438939ffb79b091e76205b65f8961c8",
"assets/NOTICES": "0796a8f6491a60ba65ee6408d5d8a9d1",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "b608a07d8d9df9993157e447f6350145",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "2582334d9160726a4707f07d48f4c760",
"assets/fonts/MaterialIcons-Regular.otf": "5bf2c9f312814457f7b52b34485951a6",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
