# NewYorkTimesViper

IOS Developer test task

Objectives

Your goal for this task is to create a simple 2-screen application based on the free New York Times API(https://developer.nytimes.com/docs/books-product/1/overview).
There are no limitations in the design.

Screen 1:

The first screen is where the user can see all the categories: Combined Print and E-Book Fiction, Hardcover Fiction, etc. Each item should have at least the name and published date.

Screen 2:

As a user, I can click on any category from the list and see the list of books. As a user, I want to see at least the book's name, description, author, publisher, image, and rank. Additionally, there should be a link to buy this book. The link has to be opened inside the app.

Functional requirements: 

The app must open and work without any crashes and freezes;
All the links have to be opened inside the app;
Both lists must be cashed, so as a user, I want to have the same experience doesn't matter if I'm online or offline;

Technical requirements:

Swift, URLSession/Alamofire, Codable;
The result of your work is a public repository on GitHub. The project has to be built without errors;
For UI you can use SwiftUI or UIKit, doesn’t matter, but for UIKit you CAN’T use storyboards or xibs(code only UI);
Try to use one of the following architecture approaches: MVVM / Viper / Clean Architecture;
Realm / CoreData for local storage;
No hardcoded strings, localization has to be in place;
Combine/async-await for async tasks;

