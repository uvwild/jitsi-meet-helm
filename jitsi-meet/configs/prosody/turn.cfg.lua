-- /defaults/conf.d/turn.cfg.lua
turncredentials_secret = "{{ .Env.TURN_AUTH_PASSWORD | default 'uebersafe' }}"

turncredentials = {
  { type = "turn", host = "{{ .Env.TURN_HOST }}", port = "{{ .Env.TURN_PORT }}", transport = "udp" },
  { type = "turns", host = "{{ .Env.TURN_HOST }}", port = "{{ .Env.TURNS_PORT }}", transport = "tcp" }
};


turncredentialsssssss = {
    { 
    	type = "stun", 
    	host = "{{ .Env.TURN_HOST }}", 
    	port = "{{ .Env.TURN_TCP_PORT }}" 
    },
    { 	type = "turn", 
    	host = "{{ .Env.TURN_HOST }}", 
    	port = "{{ .Env.TURN_UDP_PORT }}", 
    	transport = "udp"
    },
    { 
    	type = "turns", 
    	host = "{{ .Env.TURN_HOST }}", 
        port = "{{ .Env.TURN_TLS_PORT }}", 
		transport = "tcp" 
	}
}
