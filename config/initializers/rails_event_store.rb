require 'rails_event_store'
require 'aggregate_root'
require 'arkency/command_bus'

Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new
  Rails.configuration.command_bus = Arkency::CommandBus.new

  AggregateRoot.configure do |config|
    config.default_event_store = Rails.configuration.event_store
  end

  Rails.configuration.event_store.tap do |store|
    store.subscribe(Posts::OnPostCreated, to: [Posting::PostCreated])
  end

  Rails.configuration.command_bus.tap do |bus|
    bus.register(Posting::CreatePost, Posting::OnCreatePost.new)
  end
end
