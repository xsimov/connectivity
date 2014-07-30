require 'client'

class ConnectionDiagnostic

  def initialize(client)
    @client = client
  end

  def perform_diagnostic
    @client.disconnect
    status = client_connection
  end

  def client_connection(times_tried = 0)
    this_iteration = @client.connect("any non-empty str")
    return (client_connection(times_tried + 1)) unless (this_iteration || times_tried == 2)
    this_iteration
  end

  # perform_diagnostic
  # disconnects the client
  # tries to connect the client 3 times
  #   if unsuccessful raise Error
  #   if successful sends 'AT#UD' to client (diagnostic message)
  #     and receives from the client the diagnostic info
  #     this info should be accesible on the attribute info

end