@users_management @users
Feature: manage users
  As administrator
  I can manage users
  so I can fill site with users

  Background:
    Given admin user
    And regular user


  Scenario: Add user
    Given I sign in as admin
    And I visit new user form
    When I fill in email with "new_user@nevermail.com"
    And I fill in name with "Bob"
    And I fill in surname with "Dylan"
    And I fill in password with "secret"
    And I create user
    Then I should see "Bob Dylan" in list



  Scenario: edit user
    Given I sign in as admin
    And I go to users management page
    When I go to "User Regular" edit form
    And I fill in name with "Bob"
    And I fill in surname with "Dylan"
    And I fill in password with "secret"
    And I save user
    Then I should see "Bob Dylan" in list

  Scenario: delete user
    Given I sign in as admin
    And I go to users management page
    When I delete "User Regular"
    Then I should not see "User Regular" in list

