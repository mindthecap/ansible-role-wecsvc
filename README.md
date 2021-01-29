Role Name
=========

An ansible role for deploying WEF (Windows Event Forwarding) on scale and with central subscription and query management. It enhances Palantirs "Windows Event Forwarding" query repo (https://github.com/palantir/windows-event-forwarding).

Requirements
------------

Palantir rules folder must exist in wecsv_palantir_query location. By default git clone https://github.com/palantir/windows-event-forwarding files/palantir does the trick.

Before running the role, query file templating is done by using template.sh. Run it from the role folder (assuming you have cloned the repo to default location).

Role Variables
--------------

Variables are listed below, along with default values.

    # This is for testing only
    ansible_hostname: "127.0.0.1"
    wecsvc_events_maxsize: 10737418240

    wecsv_palantir_query: ./files/palantir/wef-subscriptions
    # can't use variables right
    wecsvc_service_started: false

    template_dst: "/tmp"
    # Because of reasons, templating fragment query id is like a ansible variable
    query_count: "query_count"

These are subscription (wecutil) defaults

    wecsvc_batching_items: 5
    wecsvc_batching_latency: 300000
    wecsvc_read_existing: false
    wecsvc_heartbeat_interval: 900000
  
Where to copy templates (this folder is created, if missing)

    template_dst: "C:\Subscriptions"



You can have multiple subscriptions (per host) and put different computers as source.
Create required Subscriptions based on file names under ./files (.xml is ommitted here)

    # This is example of subscriptions
    wecsvc_subscription:
      - wecsv_subscription_name: "Example"
        subscriptions:
          - ADFS
          - Wireless
          - Firewall
        wecsvc_source_domain_computers:
          - "(A;;GA;;;NS)"
          - "(A;;GA;;;DC)"
          - "(A;;GA;;;DD)"
      - wecsv_subscription_name: "Smaller Example"
        subscriptions:
          - ADFS
        wecsvc_source_domain_computers:
          - "(A;;GA;;;DD)"


Dependencies
------------

None.

Example Playbook
----------------

Create /etc/ansible/tasks/wefc.yml:

    - hosts: win_servers
      roles:
         - win_wecsvc

For installation

    ansible-playbook /etc/ansible/tasks/wefc.yml --tags wecsvc_install,all
    
License
-------

BSD
