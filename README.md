Sinatra AWS - API
=================

With SAWS-API you can easily communicate or integrate your services with AWS APIs. It supports all REST AWS APIs including Autoscaling, EC2.

Usage
-----

Clone this repo

    git clone git@github.com:/piripirigoso/saws-api.git
  
Install all GEMs

    bundle install
  
Start it

    rackup
  
Configure
---------

Edit the application.yml and put your aws key id and key secret:

    general:
      aws_user: 'INSERT HERE YOUR AWS KEY'
      aws_pass: 'INSERT HERE YOUR AWS SECRET'
    

Examples
--------

In this example below, you can check the Private IP Address from any Instance.

    def ec2_private_address id
      parameters = {
        'InstanceId' => id
      }
      instance_info = XmlSimple.xml_in(aws_module('ec2','DescribeInstances',parameters))
      ip = instance_info['reservationSet'][0]['item'][0]['instancesSet'][0]['item'][0]['privateIpAddress'][0]
      ip
    end
      
    get '/ec2/:InstanceId' do
      ec2_private_address "#{params[:InstanceId]}"
    end
  
Upon set it, go to http://YOUR_IP:PORT//ec2/YOUR-INSTANCE-ID

Adding new modules
------------------

Imagining you want support S3 API too, it simple.
Edit the aplication.yml and add the following parameters:

    s3:
      api_proto: http
      api_endpoint: s3.us-east-1.amazonaws.com
      api_version: '2013-02-01'
    
And in your application.rb run aws_module('s3','YOURACTION',parameters) as you prefer.
