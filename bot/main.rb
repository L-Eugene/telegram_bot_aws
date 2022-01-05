require 'telegram/bot'
require 'json'

SUCCESS_RESULT = { statusCode: 200 }

def message_handler(event:, context:)
  begin
    update = Telegram::Bot::Types::Update.new(JSON.parse event['body'])
  rescue JSON::ParserError => e
    puts "Broken update structure", e.message, event['body']
  end
  
  return SUCCESS_RESULT if update&.message&.text.nil?

  telegram = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
  telegram.api.send_message(chat_id: update.message.chat.id, text: update.message.text)

  SUCCESS_RESULT
end
