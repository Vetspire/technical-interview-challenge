# Dogbook
Please visit https://dogbook.fly.dev to see and try the app!

## Langauge and Framework
I chose Liveview as it offers the shortest path to the most robust/feature-rich app that I know of.
* All business logic is contained in a single app/codebase/language.
* It's the smallest amount of code to get the job done. As a result it requires the smallest investment for a business and results
in faster development cycles and higher reliability.
* Purely ephemeral client-side behaviors are easily built in javascript using liveview-state-aware Phoenix hooks. We didn't need any for this app.
Hopefully the features offered in this app compared to the amount of code written demonstrate these points.

I chose Elixir because
* functional programming removes the temptation to share state in objects
* the concurrency model is the simplest I know of, completely avoiding the problems of threading, mutexes, etc. This makes liveview possible and performant.
* the fault-tolerance patterns are top-notch and battle-tested

## Streaming Uploads
I wanted to try out streaming uploads because they offer features other methods don't. They aren't right for every app though.

### Pros
* Fixed server-side memory usage per upload. 
* Write the file wherever you want, event to multiple destinations at once. The real-time potential is great with this one.
* First class feature status in LiveView, so the bulk of the boilerplate is done for us.

### Cons
* Potentially higher costs at the cloud storage service for ingress/egress compared with direct uploads using a pre-signed URL
* It still uses server resources, even if it is fixed and manageable.

### Alternatives

#### presigned url and a direct upload to cloud storage
* A bit fussier to set up, e.g. 2 sequential requests must be made from the client for each upload.
* Thanks to Chris McCord we do have SimpleS3Upload to abstract away some of the drudgery, so that helps.
* Zero resource usage on the server side, unless we want to do post processing. Most apps let the CDN do processing these days so not as big of a deal anymore.
* Also a first class feature in LiveView, but does require a bit more coding to get it working.
#### upload the whole file to the server and store it locally to the app in shared persistent storage
* Easy to build, assuming you have local storage that is already available to all your nodes and a way to ensure unique file names across nodes. So mabye the ease is a mirage...
#### upload the whole file to the server and store it in a database
* Easy to build, rendering the images becomes more involved, likely requiring some sort of CDN anyhow.
* Database disk size considerations need to be considered, how many images can it handle vs. how many are expected to be uploaded?
* Could be useful if the images were not intended to be rendered in web pages, but rather used for some other purpose like feeding an AI model.

## UI/UX
* I didn't spend much time or thought on this. It should get the attention it deserves, I just had to pick what I was going to work on.
* I made a cursory effort to make the design work on phones and desktop, just one breakpoint though. Like I said, not much went into this part.
* The image size exansion modal-ish behavior was quickly hacked together, it would need more careful thought in a larger app where the behavior may be reused in many contexts.

## Testing
* I have a few integration tests that should break if the basic functionality breaks and shouldn't be too brittle.
* If more visual tests were needed, e.g. ensure the image gets bigger and is visible when clicked, or if new phoenix javascript hooks were added, etc., I'd pull in Playwright. It could also be used for end-to-end user journey tests, but most of that can be covered with stateful liveview tests like the one in the project. Playwright does not have a problem with flakes like server-controlled browser tests, which should be reason enough to choose it for a new project. However, it also makes the process of writing browser tests significantly faster and easier than say wallaby, so there's that too.

## Further Features
* Naturally this could use edit and delete funtionality for the list. It would be straightforward to add in the liveview.
* Multiple photos per breed could be supported by
  * adding a breed_images table and exchanging the breeds.example_image field for a has_many
  * changing the `max_entries` parameter for `allow_upload` in the liveview
  * changing the `consume_uploaded_entries` to persist breed_images associated to the new breed record
  * the hardest part would be the UX for displaying and editing multiple images per breed.