Feature: access_control

  As a user
  So that I can access the pages I am authorized to access
  I want to be able to access only the pages I am authorized to access

  Background: mentors and schools have been added to database, signed in as a super_user

    Given the following schools exist:
      | name                            | address                               | lat        | lon           |
      | Berkeley Arts Magnet School     | 2015 Virginia St, Berkeley, CA 94709  | 37.876869  | -122.270348   |
      | Jefferson Elementary School     | 1400 Ada St, Berkeley, CA 94702       | 37.878910  | -122.284420   |

    And the following supers exist:
      | name       | email                       |
      | Jasamine   | jasamine@sagementorship.org |

    And the following admins exist:
      | name       | email                      | school_id                    |
      | Darain     | darain@sagementorship.org  | Berkeley Arts Magnet School  |

    And the following mentors exist:
      | name      | email             | school_id                    |
      | Emma X    | emmax@berkeley.edu | Berkeley Arts Magnet School  |
      | Kyler     | ko@berkeley.edu   | Berkeley Arts Magnet School  |

  Scenario: 1) sign in as a super_user, should be able to access super page
    Given I am signed in as an "super", "Jasamine"
    When I try to access the "super_account_management, Jasamine" page
    Then I should be on the "super_account_management, Jasamine" page


  Scenario: 2) sign in as an admin, should be able to access summaries page of my school
    Given I am signed in as an "admin", "Darain"
    When I try to access the "school_activity, Berkeley Arts Magnet School" page
    Then I should be on the "school_activity, Berkeley Arts Magnet School" page


  Scenario: 3) sign in as an admin, should not be able to access summaries page of school other than mine
    Given I am signed in as an "admin", "Darain"
    When I try to access the "school_activity, Jefferson Elementary School" page
    Then I should be redirected to the "home" page
    And I should see the message "You don't have access to that page!"


  Scenario: 4) sign in as a mentor, should be able to access my appointment page for geolocation checkin and checkout
    Given I am signed in as an "mentor", "Emma X"
    When I try to access the "mentor_geoloc_appointment, Emma X" page
    Then I should be on the "mentor_geoloc_appointment, Emma X" page


  Scenario: 5) sign in as a mentor, should not be able to access appointment page for other mentor
    Given I am signed in as an "mentor", "Emma X"
    When I try to access the "mentor_geoloc_appointment, Kyler" page
    Then I should be redirected to the "home" page
    And I should see the message "You don't have access to that page!"


  Scenario: 6) sign in as an invalid user
    Given I am signed in as an "invalid user", "invalid_user"
    When I try to access the "super_account_management, Jasamine" page
    Then I should be redirected to the "home" page


  Scenario: 7) sign out
    Given I am signed in as an "super", "Jasamine"
    Then I sign out
    Then I should be redirected to the "home" page
    And I should see the message "Logged out!"
    When I try to access the "super_account_management, Jasamine" page
    Then I should be redirected to the "home" page

