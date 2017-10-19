module Sequel
  module Postgres
    module SchemaDataMethods

      def dump_schema_data(schema, path, options={})
        FileUtils.rm_rf path
        FileUtils.mkpath path

        tables = self.from(Sequel[:information_schema][:tables])
                     .where(table_schema: schema.to_s, table_type: 'BASE TABLE')
                     .select_map(:table_name)
                     .map(&:to_sym)

        tables = tables - options.fetch(:ignore, [])

        tables.each do |table|
          File.write File.join(path, "#{table}.csv"), copy_table(Sequel.qualify(schema, table), format: :csv)
        end
      end

      def load_schema_data(schema, path)
        transaction do
          Dir[File.join(path, '*.csv')].each do |filename|
            table = File.basename filename, '.csv'
            copy_into Sequel.qualify(schema, table), data: File.read(filename), format: :csv
          end
        end
      end

    end

    Database.register_extension(:pg_schema_data, Postgres::SchemaDataMethods)

  end
end