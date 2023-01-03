# Flix
Flix is an iOS app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Table of Contents

- [Description](#description)
- [Demo](#demo)
- [Installation](#installation)
- [Testing](#testing)
- [Release Notes](#release-notes)
- [Contact](#contact)

## Description

Some of the main features include:

- [X] User can tap a cell to see more details about a particular movie.
- [X] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.
- [X] User sees an app icon on the home screen and a styled launch screen.
- [X] User can view and scroll through a list of movies now playing in theaters.
- [X] User can view the movie poster image for each movie.

BONUS
- [ ] User can view the app on various device sizes and orientations.
- [ ] Run your app on a real device.
- [X] User can tap a poster in the collection view to see a detail screen of that movie.
- [X] In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

## Demo

### Part 1 Walkthrough
<img src="https://github.com/kabirdhillon7/Flix/blob/main/Walktrhough.gif" width=250><br>

### Part 2 Walkthrough
<img src="https://github.com/kabirdhillon7/Flix/blob/main/Walkthrough%202.gif" width=250><br>

### Current Progress Walkthrough
<img src="https://github.com/kabirdhillon7/Flix/blob/main/walkthrough12:22.gif" width=250><br>

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
2. In Xcode, open the `APICaller.swift` file and replace `apiKey` with the API key you received.

## Testing

Information on how to test the project, including any automation scripts or test suites that have been set up.

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
