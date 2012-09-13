@manage_news @news
Feature: manage news
  As content manager
  I can manage news
  so I can add news to site

  Background:
    Given moderator user
    And post "New Post"

  Scenario: Add post
    Given I sign in as moderator
    And I visit new post form
    When I fill in post title with "New Post"
    And I fill in post description with "short post description"
    And I fill in post content with "Lorem ipsum dolor sit amet..."
    And I check post published checkbox
    And I fill in post roots url with "www.somesite.com"
    And I fill in post author with "RubyRoid"
    And I submit post page form
    Then I go to news management page
    And I should see "New Post" in a list 

  Scenario: edit post
    Given I sign in as moderator
      Then I go to news management page
      Then I go to "New Post" post edit form
      When I fill in post title with "Edited New Post"
      And I fill in post description with "edited short post description"
      And I fill in post content with "edited Lorem ipsum dolor sit amet..."
      And I fill in post roots url with "www.editedsomesite.com"
      And I fill in post author with "EditedRubyRoid"
      And I submit post page form
      Then I go to news management page
      And I should see "Edited New Post" in a list 

  Scenario: delete page
    Given I sign in as moderator
    Then I go to news management page
    When I delete post "New Post"
    Then I should not see "New Post" in posts list

   Scenario: publish post
    Given I sign in as moderator
    Then I go to news section
    Then I should not see "New Post" in posts list
    Then I go to news management page
    Then I go to "New Post" post edit form  
    And I check post published checkbox
    And I submit post page form
    Then I go to news section
    And I should see "New Post" in a list 

