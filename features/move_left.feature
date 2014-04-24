Feature: Move left
  Scenario: Empty board
    Given a board:
    """
    ____
    ____
    ____
    ____
    """
    When I hit the left key
    Then the board is:
    """
    ____
    ____
    ____
    ____
    """

  Scenario: One 2
    Given a board:
    """
    ___2
    ____
    ____
    ____
    """
    When I hit the left key
    Then the board is:

    """
    2___
    ____
    ____
    ____
    """

  Scenario: Four 2s
    Given a board:
    """
    ___2
    __2_
    _2__
    2___
    """
    When I hit the left key
    Then the board is:
    """
    2___
    2___
    2___
    2___
    """

  Scenario: Merge 2s
    Given a board:
    """
    _2_2
    __2_
    2_2_
    _2__
    """
    When I hit the left key
    Then the board is:
    """
    4___
    2___
    4___
    2___
    """

  Scenario: 4s and 2s
    Given a board:
    """
    _4_2
    __2_
    2_4_
    _2__
    """
    When I hit the left key
    Then the board is:
    """
    42__
    2___
    24__
    2___
    """
