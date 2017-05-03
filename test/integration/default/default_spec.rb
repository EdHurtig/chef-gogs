puts "Waiting a bit for gogs to start"
sleep 5

describe port(8080) do
  it { should be_listening }
end
