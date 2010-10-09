Feature: logging the creation of a website   
  As a User
  In order to create a basic website wants everything logged 

  Background:
    Given a new project 
    And the pages folder basic_website/pages
    And the logging is configured to level INFO

  Scenario: build a single page in a single directory website 
    Given the liquid template folder basic_website/templates/
    When I render the website
    Then everyone should see that there is an index.html file
    And that the index.html file contains the text in basic_website/pages/index.page
    And it should log "rendering index.page into index.html"
    And it should log "using main.template as a default template"
  
  Scenario: correctly log if something goes wrong 
    Given the liquid template folder not/existent/folder 
    When I render the website
    Then it should log "rendering index.page into index.html"
    And it should log "no template found!"
