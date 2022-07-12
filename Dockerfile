FROM ubuntu

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y tcl

RUN apt -y install curl
RUN apt -y install default-jre ruby-dev build-essential
RUN apt -y install ruby wget
RUN wget https://github.com/riemann/riemann/releases/download/0.3.8/riemann_0.3.8_all.deb
RUN dpkg -i riemann_0.3.8_all.deb
RUN apt -y install python3-pip
RUN pip install psutil
RUN pip install riemann-client

RUN apt -y install parallel
RUN gem install riemann-client riemann-tools riemann-dash

COPY script.sh script.sh
COPY config.rb config.rb
COPY riemann-mon.py riemann-mon.py
RUN chmod +x script.sh
RUN chmod +x riemann-mon.py
RUN chmod +x config.rb

EXPOSE 80 5555 5556 3000

CMD [ "./script.sh" ]
