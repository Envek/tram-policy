class Tram::Policy
  # An exception to be risen by [Tram::Policy#validate!]
  class ValidationError < RuntimeError
    # Policy object whose validation has caused the exception
    #
    # @return [Tram::Policy]
    #
    attr_reader :policy

    private

    def initialize(policy, filter)
      @policy  = policy
      messages = policy.errors.to_a.reject(&filter).map(&:message)
      super (["Validation failed with errors:"] + messages).join("\n- ")
    end
  end
end
