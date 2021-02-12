# /defaults/conf.d/turn.cfg.lua
turncredentials_secret = "{{ .Env.TURN_PASSWORD | default "uebersafe" }}";

turncredentials = {
    { 
    	type = "stun", 
    	host = "{{ .Env.EXTERNAL_IP }}", 
    	port = "{{ .Env.TURN_PORT_MIN }}" 
    },
    { 	type = "turn", 
    	host = "{{ .Env.EXTERNAL_IP }}", 
    	port = "{{ .Env.TURN_PORT_MIN }}", 
    	transport = "udp"
    },
    { 
    	type = "turns", 
    	host = "{{ .Env.TURN_HOST }}", 
	    port = "443", 
		transport = "tcp" 
	}
}