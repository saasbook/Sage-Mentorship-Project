Feature: access_control

  As a user
  So that I can access the pages I am authorized to access
  I want to be able to access only the pages I am authorized to access

  Background: mentors and schools have been added to database, signed in as a super_user

    Given the following "supers" exist:
      | name         | email                      |
      | Jasamine     | jasmine.yong@berkeley.edu  |

    And the following "schools" exist:
      | name                            | address                               | lat        | lon           |
      | Berkeley Arts Magnet School     | 2015 Virginia St, Berkeley, CA 94709  | 37.876869  | -122.270348   |
      | Jefferson Elementary School     | 1400 Ada St, Berkeley, CA 94702       | 37.878910  | -122.284420   |

    And the following "admins" exist:
      | Darain Noveir     | bam@sagementorship.org  | Berkeley Arts Magnet School  |

    And the following "mentors" exist:
      | name              | email           | school                       |
      | Emma Sandoval     | es@berkeley.edu | Berkeley Arts Magnet School  |
      | Kyler Ochoa       | ko@berkeley.edu | Jefferson Elementary School  |

  Scenario: sign in as a super_user, should be able to access super page
    Given I am signed in as a "super(Jasamine)"
    Then I should be redirected to the "super(Jasamine)" page
    Then I should be on the the "super(Jasamine)" page

  Scenario: sign in as an admin, should be able to access summaries page of my school
    Given I am signed in as an "admin(Darain Noveir)"
    Then I should be redirected to the "school_activity(Berkeley Arts Magnet School)" page
    Then I should be on the the "school_activity(Berkeley Arts Magnet School)" page

  Scenario: sign in as an admin, should not be able to access summaries page of school other than mine
    Given I am signed in as an "admin(Darain Noveir)"
    When I tried to access the "school_activity(Jefferson Elementary School)" page
    Then I should be redirected to the "root" page with a "You don't have access to that page!" notice message poped up

  Scenario: sign in as a mentor, should be able to access my appointment page for geolocation checkin and checkout
    Given I am signed in as a "mentor(Emma Sandoval)"
    Then I should be redirected to the "appointment(Emma Sandoval)" page

  Scenario: sign in as a mentor, should not be able to access appointment page for other mentor
    Given I am signed in as a "mentor(Emma Sandoval)"
    When I tried to access the "appointment(Kyler Ochoa)" page
    Then I should be redirected to the "root" page with a "You don't have access to that page!" notice message poped up

  Scenario: sign in as an invalid user
    Given I am signed in as an "invalid user"
    Then I should be redirected to the "root" page with a "User does not exist." notice message poped up

  Scenario: sign out
    Given I am signed in as a "super(Jasamine)"
    Then I sign out
    Then I should be redirected to the "root" page with a "Logged out!" notice message
    When I tried to access the "super(Jasmine)" page
    Then I should be redirected to the "root" page
