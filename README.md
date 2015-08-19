AWS-EC2-Instance-Store-Raid0-Script
===
What is EC2-Instance-Store?
* AWS EC2 instance provide instance store but they are temporary block-level storage.
If you stop ec2 instance and start your instance again, you'll find your data in instance storage may be lost.
If you want to prevent this, you should better use EBS storage.

When do I need EC2 instance store?
* This storage can be used in many puproses such as temporary space or buffer. For example, I can put data in this storage while processing or parsing large data.

Why do I need this script?
* AWS EC2 instance store only mount 1 disk storage. But some EC2 instance type provide multiple SSD instance storage, such as c3.xlarge provide 2 x 40 GB. Via this script, it can help to combine multiple storages to same mounting points by RAID0 architecture.

How to use this script?
<font color="Red">TBD</font>