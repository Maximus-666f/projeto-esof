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

[TODO]

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
- Redid the map and markers using diferent package;
- The filter buttons are now working both in the map and in the search pages (the search page will be renamed to list in the next sprint);
- Started implementing the pop-up for the markers but it's not yet finalised;
- Changed the profile page to have a table with data for each specific type of bin added, liked or disliked by the user;
- Started implementing a marker for the user location, not yet fully working;
