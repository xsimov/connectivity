require 'client'

class ConnectionDiagnostic
  # perform_diagnostic
  # disconnects the client
  # tries to connect the client 3 times
  # if unsuccessful raise Error
  # if successful sends 'AT#UD' to client (diagnostic message)
  #   and receives from the client
end