Feature: logging the creation of a website   
  As a User
  In order to create a basic website wants everything logged 

  Scenario: build a single page in a single directory website 
    Given a new project 
    And the liquid template folder basic_website/templates/
    And the pages folder basic_website/pages
    And the logging is configured to level INFO
    When I render the website
    Then everyone should see that there is an index.html file
    And that the index.html file contains the text in basic_website/pages/index.page
    And it should log "rendering index.page into index.html"
    And it should log "using main.template as a default template"
  
