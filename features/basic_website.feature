Feature: User creates a basic website 
  As a User
  In order to create a basic website uses a single template

  Scenario: build a single page in a single directory website 
    Given a new project 
    And the liquid template folder basic_website/templates/
    And the pages folder basic_website/pages
    When I render the website
    Then everyone should see that there is an index.html file
    And that the index.html file contains the text in basic_website/pages/index.page
  
  Scenario: build a multi source directory simple basic website 
    Given a new project 
    And the liquid template folder basic_website/templates/
    And the pages folder basic_website/pages
    And the pages folder basic_website/other
    When I render the website
    Then everyone should see that there is an index.html file
    And that the index.html file contains the text in basic_website/pages/index.page
    And everyone should see that there is an other.html file
    And that the other.html file contains the text in basic_website/other/other.page

  Scenario: build a page using the markdown syntax
    Given a new project 
    And the liquid template folder basic_website/templates/
    And the pages folder basic_website/markdown
    When I render the website
    Then everyone should see that there is an index.html file
    And that the index.html file contains the markdown representation of basic_website/markdown/index.page
