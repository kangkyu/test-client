namespace :lightspark do
  desc "Dump GraphQL schema"
  task :schema_dump => :environment do
    GraphQL::Client.dump_schema(Lightspark::HTTP, "schema.json")
  end
end
