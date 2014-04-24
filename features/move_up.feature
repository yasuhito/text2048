Feature: Move up
  Scenario: Empty board
    Given a board:
    """
    ____
    ____
    ____
    ____
    """
    When I hit the up key
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
    ____
    ____
    ____
    2___
    """
    When I hit the up key
    Then the board is:
    """
    2___
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
    When I hit the up key
    Then the board is:
    """
    2222
    ____
    ____
    ____
    """

  Scenario: Merge '2's
    Given a board:
    """
    22__
    _2__
    __22
    ___2
    """
    When I hit the up key
    Then the board is:
    """
    2424
    ____
    ____
    ____
    """

  Scenario: Merge '2's
    Given a board:
    """
    2___
    _22_
    2__2
    __2_
    """
    When I hit the up key
    Then the board is:
    """
    4242
    ____
    ____
    ____
    """

  Scenario: 4s and 2s
    Given a board:
    """
    2___
    _24_
    4___
    __22
    """
    When I hit the up key
    Then the board is:
    """
    2242
    4_2_
    ____
    ____
    """
