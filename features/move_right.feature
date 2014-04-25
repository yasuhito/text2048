Feature: Move right
  Scenario: Move empty board
    Given a board:
    """
    _ _ _ _
    _ _ _ _
    _ _ _ _
    _ _ _ _
    """
    When I move the board to the right
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
    2 _ _ _
    _ 2 _ _
    _ _ 2 _
    _ _ _ 2
    """
    When I move the board to the right
    Then the board is:
    """
    _ _ _ 2
    _ _ _ 2
    _ _ _ 2
    _ _ _ 2
    """

  Scenario: Merge numbers
    Given a board:
    """
    2 _ 2 _
    _ 2 _ _
    _ 2 _ 2
    _ _ _ 2
    """
    When I move the board to the right
    Then the board is:
    """
    _ _ _ 4
    _ _ _ 2
    _ _ _ 4
    _ _ _ 2
    """

  Scenario: Move and merge mix of numbers
    Given a board:
    """
    4 _ 2 _
    _ 2 _ 2
    _ 2 _ 4
    _ _ _ 2
    """
    When I move the board to the right
    Then the board is:
    """
    _ _ 4 2
    _ _ _ 4
    _ _ 2 4
    _ _ _ 2
    """
