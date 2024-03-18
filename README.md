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

To better understand the context of the software system, it is very useful to have a simple UML class diagram with all the key concepts (names, attributes) and relationships involved of the problem domain addressed by your module. 
Also provide a short textual description of each concept (domain class). 

![domain model](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC13T3/raw/main/domain_model.jpeg)

## Architecture and Design

[TODO]

### Logical architecture

[TODO]

### Physical architecture

[TODO]

### Vertical prototype

[TODO]






USER STORIES:

As a user, I want to be able to sign up and log in to the app using my email and password so that I can access its features.

As a user, if I forget my password, I want to be able to be able to recover my account and change my password to a new one.

As a user, I want to be able to change my email address, username and password associated with my account.

As a user, I want to be able to delete my account.

As a user, I want to see a map displaying all the available bins nearby so that I can easily locate them.

As a user, I want to be able to add a new bin in a specific location on the map,  as well as specity the type of trash it accepts so that others can find it and use it.

As a user, I want to be able to report a bin if it's falsely marked or if there's an issue with it so that it can be addressed.

As a user, I want to view details about a specific bin, including its location, type(s), and the number of votes and reports associated with it, so that I can make an informed decision about using it.

As a user, I want to track my contributions to the app (such as adding new bins or reporting issues) and see my level or progress within the community.

As a user, I want to be able to filter the bins displayed on the map based on their types (e.g., only show bins for recycling paper) so that I can find the most relevant bins for my needs.