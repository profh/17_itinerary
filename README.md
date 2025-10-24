
# Journi

Journi is an app that aims to simplify the vacation planning process, from the moment someone thinks that they need a break to the moment they step foot on a sandy beach. 

## Sections
**Home View**


Home View can navigate to the "Current" itinerary as well as link to the quiz to make a new itinerary. This view is meant to be pretty minimal and act as a gateway to the other features.

**History View**


This view lets you navigate between the saved itineraries. At the top is the "Current" itinerary, followed by other saved itineraries, listed in order of last edit. Each itinerary links to the separate itinerary detail view, with events listed in order of days. From there, you can navigate to an event detail view where you can see information about the event as well as edit information about the event, or delete it. You can also add your notes to any event. Meal and travel events have a unique behavior on tapping into them - they have a popup menu where someone can either go into the detail view or go into the associated link to quickly access things like an associated Google Maps link. 

**Quiz Implementation for Itinerary Generation**

The Journi app's quiz system aims to personalize the itinerary generation process by understanding the user's preferences, interests, and desired activities. It starts with a series of questions that cater to these aspects, collecting the user's choices. Each question passes the quiz object through a series of views, ensuring that the user's responses are accurately captured and stored in the quiz model. These responses are then used to generate the itinerary, taking into account the user's preferences and the chosen destination.

Here's a breakdown of the quiz process:

Initiation: The user initiates the itinerary creation process by clicking the "Create Itinerary" button. This takes them to the quiz section.

Questions and Response Collection: The quiz presents a series of questions, each with corresponding views. The user answers these questions, selecting their preferences and interests. Each question passes the quiz object through the view, storing the user's choices in the quiz model.

Visualizing Destination: One of the questions might involve a carousel view of images, allowing the user to see potential destinations and select their preferred location. This choice is also captured in the quiz model.

Activity and Food Tags: Once the destination is chosen, the quiz focuses on itinerary-related preferences. The user selects tags that represent the types of food and activities they would like to experience. These tags are stored in arrays within the quiz model.

Itinerary Generation: With the gathered information, the app's algorithm generates an itinerary tailored to the user's preferences, considering the chosen destination, food preferences, and activity interests. The itinerary is based on a database of attractions, geos (nearby cities), and restaurants aligned with the user's choices.

Interactive Itinerary: The generated itinerary is accessible through the "History View" once saved.

In summary, the Journi quiz system guides users through a personalized itinerary creation process, gathering their preferences, interests, and destination choices. The captured information is used to generate a tailored itinerary that suits the user's unique travel preferences.

**Itinerary Generation**

To create personalized itineraries, our process begins by identifying the ideal destination from our extensive database, tailored to your quiz results. Once a destination is selected, we curate a diverse array of events comprising three main categories: attractions, geographical highlights (referred to as 'geos'), and restaurants. The 'geos' category is particularly significant, as it includes nearby cities that serve as hubs for additional attractions and dining options.

Our algorithm will then thoughtfully select two attractions and two restaurants each day, aligning them with your expressed preferences from the quiz. To ensure a seamless experience, we meticulously calculate the distances between events, utilizing the latitude and longitude coordinates of each location.

For a more in-depth interaction with your itinerary (like editing), you are encouraged to explore the 'History View' section. Here, you can not only view but also modify the details of each event. Furthermore, for detailed insights about any specific event, convenient links are provided beside the name of the event, directing you to comprehensive information sourced from TripAdvisor.

It's important to highlight that, currently, the integration of preferences for food and activities into our itinerary planning is not fully operational due to certain API limitations. This aspect represents a key area for potential enhancement.
