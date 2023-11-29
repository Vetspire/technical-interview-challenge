## Vetspire Take-home (max 2 hours)

The dog breed selector repository. In this project there are two main directories, the frontend and the backend. Below you will find a bit more detail about each. 

### Running the application locally
From the main directory of the checked out branch, run `npm start` and the node server and react client will start up. You may need to resolve dependencies depending on your current local environment. From there, navigate to http://localhost:3000 via your browser of choice to view the webpage. 

### Features
- Backend API that serves:
    - A list of available dog breeds based on those available in `/images`
    - Individual dog images by breed
- Frontend UI that provides:
    - A list of dog breeds
    - The ability to choose a breed and display the image for it

### Frontend
The dog breed selector front end was done via React. This allows for quick useEffects when a the dropdown menu is changed, instantly displaying the dog breed that was selected on the page. My design choices are...sparse to say the least here, but I am not an expert at web design, so I intentionally did not over complicate the page. 

### Backend
The backend of this project was done via node.js. This is due to the ease and quickness at which node can be used as a filesystem. The backend of this particular website honestly did not feel extremely necessary, but for the sake of the assessment I went with a simple API that would serve the list of dog breed names and the path to display the image. 

### In a Prod Environment
I would like to also discuss what I would do differently if this was not a short-term take home project. In the case of having a team of engineers and more time, I would design the project in the following manner:
- Data store/database:
    - We would store the actual images in an S3 bucket or similar blob data store
    - We would also have a database (I'm partial to postgreSQL) containing the following information about the assets:
        - Breed name
        - S3 Location
        - Depending on use case, we could include other metadata such as who uploaded a new breed, timestamps, etc.
        - Also depending on use case, we could include more information about the dog breeds, such as:
            - Weight (Male/Female avg)
            - Height (Male/female avg)
            - Breed Group (custom type containing classes such as sporting, toy, terrier, etc)
            - Temperament (could create a type with common temperaments or have this be freeform)
- Backend:
    - Elixir of course, since that's what we use
    - We would have a separate microservice for the backend, unlike the way this project was organized
    - GraphQL queries:
        - getBreedList - returns full list of possible breeds
        - getBreed - returns all details for a breed
    - GraphQL mutations:
        - createBreed - creates new dog breed with given fields
        - updateBreed - updates an existing breed
        - deleteBreed - removes a stored dog breed
- Frontend:
    - Also its own microservice
    - This would depend heaviily on customer use case/design choices, but I'm picturing:
        - Selector of some sort, could be always visible in a sidebar, or a dropdown, or a search (js filter would work well as a search here since there are only so many dog breeds--relatively small dataset)
        - Main display with the photo and all of the information about a breed
        - Ability to edit/delete the breed that is displayed
        - Ability to create a breed from any view

### Main Questions
I have a few questions that would determine how we should approach this project.
- Would all users have access to the same set of data? i.e., if I add a dog breed, should Tomasz be able to see it too?
    - Adds significant complexity as we would need to create database of users, consider permissions, and any security implications of giving everyone the ability to edit global data. User groups, such as a veterinarian office could also be done, but would again add complexity. 
- How many users can we expect to see on this platform at a time? While I feel the above implementation scales well thanks to Elixir, I want to be sure we don't need to consider caching the dog breeds a user has recently viewed, or any other potential bottlenecks.
- How is this data being used by our customers? Is this purely informational or are we looking to monetize this? We could integrate with other websites to link to breeders of each breed, or specific products that a particular breed might find useful. Ideally we would receive a commission on traffic/purchases sent to external entities. 
