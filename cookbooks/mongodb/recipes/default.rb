directory '/storage/mongodb/db' do
  action     :create
  recursive  true
  owner      'docker'
  group      'docker'
end
