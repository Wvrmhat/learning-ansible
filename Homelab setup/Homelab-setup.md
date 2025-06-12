# Setting up the home lab 

```
docker build -t ssh-dind . 
docker network create --subnet=172.20.0.0/16 ansible_net 
docker network ls 

docker run -d --name server1 --net ansible_net --ip 172.20.0.11 -p 2221:22 ansible-lab 
docker run -d --name server2 --net ansible_net --ip 172.20.0.12 -p 2222:22 ansible-lab 
docker run -d --name server3 --net ansible_net --ip 172.20.0.13 -p 2223:22 ansible-lab

docker ps -a 	(checks if containers are running) 
```

## Generating the SSH keys for each server 

```
ssh-keygen -t ed25519 -C "ansible" 		(with filepath as "home/user/.ssh/ansible")

ssh-copy-id -i ~/.ssh/ansible.pub -p 2221 ansible@localhost
ssh-copy-id -i ~/.ssh/ansible.pub -p 2222 ansible@localhost 
ssh-copy-id -i ~/.ssh/ansible.pub -p 2223 ansible@localhost 
```

- password is **ansible** for accessing each container
 

## Cleaning up nodes 

For removing nodes when done or if it fails to start

```
docker logs <name of node> 
docker rm server1 server2 server3 
```