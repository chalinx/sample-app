FROM python
RUN pip install flask gunicorn
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
WORKDIR /home/myapp
EXPOSE 5050
CMD gunicorn -w 4 -b 0.0.0.0:5050 sample_app:sample
