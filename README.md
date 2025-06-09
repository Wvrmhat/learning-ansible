# learning-ansible

Anisble is Python-based and agentless. Agentless meaning no additional client is needed to use, it connects over ssh and runs commands. 
It allows a central point for managing multiple servers through the use of config files. 

- Owned by RedHat
- Is Free
- Uses SSH to run commands 
- Can run on Cisco IOS, Azure, Windows machines and AWS for managing infrastructure
- Is open-source similar to CentOS (free-distro from RedHat)
- Is a **push model** as it pushes configurations and commands 

## Playbook

A playbook contains plays, each with their own tasks. This is a YAML file.

- Tasks consist of modules, which are small programs that define the state we want our servers to be in. 