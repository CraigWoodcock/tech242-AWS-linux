# what is a VPC

## Virtual Private Cloud

- VPC Resource Map  
![Resource Map](<../../VPC screenshots/Resource-Map.png>)
We can now see from our Resource Map that we have created a VPC with two Subnets, a public and private route table and an internet gateway. The internet gateway handles http traffic and directs it to the public route table wich directs it to the public subnet(the application), the request is then sent to the private subnet (our database), via the private route table.<br><br>


When we create an EC2 Instance on AWS, Our VM's are automatically placed inside a public subnet in a default VPC. This default public VPC is like an apartment inside an apartment block and each room in that apartment would be like a subnet (region/availability zone i.e the Ireland Region has zone 1a, 1b, 1c). All of these rooms, or subnets, are also public. 

In general, Public traffic should be treated as untrustworthy.

So we have a shared room, inside a shared apartment, inside a shared apartment building. everyone has access to every room inside every apartment and so they have access to all your belongings - the belongings here are our VM's.
In an ordinary world, would we allow everyone that cones into our home access to every single room? 
No. For example, when a delivery agent delivers a parcel to your home, you would not allow this person to access your private rooms.

in other words, we have our VM which is in a public subnet so it can be accessed by public traffic, inside a public vpc which can be accessed by public traffic.

Sometimes we need our VM's to be accessible by public traffic, for example when a user needs to access a website, that website needs to be accessible to public traffic.
The website may be connected to a database, but the user of the site doesn't need to be able to access all of the data on the database, only certain bits.
So we need to be able to restrict access to that database by putting it into a private subnet

## How Do We Create Private Subnets custom VPC's

we can create custom VPC's on AWS where we can create subnets and decide what traffic we allow into our VPC by creating an internet gateway and creating route tables.

we can see the full steps to creating and deploying a Two Tier VPC here: [Two Tier VPC](<../Deploying Two Tier VPC/README.md>)
