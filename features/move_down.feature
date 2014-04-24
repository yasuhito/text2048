Feature: Move down
  Scenario: Empty board
    Given a board:
    """
    ____
    ____
    ____
    ____
    """
    When I hit the down key
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
    When I hit the down key
    Then the board is:
    """
    ____
    ____
    ____
    2___
    """

  Scenario: Four '2's
    Given a board:
    """
    2___
    _2__
    __2_
    ___2
    """
    When I hit the down key
    Then the board is:
    """
    ____
    ____
    ____
    2222
    """

  Scenario: Merge '2's
    Given a board:
    """
    22__
    _2__
    __22
    ___2
    """
    When I hit the down key
    Then the board is:
    """
    ____
    ____
    ____
    2424
    """

  Scenario: Merge '2's
    Given a board:
    """
    2___
    _22_
    2__2
    __2_
    """
    When I hit the down key
    Then the board is:
    """
    ____
    ____
    ____
    4242
    """

  Scenario: 4s and 2s
    Given a board:
    """
    2___
    _24_
    4___
    __22
    """
    When I hit the down key
    Then the board is:
    """
    ____
    ____
    2_4_
    4222
    """
