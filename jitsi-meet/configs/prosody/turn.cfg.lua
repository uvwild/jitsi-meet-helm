-- /defaults/conf.d/turn.cfg.lua
turncredentials_secret = "{{ .Env.TURN_AUTH_PASSWORD | default 'uebersafe' }}"

turncredentials = {
  { type = "turn", host = "{{ .Env.TURN_HOST }}", port = "{{ .Env.TURN_PORT }}", transport = "udp" },
  { type = "turns", host = "{{ .Env.TURN_HOST }}", port = "{{ .Env.TURNS_PORT }}", transport = "tcp" }
};

