FROM ubuntu:trusty
MAINTAINER chris@heisel.org

RUN apt-get update && apt-get install -y \
	build-essential \
	git \
	python \
	python-dev \
	python-setuptools \
	nginx \
	supervisor \
	python-software-properties \
    curl \
    wget

RUN easy_install pip

RUN pip install uwsgi supervisor-stdout
WORKDIR /var/app

ADD requirements.txt /var/app/
RUN pip install -r requirements.txt

RUN mkdir -p /var/app/configs
ADD ./configs /var/app/configs
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
RUN cp /var/app/configs/supervisord.conf /etc/supervisor/
RUN cp /var/app/configs/nginx.conf /etc/nginx/
RUN ln -s /var/app/configs/nginx-app.conf /etc/nginx/sites-enabled/
RUN ln -s /var/app/configs/supervisor-app.conf /etc/supervisor/conf.d/


# Copy the rest of the code later to take advantage of Dockers cache
ADD . /var/app


EXPOSE 8001
CMD ["supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
