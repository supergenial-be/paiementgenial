require 'notion_ruby_client'

class NotionClient
  def initialize
    @client = Notion::Client.new(token: ENV['NOTION_API_KEY'])
  end

  # Method to retrieve event details
  def get_event_details(event_id)
    @client.page.retrieve(event_id)
  end

  # Method to update properties in Notion
  def update_registration(registration_id, properties)
    @client.page.update(registration_id, properties: properties)
  end

  def update_event(event_id, properties)
    @client.page.update(event_id, properties: properties)
  end

  # Add more methods as needed
end