@manage_page_parts @page_parts
Feature: manage pages
  As content manager
  I can manage page partss
  so I can change content of pages

  Background:
    Given moderator user
    And page part "SOME_PAGE_PART"

  Scenario: edit page
    Given I sign in as moderator
    And I go to static page parts management page
    And I go to "SOME_PAGE_PART" edit form
    When I fill in content with "Edited Old Page Content"
    And I submit page part form
    Then I go to "SOME_PAGE_PART" edit form
    And I should see content "Edited Old Page Content"

