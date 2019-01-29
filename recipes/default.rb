#
# Cookbook:: passenger_config
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

bash 'update_nginx_passenger_conf' do
  cwd '/etc/nginx/'
  code <<-CONF
    total_mem_kib=$(sed -nr '/^MemTotal:/s/.*\b([0-9]+).*/\1/p' /proc/meminfo)
    proc_size_kib=$(( 250 * 1024 ))
    proc_count=$(( ( total_mem_kib + proc_size_kib / 2 ) / proc_size_kib ))
    min_inst=$(( proc_count - 1 ))
    sed -i "s/passenger_max_pool_size.*/passenger_max_pool_size $proc_count;/" nginx.conf
    sed -i "s/passenger_min_instances.*/passenger_min_instances $min_inst;/" nginx.conf
  CONF
