Feature: User creates a website with links
  As a User
  In order to create a basic website with some pages
  with links between them.

  Background:
    Given a new project 
    And the liquid template folder links/templates/
    And the pages folder links/pages
    When I render the website
    Then everyone should see that there is an a.html file
    And everyone should see that there is an b.html file

  Scenario: build two pages with the template linking to both
    Then the a.html file contains the text '<a href="b.html">B!</a>'
    And the b.html file contains the text '<a href="a.html">A!</a>'

  Scenario: build two pages that should link to themselves
    And the a.html file contains the text '<a href="a.html">A!</a>'
    And the b.html file contains the text '<a href="b.html">B!</a>'
