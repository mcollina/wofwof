Feature: User creates a basic website 
  As a User
  In order to create a basic website

  Scenario: build a single page website 
    Given a new project 
    And the liquid template folder basic_website/templates/
    And the pages folder basic_website/pages
    When I render the website
    Then everyone should see that there is an index.html file
    And that the index.html file contains the text in basic_website/pages/index.page
