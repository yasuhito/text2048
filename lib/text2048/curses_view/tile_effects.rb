# encoding: utf-8

require 'curses'

# This module smells of :reek:UncommunicativeModuleName
module Text2048
  class CursesView
    # Curses tile effects
    module TileEffects
      include Curses

      def pop_tiles(list)
        [:pop, :draw_box].each do |each|
          list_do each, list
          refresh
          sleep 0.1
        end
        draw_message
      end

      def zoom_tiles(list)
        [:fill_black, :draw_number, :show].each do |each|
          list_do each, list
          refresh
          sleep 0.05
        end
        draw_message
      end

      private

      def list_do(name, list)
        list.each { |each| @tiles[each].__send__ name }
      end
    end
  end
end
