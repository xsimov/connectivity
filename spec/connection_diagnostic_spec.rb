require 'spec_helper'

describe ConnectionDiagnostic do

  context 'the perform diagnostic method' do

    before(:each) do
      @client = double("Client")
      allow(@client).to receive(:disconnect)
      allow(@client).to receive(:connect).with("any non-empty str").and_return(true)
      @connection = ConnectionDiagnostic.new(@client)
    end

    it "disconnects the client" do
      expect(@client).to receive(:disconnect)
      @connection.perform_diagnostic
    end

    it "tries to connect the client" do
      expect(@client).to receive(:connect).once
      @connection.perform_diagnostic
    end

    it "retries connection if unsuccessful" do
      allow(@client).to receive(:connect).with("any non-empty str").and_return(false, true)
      expect(@client).to receive(:connect).twice
      @connection.perform_diagnostic
    end

    it "retries connection maximum 3 times" do
      allow(@client).to receive(:connect).with("any non-empty str").and_return(false, false, false)
      expect(@client).to receive(:connect).exactly(3).times
      @connection.perform_diagnostic
    end

    it "raises an error if unsuccessful connection" do
      allow(@client).to receive(:connect).with("any non-empty str").and_return(false, false, false)
      expect(@connection.perform_diagnostic).to raise_error("Could'nt connect!")
    end

  end

end