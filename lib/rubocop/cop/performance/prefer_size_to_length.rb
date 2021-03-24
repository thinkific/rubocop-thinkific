# frozen_string_literal: true

module RuboCop
  module Cop
    module Performance
      # Warns when calling #length when we could use #size
      #
      # @example
      #
      #   # bad
      #   User.length
      #
      #   # bad
      #   users = User.where(cool: true)
      #   users.length
      #
      #   # good
      #   User.size
      #
      #   # good
      #   users = User.where(cool: true)
      #   users.size
      #
      class PreferSizeToLength < Cop
        MSG = <<~MSG.tr("\n", ' ')[0..-2]
          For objects inheriting from ActiveRecord::Collection::Relation,
          use #size instead of #length'
        MSG

        def_node_matcher :ends_with_length?, <<~PATTERN
          (send $_ :length)
        PATTERN

        def_node_matcher :send_with_length?, <<~PATTERN
          (send $_ :send (sym :length))
        PATTERN

        def on_send(node)
          return unless ends_with_length?(node) || send_with_length?(node)

          add_offense(node)
        end
      end
    end
  end
end
