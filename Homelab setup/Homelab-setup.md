# Setting up the home lab 

- Image is build from dockerfile initially
- A bridge-network is also made called ansible_net for the servers 

```
docker build -t ansible-lab .
docker network create --subnet=172.20.0.0/16 ansible_net 
docker network ls 
```
- Setting up the nodes/servers on the bridge network 

```
docker run -d --name server1 --net ansible_net --ip 172.20.0.11 -p 2221:22 ansible-lab 
docker run -d --name server2 --net ansible_net --ip 172.20.0.12 -p 2222:22 ansible-lab 
docker run -d --name server3 --net ansible_net --ip 172.20.0.13 -p 2223:22 ansible-lab

docker ps -a 	(checks if containers are running) 
```

- Setting up the master node
- adding a volume for peristant data and to access inventory 

```
docker run -d --name master --network ansible_net --ip 172.20.0.14 -v ~/learning-ansible:/ansible ansible-lab	

docker exec -it master sh
apk add ansible 
```

## Generating the SSH keys for each server 

```
ssh-keygen -t ed25519 -C "ansible" 		(with filepath as "home/user/.ssh/ansible")

ssh-copy-id -i ~/.ssh/ansible.pub -p 2221 ansible@localhost
ssh-copy-id -i ~/.ssh/ansible.pub -p 2222 ansible@localhost 
ssh-copy-id -i ~/.ssh/ansible.pub -p 2223 ansible@localhost 

or
ssh -p 2221 ansible@localhost
```

- password is **ansible** for accessing each container


## Pinging servers for connectivity 

- then to copy the private and ansible key to the master node 
- also it is important to test connectivity while on the bridge-network 
- it is only possible to ping the servers within the master on the bridge network since docker isolates the host from the running containers 

```
docker cp /home/user/.ssh/ansible master:/root/.ssh/ansible		(where user is the user name)
docker exec -it master sh
ansible all -i inventory -m ping		(once in ansible directory) 
```

## Cleaning up nodes 

For removing nodes when done or if it fails to start

```
docker logs <name of node> 
docker rm server1 server2 server3 
```
