Feature: Move left
  Scenario: Move empty board
    Given a board:
    """
    _ _ _ _
    _ _ _ _
    _ _ _ _
    _ _ _ _
    """
    When I move the board to the left
    Then the board is:
    """
    _ _ _ _
    _ _ _ _
    _ _ _ _
    _ _ _ _
    """

  Scenario: Move numbers
    Given a board:
    """
    _ _ _ 2
    _ _ 2 _
    _ 2 _ _
    2 _ _ _
    """
    When I move the board to the left
    Then the board is:
    """
    2 _ _ _
    2 _ _ _
    2 _ _ _
    2 _ _ _
    """

  Scenario: Merge numbers
    Given a board:
    """
    _ 2 _ 2
    _ _ 2 _
    2 _ 2 _
    _ 2 _ _
    """
    When I move the board to the left
    Then the board is:
    """
    4 _ _ _
    2 _ _ _
    4 _ _ _
    2 _ _ _
    """

  Scenario: Move and merge mix of numbers
    Given a board:
    """
    _ 4 _ 2
    2 _ 2 _
    2 _ 4 _
    _ 2 _ _
    """
    When I move the board to the left
    Then the board is:
    """
    4 2 _ _
    4 _ _ _
    2 4 _ _
    2 _ _ _
    """
