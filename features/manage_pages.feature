@manage_pages @pages
Feature: manage pages
  As content manager
  I can manage pages
  so I can fill site with content

  Background:
    Given moderator user
    And static page "old page"


  Scenario: Add page
    Given I sign in as moderator
    And I visit new page form
    When I fill in title with "New Page"
    And I fill in content with "New Page Content"
    And I fill in url title with "old_page"
    And I submit page form
    Then I go to "New Page" edit form
    And I should see title "New Page"
    And I should see content "New Page Content"



  Scenario: edit page
    Given I sign in as moderator
    And I go to static pages management page
    And I go to "old page" edit form
    When I fill in title with "Edited Old Page"
    And I fill in content with "Edited Old Page Content"
    And I submit page form
    Then I go to "Edited Old Page" edit form
    And I should see title "Edited Old Page"
    And I should see content "Edited Old Page Content"

  Scenario: delete page
    Given I sign in as moderator
    And I go to static pages management page
    When I delete "old page"
    Then I should not see "old page" in pages list

