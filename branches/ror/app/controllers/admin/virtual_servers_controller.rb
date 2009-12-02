class Admin::VirtualServersController < ApplicationController
  
  def list_data
    hardware_server = HardwareServer.find_by_id(params[:hardware_server_id])
    virtual_servers = hardware_server.virtual_servers
    virtual_servers.map! { |item| {
      :id => item.id,
      :identity => item.identity,
      :ip_address => item.ip_address,
      :host_name => item.host_name,
      :state => item.state,
      :os_template_name => item.os_template.name
    }}
    render :json => { :data => virtual_servers }  
  end
  
  def change_state    
    params[:ids].split(',').each { |id|
      virtual_server = VirtualServer.find_by_id(id)
      
      case params[:command]  
        when 'start' then virtual_server.start
        when 'stop' then virtual_server.stop
        when 'restart' then virtual_server.restart
      end
    }
    
    render :json => { :success => true }  
  end
  
end
