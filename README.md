# Description

You are required to create a client application that allows us to browse GitHub users

## Notes
* Please implement it under the assumption that it will be developed by a team
* Also, please consider the UX of the users who use this app


## Requirements
* Please use the API: https://developer.github.com/v3/
* In the case of **no authentication**, the rate limit is **60 requests per hour**, so please use a personal access token: https://developer.github.com/v3/guides/getting-started/#oauth

## UI Requirements
### User list screen
1. Display the user list in a list
2. Elements required for each row
- 2.1. Icon image
- 2.2. User name
3. Selecting each row moves to the user repository screen

### User repository screen
1. Displays detailed user information at the top of the list
- 1.1. Icon Image
- 1.2. User name
- 1.3. Full name
- 1.4. Number of followers
- 1.5. Number of people that the user follows
2. Under the user information, please list the user's repositories that have not been forked by the user
- 2.1. Repository name
- 2.2. Development language
- 2.3. Number of stars
- 2.4. Description
- 2.5. When you tap a row in the repository list, the URL of the repository should be displayed in WebView


