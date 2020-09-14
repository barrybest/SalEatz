# SalEatz

SalEatz is a web application that allows users to search restaurants by name and geographical coordinates; filter results via rating, distance, and best match;
bookmark their favorites and create reservations.

The application is built on a Java backend (hosted on Tomcat) utilizing servlets to communicate with the client. JSPs were used as the page files to allow easy interactions between the front and back ends of the applications. Javascript, HTML, and CSS were utilized to create the dynamic content of the front-end browser interface.

Users' information (login details and bookmarked restaurants) is stored in a MySQL database after being passed to the Java servlets through the webpage. The Yelp API was used as the source of restaurant and reservation data, and the Google Maps and Calendar APIs were used to drop pins via interactive map and creating reservations on your own calendar.
