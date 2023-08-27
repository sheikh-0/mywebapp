<<<<<<< HEAD
FROM nginx:1.25.1
=======
FROM python:3.9
WORKDIR /opt/docker
COPY *.py /opt/docker/
COPY templates/ /opt/docker/templates
RUN pip install gunicorn
CMD ["gunicorn", "server:app", "--reload" ]
EXPOSE 8000
>>>>>>> 8dc12dd0c1b0ad11ba1252f23a01ebbceaed90e1
 
