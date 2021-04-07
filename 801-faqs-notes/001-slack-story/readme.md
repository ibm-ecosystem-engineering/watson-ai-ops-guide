# Slack story related faqs

## 1. Events are shown as Slack Story in another channel


### Tags

Slack Story, Event Manager, XML Gateway


### Problem

The events are pushed to event manager, the slack story is created. But it is going to the a old channel, not going to new channel.

### Solution

`XML Gateway` was configured to point to the old channel. Need to point to the new Channel.

1. Open the config-map `noi-noi-aimgr-gateway-config`. 

2. There should be a text with `topics` like `"topics": "alerts-noi-vmsvhjhj-jhu6whpx"`.

3. Replace that with appropriate topics that to be pointed.

4. Goto the deployment `noi-noi-aimgr-gateway` and scale down and up the pod for restart

