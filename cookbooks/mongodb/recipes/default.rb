directory '/storage/db' do
	action     :create
	recursive  true
	owner      'docker'
	group      'docker'
end

def add_cmd(cfg, opt, key, value = nil) 
	if not ENV[key].nil?
		cfg['cmd']="#{cfg['cmd']} #{opt}"
		if value == true
			cfg['cmd']="#{cfg['cmd']} #{ENV[key]}"
		end
	end
	cfg
end

cfg = {
	"cmd" => "--httpinterface --rest --directoryperdb --dbpath /storage/db",
	"replSet" => !ENV['replSet'].nil?,
	"repl_members" => []
}
add_cmd(cfg, '--noprealloc', 'noprealloc')
add_cmd(cfg, '--smallfiles', 'nosmallfiles')
add_cmd(cfg, '--replSet', 'replSet', true)

if not ENV['replMembers'].nil?
	cfg['repl_members'] = ENV['replMembers'].split(',').map{|member| 
		if not member.include?(":")
			"#{member}:27017"
		else
			member
		end
	}
end

template '/usr/local/bin/run-mongo.sh' do
	source  'run-mongo.sh.erb'
	mode '0755'
	variables cfg 
	owner   'docker'
	group   'docker'
	action   :create_if_missing
end

