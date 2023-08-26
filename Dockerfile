FROM python:3.9
WORKDIR /opt/docker
COPY *.py /opt/docker/
COPY templates/ /opt/docker/templates
RUN pip install gunicorn
CMD ["gunicorn", "server:app", "--reload" ]
EXPOSE 80
 
