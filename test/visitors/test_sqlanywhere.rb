require 'helper'

module Arel
  module Visitors
    describe "the sqlanywhere visitor" do
      before do
        @visitor = SQLAnywhere.new Table.engine.connection
        #@table = Arel::Table.new "users"
      end

      it 'limit is top' do
        stmt = Nodes::SelectStatement.new
        stmt.limit = Nodes::Limit.new(10)
        sql = @visitor.accept(stmt)
        sql.must_match /TOP/
      end

      it 'offset is start at' do
        stmt = Nodes::SelectStatement.new
        stmt.offset = Nodes::Offset.new(10)
        sql = @visitor.accept(stmt)
        sql.must_match /START AT/
      end

      it 'offset implies limit' do
        stmt = Nodes::SelectStatement.new
        stmt.offset = Nodes::Offset.new(10)
        sql = @visitor.accept(stmt)
        sql.must_match /TOP/
      end

      it 'limit goes between SELECT and projection' do
        stmt = Nodes::SelectStatement.new
        stmt.limit = Nodes::Limit.new(10)
        stmt.cores.first.projections << Arel::Nodes::SqlLiteral.new('*') 
        sql = @visitor.accept(stmt)
        sql.must_be_like "SELECT TOP 10 *"
      end
    end
  end
end
