# encoding: utf-8

require 'text2048'

describe Text2048::CursesView::LCD do
  describe '#render' do
    Given(:result) { Text2048::CursesView::LCD.new.render(number) }

    context 'with 2' do
      When(:number) { 2 }
      Then do
        result ==
          " - \n"\
          "  |\n"\
          " - \n"\
          "|  \n"\
          ' - '
      end
    end

    context 'with 4' do
      When(:number) { 4 }
      Then do
        result ==
          "   \n"\
          "| |\n"\
          " - \n"\
          "  |\n"\
          '   '
      end
    end

    context 'with 8' do
      When(:number) { 8 }
      Then do
        result ==
          " - \n"\
          "| |\n"\
          " - \n"\
          "| |\n"\
          ' - '
      end
    end

    context 'with 16' do
      When(:number) { 16 }
      Then do
        result ==
          "     - \n"\
          "  | |  \n"\
          "     - \n"\
          "  | | |\n"\
          '     - '
      end
    end

    context 'with 32' do
      When(:number) { 32 }
      Then do
        result ==
          " -   - \n"\
          "  |   |\n"\
          " -   - \n"\
          "  | |  \n"\
          ' -   - '
      end
    end

    context 'with 64' do
      When(:number) { 64 }
      Then do
        result ==
          " -     \n"\
          "|   | |\n"\
          " -   - \n"\
          "| |   |\n"\
          ' -     '
      end
    end

    context 'with 128' do
      When(:number) { 128 }
      Then do
        result ==
          "     -   - \n"\
          "  |   | | |\n"\
          "     -   - \n"\
          "  | |   | |\n"\
          '     -   - '
      end
    end

    context 'with 256' do
      When(:number) { 256 }
      Then do
        result ==
          " -   -   - \n"\
          "  | |   |  \n"\
          " -   -   - \n"\
          "|     | | |\n"\
          ' -   -   - '
      end
    end

    context 'with 512' do
      When(:number) { 512 }
      Then do
        result ==
          " -       - \n"\
          "|     |   |\n"\
          " -       - \n"\
          "  |   | |  \n"\
          ' -       - '
      end
    end

    context 'with 1024' do
      When(:number) { 1024 }
      Then do
        result ==
          "     -   -     \n"\
          "  | | |   | | |\n"\
          "         -   - \n"\
          "  | | | |     |\n"\
          '     -   -     '
      end
    end

    context 'with 2048' do
      When(:number) { 2048 }
      Then do
        result ==
          " -   -       - \n"\
          "  | | | | | | |\n"\
          " -       -   - \n"\
          "|   | |   | | |\n"\
          ' -   -       - '
      end
    end
  end
end
