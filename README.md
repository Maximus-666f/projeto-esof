<!-- README.md for LEIC-ES-2023-24 -->

# Bin Finder Development Report

Welcome to the documentation pages of the _Bin Finder_!

You can find here details about the _Bin Finder_, from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by type of activities: 

- [Bin Finder Development Report](#bin-finder-development-report)
  - [Business Modelling](#business-modelling)
    - [Product Vision](#product-vision)
    - [Features and Assumptions](#features-and-assumptions)
    - [Elevator Pitch](#elevator-pitch)
  - [Requirements](#requirements)
    - [Domain model](#domain-model)
  - [Architecture and Design](#architecture-and-design)
    - [Logical architecture](#logical-architecture)
    - [Physical architecture](#physical-architecture)
    - [Vertical prototype](#vertical-prototype)
  - [Project management](#project-management)

Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

*Rodrigo Pinto Pesqueira Gaspar Pombo - up202105374@up.pt*

*Liess Pereira Aouimeur - up202206296@up.pt*

*Pedro Jorge das Neves Pinto Vieira - up202206230@fe.up.pt*

---
## Business Modelling

### Product Vision

This app will allow the user to access a map with the distribution of trash and recycling bins around the world and be part of a community that brings our app to life by adding new bins and correcting the mistakes of others with reports. Allowing for our app to be self-suficient and fully community driven.

### Features and Assumptions

1. Account creation and management system
2. Visualization of a map with the bins and the ability to filter by specific type of bin
3. Ability to add new bin in the map and specify it's type
4. Voting system for each specific bin, both positive votes and reports in order to correct badly indicated bins
5. The ability to get the directions to a specific bin
6. A search bar showcasing nearby bins has an alternative way of searching for them, including being able to filter by specific bin type
7. A score system, that gives the user points for their contributions.

### Elevator Pitch

Já alguma vez ficaste com o lixo na mão sem saber onde o pôr? Isto é um problema do passado.

Com o Bin Finder consegues rápida e eficazmente encontrar um lixo perto de ti! Basta abrir a aplicação e com esse simples toque ter acesso a um mapa que te indica vários lixos na tua proximidade. Também é possível visualizar os lixos em forma de lista e se isso não for que chegue podes ainda filtrar entre os diversos tipos de caixotes tanto no mapa como na lista.

O Bin Finder é dirigido pela sua comunidade, qualquer utilizador consegue dar like ou dislike  de um lixo e também adicionar a localização de um contentor à aplicação. Cada utilizador pode ainda ver a sua contribuição na sua página de perfil e ver o seu impacto.

Do que estás à espera junta-te à comunidade Bin Finder hoje!

## Requirements

### Domain model

![domain model](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/domain_model.jpeg)

UserStats - only has derived attributes

Votes - the type attribute indicates whether it's a like or dislike

BinType - the type attribute indicates which of the 4 bins it is: BlackBin, GreenBin, YellowBin and BlueBin

## Architecture and Design

### Logical architecture

![logical architecture](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/logical_architecture.jpg)

### Physical architecture

![physical architecture](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/physical_architecture.jpg)

### Vertical prototype

A really basic application, with the 3 main pages: Profile, Map and Search with the buttons already present but that don't interact with anything yet, except the navigation bar which is functional.

We also added some example data, the map has a bin marker right on top of FEUP that can be clicked and shows more information. In the search screen there are a lot of results that are presented has buttons, although they don't yet redirect to their specific bin in the map. In both the previous screens the toggable buttons to filter by specific type of bins do toggle on and off but don't do anything yet. In the profile page there are also the edit profile and delete account buttons that also don't do anything yet.

## Project management

Iteration 0 project board:

![iteration 0 project board](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/project_board_screenshot.png)

Beginning iteration 1 project board:

![beginning iteration 1 project board](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/beginning_iteration_1_project_board_screenshot.png)

End iteration 1 project board:

![end iteration 1 project board](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/end_iteration_1_project_board_screenshot.png)

Sprint 1 retrospective:

We had dificulties dealing with async functions and enabling the pages to pass information from one another.

Happiness meter: We are satisfied with the progress made during this sprint. We are confident that at this rate we'll be able to finish this project.

Sprint 1 changelog:

Changed/Implemented features:
- Redid the map and markers using diferent package; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/2
- The filter buttons are now working both in the map and in the search pages (the search page will be renamed to list in the next sprint); https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/5
- Started implementing the pop-up for the markers but it's not yet finalised; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/1 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/3
- Changed the profile page to have a table with data for each specific type of bin added, liked or disliked by the user; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/4
- Started implementing a marker for the user location, not yet fully working; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/2

Beginning iteration 2 project board:

![beginning iteration 2 project board](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/beginning_iteration_2_project_board_screenshot.png)

End iteration 2 project board:

![end iteration 2 project board](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/end_iteration_2_project_board_screenshot.png)

Sprint 2 retrospective:

The User Interface is for the most part already implemented, leaving, for the features implemented, just the tests and data base to be added.

Happiness meter: Due to problems with the implementation of the data base, we are somewhat satisfied with the progress made during this sprint. Thus we don't know if the complete termination of the project will be possible, particularly the tests for each user story.

Sprint 2 changelog:

Changed/Implemented features:
- The interface for the marker's pop-up was finalised; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/1 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/3 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/5
- Added a "favorites" button for the bins, changing it's border on the map from black to amber and from green to amber on the list; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/3 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/2
- It's now possible to go from the list to the bin pop-up of the bin chosen; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/2
- The "directions" button now works and sends the user to google maps with the directions from the user position to the location of the bin; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/3
- A table in the user profile page showing the user's number of liked bins, disliked bins and added bins for each bin type was added; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/4
- Interface for adding bins to the map was implemented; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/7
- The "delete account" button was implemented in the user's profile page; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/6
- New button to center the map on the user's position was added; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/2
- In general, the colors were changed everywhere;

Beginning iteration 3 project board:

![beginning iteration 3 project board 1](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/beginning_iteration_3_project_board_screenshot_1.png)

![beginning iteration 3 project board 2](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/beginning_iteration_3_project_board_screenshot_2.png)

End iteration 3 project board:

![end iteration 3 project board 1](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/end_iteration_3_project_board_screenshot_1.png)

![end iteration 3 project board 2](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/end_iteration_3_project_board_screenshot_2.png)

Sprint 3 retrospective:

We nearly fully implemented our app with Firebase, not only everything isn't hardcoded anymore but we also did all the user creation, the only things left to implement with Firebase would be deleting the account and changing the email.

Happiness meter: We are again somewhat satisfied. We were able to implement nearly everything except for the tests.

Sprint 3 changelog:

Changed/Implemented features:
- Created login/register user interface; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/31
- Created forgot password user interface; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/29
- Created verification email user interface; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/31
- The user is now able to login or register into the app saving the user's information in firebase; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/31
- Firebase can now send a verification email to the user; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/31
- Firebase can now send a password recovery email to the user; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/29
- Changed the layout of the buttons on the user's profile page; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/6 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/30
- The "Sign out" and "Change password" buttons are now working with firebase; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/30
- The map now gets the bin's information from firebase, not hardcoded values; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/2 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/3 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/5
- The user's profile now gets it's information from firebase, not hardcoded data; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/4
- Now any interaction from the user with a bin, meaning any like, dislike or bin added, is saved in firebase; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/7 / https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/1
- The list now shows real values, meaning values taken from firebase, instead of hardcoded values; https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/issues/5