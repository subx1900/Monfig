require 'zabbixapi'

class ZabbixDal

  def initialize(zabbixHost, user, password)
    @zabbixconn = ZabbixApi.connect(
        :url => "http://#{zabbixHost}/zabbix/api_jsonrpc.php",
        :user => user,
        :password => password)
  end

  def createHost(hostaddr, groupname)

    groupid = getHostgroupid(groupname)

    if groupid && !getHostid(hostaddr)
      @zabbixconn.hosts.create(
          :host => hostaddr,
          :interfaces =>
              [
                {
                    :type => 1,
                    :main => 1,
                    :ip => '10.0.0.1',
                    :dns => hostaddr,
                    :port => 10050,
                    :useip => 0
                }
              ],
          :groups => [ :groupid => groupid ]
          )
      return true
    end
    return false
  end

  def createHostgroup(hostgroupname)
    if !getHostgroupid(hostgroupname)
      @zabbixconn.hostgroups.create(:name => hostgroupname)
      return true
    end
    return false
  end

  def getHostgroupid(hostgroupname)
    return @zabbixconn.hostgroups.get_id(:name => hostgroupname)
  end

  def getHostid(hostname)
    return @zabbixconn.hosts.get_id(:host => hostname)
  end

end
