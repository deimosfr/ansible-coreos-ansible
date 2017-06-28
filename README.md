CoreOS Ansible Role
===================

This role install pypy and all requirements to run Ansible on CoreOS.

Role Variables
--------------

```yaml
coreos_ansible_role_path: "{{playbook_dir}}"
coreos_ansible_install_pypy: true
ansible_ssh_user: core
ansible_python_interpreter: "/opt/python/bin/python"
```

Example Playbook
----------------

The repository where pypy is hosted limits the number or parallel downloads. That's why a serial to 1 is set:
```yaml
- name: coreos-ansible
  hosts: coreos
  user: core
  become: yes
  gather_facts: False
  serial: 1
  roles:
    - deimosfr.coreos-ansible
```

On the hosts file, add vars:
```ini
[coreos]
coreos-01
coreos-02
coreos-03

[coreos:vars]
coreos_ansible_role_path: "{{playbook_dir}}"
ansible_ssh_user: core
ansible_python_interpreter: "/opt/python/bin/python"
```

License
-------

GPLv3

Author Information
------------------

Pierre Mavro / deimosfr
