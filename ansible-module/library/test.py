#!/usr/bin/python
# -*- coding: utf-8 -*-
from ansible.module_utils.basic import *
def main():
    fields = {
        "name": {
            "default": "unkown",
            "type": "str"
        },
        "attack": {
            "default": [],
            
            "type": "list"
        }
    }
    module = AnsibleModule(argument_spec=fields)
    # Logique metier pour analyse du la liste des sites web
    module.exit_json(changed=True,meta={"result" : "Our first module"})
main()