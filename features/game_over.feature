Feature: Game Over
  Scenario: Game Over
    When a board:
    """
     2  4  8  16
     4  8 16  32
     8 16 32  64
    16 32 64 128
    """
    Then it is game over
