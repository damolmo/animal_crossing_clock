'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "d47d805f4650128df229fc7736ba08a8",
"index.html": "25cf8f63ed46b7bf96a2afe89478bb54",
"/": "25cf8f63ed46b7bf96a2afe89478bb54",
"main.dart.js": "ada0aeebb8f2510b557b8bd81847ecdc",
"sqlite3.wasm": "8e4ed39391f4e06cd7ae00a2692cc91c",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "e83830c65915e0484b78e203e6f0ca7e",
"sqflite_sw.js": "3b1895c707364268052a0f3ccb693c60",
"icons/Icon-192.png": "218ffd6ea27e87fbe30d660d9da60256",
"icons/Icon-maskable-192.png": "218ffd6ea27e87fbe30d660d9da60256",
"icons/Icon-maskable-512.png": "23368015c59f26be9e52bdd8db6aebf2",
"icons/Icon-512.png": "23368015c59f26be9e52bdd8db6aebf2",
"manifest.json": "423baef09d649c8765149a35c4ee07c9",
"assets/AssetManifest.json": "c2e85b941d06fef4156e7f8bd8a35fdd",
"assets/NOTICES": "8229ed4864fa3c8fa025f2d1a917a923",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.smcbin": "8f03d7943d2ff20b7f995b3406b18610",
"assets/fonts/MaterialIcons-Regular.otf": "cc3d3e68e2871e82c501c89c49456aec",
"assets/assets/balloons/green_balloon.png": "093d5119d8d88dc0bed4894063b7dd5d",
"assets/assets/balloons/red_balloon.png": "95ccd4e75fc72cbbc6a904d2ab551b8c",
"assets/assets/balloons/yellow_balloon.png": "9a5899e83f4d29e0a2ce7f74b72beacb",
"assets/assets/balloons/blue_balloon.png": "fa22a9e812c1fc7a73e0ff3746945368",
"assets/assets/sky/evening.jpeg": "d4ee47ae0f2c16a317abb11a86dfb72e",
"assets/assets/sky/afternoon.png": "646ee5509399662d99bca2da4be86a9b",
"assets/assets/sky/pre_evening.png": "803d494d7a2f8f1d33815250466c68c9",
"assets/assets/sky/morning.jpeg": "019c1543ae6a48b6b7e7c8059c2f45c4",
"assets/assets/trees/palm_tree.png": "019f22ed1ca6895131f4cbc594864aca",
"assets/assets/trees/blossom_tree.png": "4719c74e23112e01aca89782c22e6dfe",
"assets/assets/trees/winter_tree.png": "b59c65f16899bc14a1c6f550b84b3cbf",
"assets/assets/trees/autumn_tree.png": "d6fe1a26f7f9f9094cc123b9a17ada19",
"assets/assets/npcs/tom_nook.png": "4d5e80514fe5b85a2639874bba48e4de",
"assets/assets/npcs/aldeano.png": "354ee06a93f7d7ceacb0e62588d28732",
"assets/assets/npcs/canela.png": "efec3ea70b7936c4cf73e9d10f49404c",
"assets/assets/npcs/tendo_nendo.png": "f10a00e8e55f05908d53df238de3d4d9",
"assets/assets/npcs/totakeke.png": "278c4bb401f03bb2b1493d3374a0b915",
"assets/assets/npcs/figaro.png": "a2b4f22b4e9d34ef2335fafdcb3bde90",
"assets/assets/npcs/tom_nook.webp": "f10a00e8e55f05908d53df238de3d4d9",
"assets/assets/paths/summer.png": "ca84add31b9888ddecbff67be6e56335",
"assets/assets/paths/winter.png": "508e55a2aa48b67cf373e693a228ef64",
"assets/assets/paths/spring.png": "752cd8773e5752fdbf63d081f19bcdd1",
"assets/assets/paths/autumn.png": "05cbe3807d85ca8f709daf8c36265d4c",
"assets/assets/objects/clock.png": "285e63702d2fd712c4e35aa683d75129",
"assets/assets/logo/logo_ios.png": "0d3841d0a0d05eaec365ec9dd1aba401",
"assets/assets/logo/logo.png": "b78d2c1dbd54b4487818213455c68a1c",
"assets/assets/soundtracks/8PM.mp3": "bf3a34cbbb0ab634c68f58b6183ceba5",
"assets/assets/soundtracks/1AM.mp3": "81c6092e9c1f310861bb12b30ae2f9e6",
"assets/assets/soundtracks/3AM.mp3": "1dad1ec79c14bc3579e0dbae83b8d413",
"assets/assets/soundtracks/7AM.mp3": "6b700682e21350ecb4cd864f63d4711c",
"assets/assets/soundtracks/10PM.mp3": "52a77c82d9ff2f8d524135846217d83a",
"assets/assets/soundtracks/5AM.mp3": "2f25c18535899f845ed954946441fbf0",
"assets/assets/soundtracks/12PM.mp3": "dc6174683798963ef90bdae000f70627",
"assets/assets/soundtracks/2AM.mp3": "b84ae4a5d6da781eaaa0a4bc0ba854aa",
"assets/assets/soundtracks/9PM.mp3": "f6ac46efed8580947014a253bf485a17",
"assets/assets/soundtracks/4AM.mp3": "37f79c8de1d213ad84333e00eff5bdf2",
"assets/assets/soundtracks/11PM.mp3": "52bade33f47626b99bb2b4e7b37fcc9a",
"assets/assets/soundtracks/6AM.mp3": "1cfea7550df7fee0277b1bbb79288c41",
"assets/assets/soundtracks/3PM.mp3": "8e09f80ca0161924efe68e9e6f489572",
"assets/assets/soundtracks/1PM.mp3": "0505bc5c2989ab87f7920d0a5a36ae71",
"assets/assets/soundtracks/8AM.mp3": "a45c0ddc44fe61b10a4c76536d5c2a61",
"assets/assets/soundtracks/12AM.mp3": "d76d7b3e02dec97a3761978b184e3f3d",
"assets/assets/soundtracks/5PM.mp3": "b6e1392e6ee0f6145456ba750893f342",
"assets/assets/soundtracks/balloon.m4a": "52082dafd30acdef740b74f35f76c4ba",
"assets/assets/soundtracks/10AM.mp3": "f8c29661a3891396dfdaf4ffe0819c6e",
"assets/assets/soundtracks/7PM.mp3": "d1939c0fe69fecabdd8d52428024fbfc",
"assets/assets/soundtracks/9AM.mp3": "ca71e1e38e4eecf74a1b035e3bf44d75",
"assets/assets/soundtracks/2PM.mp3": "77429f0516779340f79db21ccb738fb0",
"assets/assets/soundtracks/6PM.mp3": "dfc6206c420d98d08815fe57f270ba68",
"assets/assets/soundtracks/11AM.mp3": "d406403e35f82317a1196ccbb5b28777",
"assets/assets/soundtracks/4PM.mp3": "3089d3524b993b35fc8a6578d0569e33",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
