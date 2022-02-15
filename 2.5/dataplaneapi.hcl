dataplaneapi {
  host = "0.0.0.0"
  port = 5555

  user "admin" {
    insecure = true
    password = "adminpwd"
  }

  transaction {
    transaction_dir = "/tmp/haproxy"
  }

  resources {
    maps_dir      = "/usr/local/etc/haproxy/maps"
    ssl_certs_dir = "/usr/local/etc/haproxy/ssl"
    spoe_dir      = "/usr/local/etc/haproxy/spoe"
  }
}

haproxy {
  config_file = "/usr/local/etc/haproxy/haproxy.cfg"
  haproxy_bin = "/usr/local/sbin/haproxy"

  reload {
    reload_cmd   = "/reload"
    restart_cmd  = "/reload"
    reload_delay = "5"
  }
}

# --host 0.0.0.0 --port 5555 --haproxy-bin /usr/local/sbin/haproxy --config-file /usr/local/etc/haproxy/haproxy.cfg --reload-cmd "/reload" --reload-delay 5 --userlist api
