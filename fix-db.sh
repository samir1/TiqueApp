#!/bin/sh
rake db:drop
rake db:create
rake db:migrate --trace
rake db:seed --trace
