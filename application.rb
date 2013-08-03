class App < Sinatra::Base

	$config = YAML.load_file('application.yml')

	# Loadind all aws modules into aws folder
	Dir["./aws/*.rb"].map do |path|
  	load path
	end

	#### One example to configure your service
	# def ec2_private_address id
	# 	parameters = {
	# 		'InstanceId' => id
	# 	}
	# 	instance_info = XmlSimple.xml_in(aws_module('ec2','DescribeInstances',parameters))
	# 	ip = instance_info['reservationSet'][0]['item'][0]['instancesSet'][0]['item'][0]['privateIpAddress'][0]
	# 	ip
	# end

	# get '/ec2/:InstanceId' do
	# 	ec2_private_address "#{params[:InstanceId]}"
	# end
	#### End of example
end
