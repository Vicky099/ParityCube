#!/usr/bin/env puma

shared_path = "/home/hovancik/apps/ParityCube/shared"
environment ENV['RAILS_ENV'] || 'production'

#daemonize true

pidfile "#{shared_path}/tmp/pids/puma.pid"

stdout_redirect "#{shared_path}/tmp/log/stdout", "#{shared_path}/tmp/log/stderr"

threads 0, 8

bind "unix://#{shared_path}/tmp/parity_cube.sock"

activate_control_app