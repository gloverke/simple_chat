require_dependency "simple_chat/application_controller"
require_dependency "redis"

module SimpleChat
  class MessagesController < ApplicationController
    layout false
    include ActionController::Live
    def send_message
      response.headers["Content-Type"] = "text/javascript"
      @message = { name: params[:name], content: params[:content], font: params[:font]  }
      logger.info "publishing to room: " + "messages_" + params[:room_id].to_s 
      $redis.publish("#{"messages_" + params[:room_id].to_s }.chat", @message.to_json)
    end

    def events
      response.headers["Content-Type"] = "text/event-stream"
      redis = Redis.new
      redis.psubscribe("#{"messages_" + params[:room_id].to_s }.*") do |on|
        on.pmessage do |pattern, event, data|
          logger.info 'pattern: ' + pattern  + ' e: ' + event + ' d: ' + data
          if event == 'heardbeat'
            response.stream.write("event: heartbeat\ndata: heartbeat\n\n")
          else
            logger.info 'writing to stream'
            response.stream.write("event: #{event}\n")
            response.stream.write("data: #{data}\n\n")
          end
        end
      end
    rescue IOError
      logger.info "Stream Closed"
    ensure
      logger.info "Stopping Stream Thread"
      redis.quit
      response.stream.close
      end
  end

  private

  def message_params
    params.require(:message).permit(:content, :name, :room_id, :font)
  end

end

