require 'notion_ruby_client'

class NotionClient
  def initialize
    @client = Notion::Client.new(token: ENV['NOTION_API_KEY'])
  end

  # Method to retrieve event details
  def get_event_details(event_id)
    @client.page(page_id: event_id)
  end

  def get_registration_details(registration_id)
    @client.page(page_id: registration_id)
  end

  def update_registration(database_item_id, properties)
    @client.update_page(page_id: database_item_id, properties: properties)
  end

  def update_event(event_id, properties)
    @client.update_page(page_id: event_id, properties: properties)
  end
end