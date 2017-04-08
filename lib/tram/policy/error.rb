module Tram
  class Policy
    class Error
      attr_reader :message, :tags

      def initialize(message, **tags)
        @message = message
        @tags = tags
      end

      def full_message
        { message => tags }
      end

      def to_h
        tags.merge(message: message)
      end

      def ==(another_error)
        return false unless another_error.kind_of? self.class

        messages_are_equal = message == another_error.message
        tags_are_equal = tags == another_error.tags

        messages_are_equal && tags_are_equal
      end

      def respond_to?(method_name)
        tags_include? method_name
      end

      def method_missing(method_name)
        return tags[method_name] if tags_include? method_name
        super
      end

      private

      def tags_include?(tag)
        tags.keys.include? tag
      end
    end
  end
end
