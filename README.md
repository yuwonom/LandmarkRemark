# Landmark Remark

A map-based mobile application for storing notes. Users can upload notes at the location where they save and these notes will be shown to all users. Users can also filter the notes to be displayed on the map based on the username and notes contents.

## Implementation

Landmark Remark was implemented using [SwiftUI](https://developer.apple.com/xcode/swiftui/) as the client side app and [Firebase](https://firebase.google.com/) as the server side app. More specifically, there are three main services used to develop the application.

1. **Location Service** is used to show current user location, focus the map to the user's region, and primarily to retrieve the geoposition when creating a new remark.

2. **Firebase Firestore** is used as the database to store users and remarks. At first install, user will be prompted to enter a username when trying to create a new remark. This user information will be persisted in a new user document. Creating a new remark will also be persisted in a new remark document.

3. **Local Storage** is used to persist the user unique ID locally. After entering the username during the first install, Firestore will return the user ID. This ID is persisted, so the device can still identify the user on the second app launch.

## Time Spent

- Understand requirements & setup initial project: **1 hour**
- Setup & integrate Firebase: **0.5 hour**
- Build UI components: **1.5 hours**
- Configure map & create location manager: **0.5 hour**
- Create Firestore manager: **2 hours**
- Create local storage manager: **0.5 hour**
- Implement search/filter remarks: **1 hour**
- Bug fixes and improvements: **2 hours**
- Setup GitHub & Readme: **1 hour**

Total approximate hours spent: **10 hours**

## Issues & Limitations

- Firestore security is all set to be open - no authentication required to update the data
- UI is very limited