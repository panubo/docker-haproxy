#!/usr/bin/env bash

exec s6-svc -2 /etc/s6/haproxy
