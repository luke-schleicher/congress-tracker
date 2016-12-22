module ApplicationHelper
  def join_messages(messages)
    messages = messages.join('; ') if messages.is_a? Array
    messages
  end
end
