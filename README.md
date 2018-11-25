# Orkan Dere - Sinatra Challange
## For the reviewer
### Files explained
* **.dockerignorefile**: Files or patterns for Docker to ignore while building the image
* **Dockerfile**: File for Docker to use while building the image
* **README.md**: This readme file
* **deploySinatra.json**: AWS CloudFormation template to build the stack
### Summary
Using this CloudFormation template provided you will be able to roll out a software stack residing in multiple availability zones. The stack will be created in an auto-scaling group, will create 2 initial instances to maintain high availability and will be able to scale up to 4 instances to maintain the load.
The stack is able to send notifications to the email address provided.
### Requirements
* Basic AWS knowledge.
* An AWS account with admin privileges. 
* A "key pair" created from AWS EC2 Dashboard to provide CloudFormation configuration during the deployment. See [this link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair) if you don't know how to create one.
* A VPC, minimum 2, preferably 3 subnets that can connect to the internet.
### Instructions
* Please start with copying the contents of [deploySinatra.json](https://raw.githubusercontent.com/od-reagroup/od-rea-sinatra/master/deploySinatra.json) into a file on your local drive and use the same name for the file.
* Log in to your AWS console and switch the region to **Asia Pacific (Sydney)**. We will create all the resources in this region.
* Select **CloudFormation** (under *Management*) from *Services* (above)
* Click "**Create New Stack**"
* Select "**Upload a template to Amazon S3**", click "**Choose file**", supply "**deploySinatra.json**" and click "**Next**"
* On the "**Specify Details**" page:
    - **Stack Name**: Give your stack a name
    - **InstanceType**: Default is *t2.micro* to avoid costs on free-tier accounts. Please select if you do not want to use t2.micro.
    - **KeyName**: Select the *key pair name* you previously created.
    - **OperatorEmail**: Please provide the email address you want to receive the notifications to.
    - **Subnets**: Please select at least 2, preferably 3 subnets.
    - **VpcId**: Please select the correct VPC for your subnets.
* Click "**Next**"
* Everything on the "**Options**" page is optional so you can just click "**Next**"
* Review your deployment and click "**Create**"
* Use the "**Refresh**" button on the top right to refresh the status of the deployment
* When you see "**CREATE_COMPLETE**" in the *Status* section for the stack please change to "**Outputs**" page from the "**Events**" page you are currently viewing.
* Click the URL visible under the "**Value**" column. This is the URL to your load balancer.
### Warning on SSH access to the instances
The ssh access is NOT configured on security groups intentionally, for security purposes. In case you need to SSH into the EC2 instances created, you first need to [add a new rule to the security group](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/authorizing-access-to-an-instance.html#add-rule-authorize-access) that's attached to your instances and restrict it only to your IP (by selecting "**My IP**" as the source) and then follow [this document](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html) on "how to ssh". Please remember, the ".pem" file mentioned is the one you saved while creating your key pair.

## Explanation of assumptions and design choices
* **Docker Containers**: Docker provides us with the capability to be able to run an application without the dependence on the operating system's software requirements. We can define our Ruby version for our code to run and the changes in the underlying system won't affect our application. The developer's desktop operating system may vary and still our docker containers will act the same on all environments it's run. This will make the testing and deployment processes consistent within each other and will save everybody time with the whole process.
* **AWS and CloudFormation**: I preferred AWS over other hosting solutions because of the practicality it provides us with deployment, high-availability and scalability. CloudFormation provides us with the capability to automate the deployments and make them foolproof while decreasing the time for manual deployments and potential mistakes that can be made during this process.
* **Highly available and scalable infrastructure**: I built the software stack to be highly available and scalable so it will both be resilient and cost-efficient at the same time.
### The "Why"s
* **Why Docker?**
Basically because it frees us from the environment bound limitations. To be able to run the exact same environment on every underlying OS means less time spent on troubleshooting, less time spent on the test. This leads us to better results while deploying because there will be no surprises.
* **Why AWS?**
Because AWS is the trendsetter for the cloud. Currently, they're leading the new ideas and products in the cloud. They changed the way development and deployments are done. It's better than any classic hosting solution and better than it's cloud competitors.
* **Why CloudFormation?**
Mainly because it's easy to use. There are many different tools out there to get this done in various different ways. If I need to name a few Terraform, Kubernetes or Ansible might be good examples to get this environment created and deployed. Using CloudFormation gives us the advantage of being able to deploy this stack using a tablet without any need for command line knowledge or tools.
* **Why Amazon Linux AMI?**
Because it's native to the environment. I was trying to use as many AWS native solutions as possible.
### The Trade Offs
* AWS is an environment of its own and requires a basic level of knowledge to start using. 
* Using Docker containers is an extra layer of work compared to deploying this solution directly on a single Linux server or using an ElasticBeanstalk environment. This may seem like a trade-off but the time spent will pay for itself in the long run. The real trade-off would have been using any other system and to get the job done quicker than it is now.
* CloudFormation is an environment bound solution and we cannot use this template anywhere else. Still the simplicity it offers us while deploying the environment was the reason behind my preference.
### Final Notes
I know there're other ways of deploying this application, still using AWS and CloudFormation, such as using ECS instead of doing it through EC2 instances. I preferred using EC2 instances over ECS because I'm more comfortable this way and no other reason.