require 'mongo'
require 'pp'

include Mongo

mongoconn = Mongo::Client.new(['centos6-mongodb:27017'], :ssl => false)

class MonfigDal
end