require_dependency "simple_chat/application_controller"
require_dependency "redis"

module SimpleChat
  class MessagesController < ApplicationController
    layout false
    include ActionController::Live
    def send_message
      logger.info "############# SEND_MESSGE"
      response.headers["Content-Type"] = "text/javascript"
      @message = { name: params[:name], content: params[:content], font: params[:font]  }
      logger.info "publishing to room: " + "messages_" + params[:room_id].to_s
      $redis.publish("#{"messages_" + params[:room_id].to_s }.chat", @message.to_json)
    end

    def events

      redis = Redis.new

      logger.info "subscribing to: heartbeat #{'messages_' + params[:room_id].to_s }.*"
      response.headers["Content-Type"] = "text/event-stream"

      redis.psubscribe(["heartbeat","#{'messages_' + params[:room_id].to_s }.*"]) do |on|
        on.pmessage do |pattern, event, data|
          logger.info  "pattern: " + pattern + ' event: ' + event + '  data: ' + data;
          if event.eql? "heartbeat"
            logger.info 'Received Heartbeat.  Testing Channel'
            response.stream.write("event: heartbeat\n")
          else
            logger.info 'writing to stream'
            response.stream.write("event: #{event}\n")
            response.stream.write("data: #{data}\n\n")
          end
        end
      end
    rescue IOError
      logger.info "Stream closed"
      stream_error = true;
    ensure
      logger.info "Events action is quitting redis and closing stream!"
      redis.quit
      response.stream.close
      end
  end

  private

  def message_params
    params.require(:message).permit(:content, :name, :room_id, :font)
  end

end

