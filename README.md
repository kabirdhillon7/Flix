# Flix
Flix is an iOS app that allows users to browse movies from [The Movie Database API](http://docs.themoviedb.apiary.io/#). 

Flix is designed using the Model-View-ViewModel (MVVM) pattern, which separates the app's data model, user interface, and business logic into distinct components.

## Table of Contents

- [Description](#description)
- [Requirements](#Requirements)
- [Demo](#demo)
- [Installation](#installation)
- [Testing](#testing)
- [Contact](#contact)

## Description

Some of the main features include:

- [X] User can tap a cell to see more details about a particular movie.
- [X] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.
- [X] User sees an app icon on the home screen and a styled launch screen.
- [X] User can view and scroll through a list of movies now playing in theaters.
- [X] User can view the movie poster image for each movie.

- [X] User can view the app on various device sizes and orientations.
- [X] Run your app on a real device.
- [X] User can tap a poster in the collection view to see a detail screen of that movie.
- [X] In the detail view, when the user taps the YouTube Player View they can view the trailer.

## Requirements

- iOS 15.0 or later
- iPhone 6s or newer
- iPod touch 7th generation or newer

## Demo
### Current Progress Walkthrough
<img src="https://github.com/kabirdhillon7/Flix/blob/main/Walkthrough_1.26.23.gif" width=250><br>

### Progress 3 Walkthrough
<details>
  <img src="https://github.com/kabirdhillon7/Flix/blob/main/walkthrough12:22.gif" width=250><br>
</details>

### Progress 2 Walkthrough
<details>
  <summary>Click to view</summary>
  
  <img src="https://github.com/kabirdhillon7/Flix/blob/main/Walkthrough%202.gif" width=250><br>
</details>

### Progress 1 Walkthrough
<details>
  <summary>Click to view</summary>
  
  <img src="https://github.com/kabirdhillon7/Flix/blob/main/Walktrhough.gif" width=250><br>
</details>

## Installation

To install and set up the app on your own device, follow these steps:

### Prerequisites
- Xcode 11 or later
- CocoaPods (installation instructions can be found at https://cocoapods.org/)

### Cloning the repository

To clone the repository, open a terminal and enter the following command:
```
git clone https://github.com/kabirdhillon7/Flix
```

### Installing dependencies

To install the dependencies for the app, navigate to the directory where you cloned the repository and run the following command:
```
pod install
```
This will install all of the dependencies specified in the `Podfile`.

Open the `Flix.xcworkspace` file in Xcode. Make sure that the `Flix` scheme is selected, and then click the "Run" button to build and run the app.

### Configuration

Before you can use the app, you will need to set up your API keys. To do this, follow these steps:

1. Go to https://developers.themoviedb.org/3 and sign up for an API key.
2. In Xcode, open the `APICaller.swift` file and replace `key` with the API key you received.

## Testing

In order to test the functionality of this project, I have set up test cases for the `ViewModels`. The test cases check if the `ViewModels` are able to retrieve the data and handle the data correctly.

To run the tests, open the project in Xcode, then go to the `Product` menu and select `Test` or use the `⌘ + U` keyboard shortcut.

### Test Dependencies
The tests use the following dependencies:

- [XCTest](https://developer.apple.com/documentation/xctest): A framework provided by Apple that allows us to write tests for our iOS code.
- [Combine](https://developer.apple.com/documentation/combine): A framework provided by Apple for handling asynchronous code.

### Test Files
There are two test files in the project:

#### MoviesViewModelTests

This file contains tests for the `MoviesViewModel`. The tests check if the `ViewModel` is able to retrieve movie data correctly and if the `ViewModel` is correctly handling the data.

#### MoviesGridTests

This file contains tests for the `MoviesGridViewModel`. The tests check if the `ViewModel` is able to retrieve superhero movie data correctly and if the `ViewModel` is correctly handling the data.

#### MovieDetailsViewModelTests

This file contains tests for the `MovieDetailsViewModel`. The tests check if the `ViewModel` is able to retrieve superhero movie data correctly and if the `ViewModel` is correctly handling the data.

## Dependencies

This app uses the following dependencies:

- [Alamofire](https://github.com/Alamofire/Alamofire) (MIT License)
- [Alamofire Image](https://github.com/Alamofire/AlamofireImage) (MIT License)
- [Cosmos](https://github.com/evgenyneu/Cosmos) (MIT License)
- [YouTube-Player-iOS-Helper](https://github.com/youtube/youtube-ios-player-helper) (Apache License 2.0)

## Contact

If you have any questions or feedback, you can reach me through the following channels:

- GitHub: [@kabirdhillon7](https://github.com/kabirdhillon7)
- LinkedIn: [Kabir Dhillon](https://www.linkedin.com/in/kabirdhillon/)
