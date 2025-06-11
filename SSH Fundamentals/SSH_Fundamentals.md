# Understanding SSH 

As a sys admin, SSH is used to remotely connect to your servers. **SSH keys** help secure your connection and makes it harder for someone from the outside to break-in  

- OpenSSH is a prerequisite of Ansible 
- Allows connection to each server from the workstation 
- SSH key pairs (with passphrases) is a best practise to make user accounts more secure. Key pairs should also be copied to each server  
- An SSH key is also needed that is specific to Ansible

To ensure OpenSSH is installed on the servers we use: 

```
sudo apt install openssh-server 
```

After installing shh a connection must be made to each server in the homelab

## SSH Key Management 

- To view known hosts and stored ssh keys 
```
ls -la .ssh 
```

Generating an ssh key has its own dedicated command, where the type can also be specified with **-t**. **-C** is used to add a comment 

```
ssh-keygen -t ed25519 -C "home default"  
```
- An optional passphrase can be specified (makes account more secure) when generating the key 

```
ls -la .ssh 	(to view the changes)
cat .ssh/id_ed25519.pub 	(view the public key) 
cat .ssh/id_ed25519 		(view the private key) 
```

## Adding the SSH Key 

Adding an ssh key to a server has its own dedicated command 

```
ssh-copy-id -i ~/.ssh/id_ed25519.pub <ip address of server to copy key to>    
ssh <ip address of server to ssh to> 
```

## Creating an Ansible Key 

```
ssh-keygen -t ed25519 -C "ansible" 
```
Important to specify file path when creating ansible key otherwise it will overwrite the previous key

- when specifying filepath use "**home/user/.ssh/ansible**" 
- also recommended to not include passphrase for this 

To **add** the ansible key we use the same command except its with the anisble filepath

```
ssh-copy-id -i ~/.ssh/ansible <ip address of server to copy key to>   
```
- When using the key we can access servers without a passphrase 

```
ssh -i ~/.ssh/ansible <ip address of server> 
```

When using ssh without specify the key to use, we would have to specify the passphrase but there is a faster way 

## SSH Agent 

This is a process that runs in the background and caches the passphrase so it only needs to be entered once 

```
eval $(ssh-agent) 
ps aux | grep 2362 
ssh-add			(enter the passphrase to be cached) 
``` 

- The agent stops running once the terminal is terminated
- This means it is not permanent so the command needs to be entered again 

## SSH Agent Alias 

An alias is similar to making your own command. This can be used to simplify the eval command

```
alias ssha='eval $(ssh-agent) && ssh-add' 
ssha 
``` 

- Closing the terminal also removes the alias created
- A workaround is editing the **bashrc** file and adding the alias there (ctrl + o to save the file)

```
nano .bashrc
``` 

