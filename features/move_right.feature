Feature: Move right
  Scenario: Empty board
    Given a board:
    """
    ____
    ____
    ____
    ____
    """
    When I hit the right key
    Then the board is:
    """
    ____
    ____
    ____
    ____
    """

  Scenario: One '2'
    Given a board:
    """
    2___
    ____
    ____
    ____
    """
    When I hit the right key
    Then the board is:
    """
    ___2
    ____
    ____
    ____
    """

  Scenario: Four '2's
    Given a board:
    """
    2___
    _2__
    __2_
    ___2
    """
    When I hit the right key
    Then the board is:
    """
    ___2
    ___2
    ___2
    ___2
    """

  Scenario: Merge '2's
    Given a board:
    """
    22__
    _2__
    __22
    ___2
    """
    When I hit the right key
    Then the board is:
    """
    ___4
    ___2
    ___4
    ___2
    """

  Scenario: Merge '2's
    Given a board:
    """
    2_2_
    _2__
    _2_2
    ___2
    """
    When I hit the right key
    Then the board is:
    """
    ___4
    ___2
    ___4
    ___2
    """

  Scenario: 4s and 2s
    Given a board:
    """
    4_2_
    _2__
    _2_4
    ___2
    """
    When I hit the right key
    Then the board is:
    """
    __42
    ___2
    __24
    ___2
    """
