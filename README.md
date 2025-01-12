# Food Management Project - README

## Project Structure

The project is organized into the following main directories:

1. **lib/**
   - Contains the main source code for the application.
   - Subdirectories:
     
     - `pages/`: Contains all the UI screens, such as:

        - `dashboard.dart`: Entry page of the app.
        - `add_menu.dart`: For adding today's menu.
        - `add_plan.dart`: For adding a new meal plan.
        - `my_plan.dart`: Displays all meal plans.
        - `menu.dart`: Displays today's menu.

     - `stores/`: Includes MobX stores used for state management, such as:
        - `meal_plan_store.dart`: Manages the state of all meal plans.
        - `meal_store.dart`: Handles the state of today's menu.
        - `theme_store.dart`: Toggles between light and dark modes.
    
     - `widgets/`: Reusable UI components, including:
        - `snackbar_widget.dart`
        - `custom_widget.dart`

     - `services/`: Contains utility services, such as:
       - `api_service.dart`: Handles local JSON data for managing meal plans.
       - `shared_preferences.dart`: Manages the persistence of today's menu and other user preferences.
     - `models/:` Contains models to serialize and deserialize JSON data into Dart models.
     The modeling is done in two separate files: `meal_model.dart` and `plan_model.dart`.
    
     - `theme/`: Contains theme data for light and dark modes.

2. **assets/**
   - Stores static assets like images, icons, and JSON files for predefined meal plans.

3. **pubspec.yaml**
   - Lists all the dependencies, including MobX and other libraries used in the project.

## Key Implementation Decisions

1. **State Management:**
   - MobX is chosen for its reactive programming model. It provides built-in reactivity, automatically updating the UI when observables change. This reduces the need for manual handling of state transitions, making it ideal for small to medium-sized projects.

2. **Shared Preferences:**
   - Shared Preferences is used to store today's menu. Once a user enters the menu, it is stored with a 24-hour expiration. The storage refreshes every 24 hours.

3. **API Layer:**
   - The API layer manages the addition of new meal plans by creating a writable copy of the JSON file in the assets directory. This writable JSON is used for both displaying and adding new meal plans.

4. **Dark Mode Toggle:**
   - A dark mode toggle is added to enhance the user experience by supporting theme customization.

5. **MediaQuery:**
   - MediaQuery is implemented to handle the display of variable screen sizes.

6. **Modular Structure:**
   - The project structure is modular to ensure scalability and maintainability. Each feature is encapsulated in its own set of screens, models, and stores.

## Known Issues and Limitations

1. **No Backend Integration:**
   - The app currently uses local storage for all data.

2. **Feedback and Attendance Features:**
   - Feedback and attendance features are not implemented in the current version.

## State Management Approach

MobX was chosen as the state management solution due to its simplicity and effectiveness in handling reactive state. The key stores are:

- **MealPlanStore:**
  - Manages the creation, deletion, and updating of meal plans.

- **TodayMealStore:**
  - Tracks meals assigned to today's schedule.

- **ThemeStore:**
  - Manages an observable boolean for toggling between light and dark modes across the application.

The observables in these stores automatically update the UI when data changes, providing a smooth and dynamic user experience.

## Design Deviations

1. **Dedicated Dark Mode Switch:**
   - A dedicated switch was added to the app bar on the dashboard screen to toggle between light and dark modes dynamically.

2. **Menu Page Design:**
   - A simple card design was implemented on the menu page to display today's menu.

3. **Navigation Flow:**
   - An "Add Today's Menu" button was added to the menu screen, enabling users to navigate to the Add Menu page.

    
