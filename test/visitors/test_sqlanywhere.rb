require 'helper'

module Arel
  module Visitors
    describe "the sqlanywhere visitor" do
      before do
        @visitor = SQLAnywhere.new Table.engine.connection
      end
    end
  end
end
