#!/usr/bin/bash
import time
import psutil
import riemann_client.client
from riemann_client.transport import TCPTransport

def send_event():
    load = psutil.cpu_percent(percpu=False)
    with riemann_client.client.Client(TCPTransport("localhost", 5555)) as client:
        if load < 70:
            client.event(host="localhost", service="avg_server_load", state="ok", metric_f=load)
        if load > 70 and load < 90:
            client.event(host="localhost", service="avg_server_load", state="warning", metric_f=load)
        if load > 90:
            client.event(host="localhost", service="avg_server_load", state="critical", metric_f=load)

if __name__ == "__main__":
    while True:
        send_event()
        time.sleep(10)
