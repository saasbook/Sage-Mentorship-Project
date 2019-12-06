Feature: amend_attendances

  As a admin
  So that I can amend the attendance of mentors of my school
  I want to validate an invalid checkin/out record, create a new checkin, or create a new corresponding checkout for a checkin that's missing a checkout

  Background: mentors and schools have been added to database, signed in as a super_user

    Given the following "schools" exist:
      | Berkeley Arts Magnet School     | 2015 Virginia St, Berkeley, CA 94709  | 37.876869  | -122.270348   |

    And the following "admins" exist:
      | Darain Noveir     | bam@sagementorship.org  | Berkeley Arts Magnet School  |

    And the following "mentors" exist:
      | Emma Sandoval     | es@berkeley.edu | Berkeley Arts Magnet School  |

    And the following "checkins" exist:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-2 13:00:00  | 37.876869 | -122.270348 | false |

    Given I am signed in as an "admin(Darain Noveir)"

  Scenario: validate an invalid checkin/out record
    When I am on the "checkin(Emma Sandoval, 2019-12-2)" page
    And I press the “Edit Check In” link
    Then I should be redirected to the "edit_checkin(Emma Sandoval, 2019-12-2)" page
    And I check the checkbox labeled "isValid"
    And I press the “Save” button
    Then I should have this "checkin" record:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-2 13:00:00  | 37.876869 | -122.270348 | true |

  Scenario: create a new corresponding checkout for a checkin that's missing a checkout
    When I am on the "checkin(Emma Sandoval, 2019-12-2)" page
    And I press the “Create New Checkout” link
    Then I should be redirected to the "new_checkout" page
    And I pick "2019-12-2 14:00:00" in the datetime_select box labeled "checkout_time"
    And I press the “Save” button
    Then I should have this "checkout" record:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-2 14:00:00  | 37.876869 | -122.270348 | true |

  Scenario: create a new checkin
    When I am on the "attendances(Emma Sandoval, 2019-12-2)" page
    And I press the “Create new checkin” link
    Then I should be redirected to the "new_checkin" page
    And I pick "2019-12-5 7:00:00" in the datetime_select box labeled "checkin_time"
    Then I should have this "checkin" record:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-5 7:00:00  | 37.876869 | -122.270348 | true |

