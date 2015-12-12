require 'mongo'
require 'pp'
require File.expand_path("#{File.dirname(__FILE__)}/../zabbixDL/zabbix_dal")
include Mongo


class MonfigDal

  def initialize(zabbixHost,
                 zabbixUser = 'admin',
                 zabbixPassword = 'zabbix',
                 mongoHost,
                 mongoPort = 27017,
                 puppetHost,
                 puppetEnvName,
                 puppetEnvFullPath = '/etc/puppetlabs/code/environments/',
                 configFilesDir)

    @zabbixHost = zabbixHost
    @mongoHost = mongoHost
    @puppetHost = puppetHost
    @configFilesDir = puppetEnvFullPath + puppetEnvName + configFilesDir

    @zbxDl = ZabbixDal.new(zabbixHost, zabbixUser, zabbixPassword)

    @mongoConn = Mongo::Client.new(["#{mongoHost}:#{mongoPort}"], :ssl => false)

  end

  def attachConfigToHostgroup(configFile, configParams, hostgroupname)

  end

  def detachConfigFromHostgroup(configFile, hostgroupname)

  end

  def createHostgroup(hostgroupname)

    if @zbxDl.createHostgroup(hostgroupname)
      #inform puppetMgr accordingly
    end

  end

  def createHost(hostaddr, groupname)
    if @zbxDl.createHost(hostaddr, groupname)
    end
  end

  def removeHostgroup(hostgroupname)
  end

  def removeHost(hostaddr)
  end

end

md = MonfigDal.new(
    zabbixHost = 'centos-zabbix',
    mongoHost = 'centos-mongodb',
    puppetHost = 'centos-puppetmaster',
    puppetEnvName = 'subxlintest',
    configFilesDir = 'manifests/classes')
