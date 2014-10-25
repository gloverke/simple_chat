require_dependency "simple_chat/application_controller"
require_dependency "redis"

module SimpleChat
  class MessagesController < ApplicationController
    layout false
    include ActionController::Live
    def send_message
      response.headers["Content-Type"] = "text/javascript"
      @message = { name: current_user.name, content: params[:content], font: params[:font] , user_id: current_user.id }
      $redis.publish("#{"messages_" + params[:room_id].to_s }.chat", @message.to_json)
    end

    def events

      response.headers["Content-Type"] = "text/event-stream"

      $redis.psubscribe(["heartbeat","#{'messages_' + params[:room_id].to_s }.*"]) do |on|
        on.pmessage do |pattern, event, data|
          if event.eql? "heartbeat"
            response.stream.write("event: heartbeat\n")
          else
            response.stream.write("event: #{event}\n")
            response.stream.write("data: #{data}\n\n")
          end
        end
      end
    rescue IOError
      stream_error = true;
    ensure
      response.stream.close
      end
  end

  private

  def message_params
    params.require(:message).permit(:content, :name, :room_id, :font)
  end

end

