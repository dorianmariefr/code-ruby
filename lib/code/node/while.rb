# frozen_string_literal: true

class Code
  class Node
    class While < Node
      WHILE_KEYWORD = "while"
      UNTIL_KEYWORD = "until"

      def initialize(parsed)
        @operator = parsed.delete(:operator)
        @statement = Node::Statement.new(parsed.delete(:statement))
        @body = Node::Code.new(parsed.delete(:body))
        super(parsed)
      end

      def evaluate(**args)
        if @operator == WHILE_KEYWORD
          last = ::Code::Object::Nothing.new

          last = @body.evaluate(**args) while @statement.evaluate(
            **args
          ).truthy?

          last
        elsif @operator == UNTIL_KEYWORD
          last = ::Code::Object::Nothing.new

          last = @body.evaluate(**args) while @statement.evaluate(**args).falsy?

          last
        else
          raise NotImplementedError, @operator
        end
      end
    end
  end
end
